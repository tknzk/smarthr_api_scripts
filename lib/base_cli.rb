class BaseCli < Thor
  include Thor::Actions

  class_option :subdomain, :type => :string
  class_option :api_token, :type => :string

  no_commands do

    def subdomain
      ENV['SMARTHR_SUBDOMAIN'] || options[:subdomain]
    end

    def api_token
      ENV['SMARTHR_API_TOKEn'] || options[:api_token]
    end

  end
end
