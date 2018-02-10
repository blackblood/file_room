require 'rails/generators/migration'

module FileRoom
	module Generators
		class FileRoomGenerator < ::Rails::Generators::Base
			include Rails::Generators::Base
			source_root File.expand_path("../templates",__FILE__)

			def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template "create_method_call_entries.rb", "db/migrate/create_method_call_entries.rb"
      end
		end
	end
end