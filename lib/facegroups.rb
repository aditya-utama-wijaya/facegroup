# frozen_string_literal: true

files = Dir.glob(File.join(File.dirname(__FILE__), 'facegroups/*.rb'))
files.each { |lib| require_relative lib }
