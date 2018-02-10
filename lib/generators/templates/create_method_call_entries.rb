class CreateMethodCallEntries < ActiveRecord::Migration
	def change
		create_table :method_call_entries do |t|
			t.string :class_name
			t.string :method_name
			t.json :args
			t.created_at :datetime
		end
	end
end