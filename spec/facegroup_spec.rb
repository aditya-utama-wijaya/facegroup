# frozen_string_literal: true
require_relative 'spec_helper.rb'

describe 'FaceGroup specifications' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<ACCESS_TOKEN>') { CREDENTIALS[:access_token] }
    c.filter_sensitive_data('<ACCESS_TOKEN_ESCAPED>') do
      URI.escape(CREDENTIALS[:access_token])
    end
    c.filter_sensitive_data('<CLIENT_ID>') { CREDENTIALS[:client_id] }
    c.filter_sensitive_data('<CLIENT_SECRET>') { CREDENTIALS[:client_secret] }
  end

  before do
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes
    @posting_with_msg_id = FB_RESULT['posting']['id']
  end

  after do
    VCR.eject_cassette
  end

  describe 'FbApi Credentials' do
    it 'should be able to get a new access token with ENV credentials' do
      FaceGroup::FbApi.access_token.length.must_be :>, 0
    end

    it 'should be able to get a new access token with file credentials' do
      FaceGroup::FbApi.config = {
        client_id: CREDENTIALS[:client_id],
        client_secret: CREDENTIALS[:client_secret]
      }
      FaceGroup::FbApi.access_token.length.must_be :>, 0
    end
  end

  it 'should be able to open a Facebook Group' do
    group = FaceGroup::Group.find(
      id: CREDENTIALS[:group_id]
    )

    group.name.length.must_be :>, 0
  end

  it 'should get the latest feed from a group' do
    group = FaceGroup::Group.find(
      id: CREDENTIALS[:group_id]
    )

    feed = group.feed
    feed.count.must_be :>, 1
  end

  it 'should get basic information about postings on the feed' do
    group = FaceGroup::Group.find(
      id: CREDENTIALS[:group_id]
    )

    group.feed.postings.each do |posting|
      posting.id.wont_be_nil
      posting.updated_time.wont_be_nil
    end
  end

  it 'should find all parts of a full posting' do
    posting = FB_RESULT['posting']
    attachment = posting['attachment'].first
    retrieved = FaceGroup::Posting.find(id: posting['id'])

    retrieved.id.must_equal posting['id']
    retrieved.created_time.must_equal posting['created_time']
    retrieved.message.must_equal posting['message']
    retrieved.attachment.wont_be_nil
    retrieved.attachment.description.must_equal attachment['description']
    retrieved.attachment.url.must_match 'tutorialzine'
  end
end
