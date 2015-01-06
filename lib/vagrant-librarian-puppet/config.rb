module VagrantPlugins
  module LibrarianPuppet
    class Config < Vagrant.plugin(2, :config)
      attr_accessor :puppetfile_dir
      attr_accessor :use_v1_api
      attr_accessor :destructive
      attr_accessor :placeholder_filename
      attr_accessor :resolve_options

      def initialize
        @puppetfile_dir = UNSET_VALUE
        @placeholder_filename = UNSET_VALUE
        @use_v1_api = UNSET_VALUE
        @destructive = UNSET_VALUE
        @resolve_options = UNSET_VALUE
      end

      def finalize!
        @puppetfile_dir = '.' if @puppetfile_dir == UNSET_VALUE
        @placeholder_filename = '.PLACEHOLDER' if @placeholder_filename == UNSET_VALUE
        @resolve_options = {} if @resolve_options == UNSET_VALUE
        @use_v1_api = '1' if @use_v1_api == UNSET_VALUE
        @destructive = true if @destructive == UNSET_VALUE
      end

      def validate(machine)
        errors = []
        if not @resolve_options.kind_of?(Hash)
          errors << '`resolve_options` must be a hash'
        end
        return { 'vagrant-librarian-puppet' => errors }
      end

      def puppetfile_path
        @puppetfile_path ||= @puppetfile_dir ? File.join(@puppetfile_dir, 'Puppetfile') : 'Puppetfile'
      end

      def use_v1_api
        @use_v1_api ||= '1'
      end

      def destruct
        @destruct ||= true
      end


    end
  end
end
