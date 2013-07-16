module VagrantPlugins
  module LibrarianPuppet
    class Config < Vagrant.plugin(2, :config)
      attr_accessor :librarian_dir

      def initialize
        @librarian_dir = UNSET_VALUE
      end

      def finalize!
        @librarian_dir = "." if @librarian_dir == UNSET_VALUE
      end

      def puppetfile_path
        @puppetfile_path ||= @librarian_dir ? File.join(@librarian_dir, 'Puppetfile') : 'Puppetfile'
      end

    end
  end
end
