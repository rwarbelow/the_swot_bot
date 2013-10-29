require 'spec_helper'

describe "Schema Migrations" do
  c = ActiveRecord::Base.connection
  c.tables.collect do |t|
    describe "#{t} table" do
      columns = c.columns(t).collect(&:name).select {|x| x.ends_with?("_id" || x.ends_with("_type"))}
      indexed_columns = c.indexes(t).collect(&:columns).flatten.uniq
      columns.each do |column|
        it "should have foreign key index on #{column}" do
          indexed_columns.should include(column)
        end
      end
    end
  end
end
