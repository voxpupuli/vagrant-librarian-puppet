module VagrantPlugins
  module LibrarianPuppet
    class Config < Vagrant.plugin(2, :config)
      attr_accessor :puppetfile_dir
      attr_accessor :placeholder_filename

      def initialize
        @puppetfile_dir = UNSET_VALUE
        @placeholder_filename = UNSET_VALUE
      end

      def finalize!
        @puppetfile_dir = '.' if @puppetfile_dir == UNSET_VALUE
        @placeholder_filename = '.PLACEHOLDER' if @placeholder_filename == UNSET_VALUE
      end

      def puppetfile_path
        @puppetfile_path ||= @puppetfile_dir ? File.join(@puppetfile_dir, 'Puppetfile') : 'Puppetfile'
      end

    end
  end
end
