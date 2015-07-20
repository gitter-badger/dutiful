require 'dutiful/application'
require 'dutiful/file'
require 'dutiful/version'
require 'optparse'
require 'tomlrb'

module Dutiful
  class Runner
    def self.parse_command(options)
      ARGV << '-h' if ARGV.empty?

      OptionParser.new do |opts|
        opts.banner = 'Usage: dutiful <command> [<options>]'

        opts.on('-b', '--backup', 'Backup all preference files') do
          puts 'Backing up...'
        end

        opts.on('-l', '--list', 'List all preference files') do
          Dir.foreach('db') do |filename|
            next if filename == '.' or filename == '..'

            application = Dutiful::Application.new "db/#{filename}"
            puts application if application.exists?
          end
        end

        opts.on('-r', '--restore', 'Restore all preference files') do
          puts 'Restoring all preference files...'
        end

        opts.on('-w', '--which', 'Display the full path to a preference file') do
          puts 'Displaying preference file path...'
        end

        opts.on_tail('-h', '--help', 'Prints this help') do
          puts opts
          exit
        end

        opts.on_tail('-v', '--version', 'Show version') do
          puts VERSION
          exit
        end
      end.parse!
    end
  end
end
