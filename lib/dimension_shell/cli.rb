require 'yaml'

require 'thor'
require 'configatron'

require 'dimension_shell/cloud_control'

module DimensionShell
  class Cli < Thor
    default_options = {
      %w(region -r) => :string,
      %w(organization -o) => :string,
      %w(username -u) => :string,
      %w(password -p) => :string,
    }

    desc 'connect SERVERNAME', 'connects to the server called SERVERNAME'
    options default_options
    option :shell_user, type: :string, aliases: '-s'
    def connect(servername)
      _init_command(options)
      shell_user = options[:shell_user] || configatron.shell_user || 'root'

      result = @cloud_control.get_server servername

      if result[:failure] then
        _api_access_failed result
      elsif result['totalCount'] != 1 then
        _puts %Q(No servername matched to "#{servername}".)
      else
        server = result['server'].first
        primary_ipv6 = server['networkInfo']['primaryNic']['ipv6']
        puts "Server \"#{servername}\" found, opening secure shell to #{shell_user}@#{primary_ipv6}."
        Kernel.exec("ssh #{shell_user}@#{primary_ipv6}")
      end
    end

    options default_options
  private
    def _get_config_path
      File.join(Dir.home, 'dsh.yml')
    end

    def _load_config_hash
      if File.readable?(_get_config_path)
        YAML.load_file(_get_config_path)
      else
        {}
      end
    end

    def _init_configuration
      configatron.configure_from_hash(_load_config_hash)
    end

    def _init_command(options)
      _init_configuration
      @cloud_control = CloudControl.new({
          region:       options[:region]       || configatron.region,
          organization: options[:organization] || configatron.organization,
          username:     options[:username]     || configatron.username,
          password:     options[:password]     || configatron.password
        })
    end

    def _puts(*args)
      puts args.unshift('dsh: ').join()
    end

    def _api_access_failed(result)
      _puts %Q(API access failed: #{result[:failure]})
    end
  end

  DimensionShell::Cli.start
end
