# frozen_string_literal: true
require 'rake/testtask'

task default: :spec

namespace :credentials do
  require 'yaml'
  desc 'generate access_token to STDOUT'
  task :get_access_token do
    credentials = YAML.load(File.read('config/credentials.yml'))
    require_relative 'lib/fb_api'
    ENV['FBAPI_CLIENT_ID'] = credentials[:client_id]
    ENV['FBAPI_CLIENT_SECRET'] = credentials[:client_secret]

    puts "Access Token: #{FaceGroup::FbApi.access_token}"
  end
end

desc 'run tests'
task :spec do
  sh 'ruby spec/facegroup_spec.rb'
end

desc 'delete cassette fixtures'
task :wipe do
  sh 'rm spec/fixtures/cassettes/*.yml' do |ok, _|
    puts(ok ? 'Cassettes deleted' : 'No cassettes found')
  end
end

namespace :quality do
  desc 'run all quality checks'
  task all: [:rubocop, :flog, :flay]

  task :flog do
    sh 'flog lib/'
  end

  task :flay do
    sh 'flay lib/'
  end

  task :rubocop do
    sh 'rubocop'
  end
end
