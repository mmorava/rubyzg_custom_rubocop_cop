# frozen_string_literal: true
require_relative '../../../../rubocop/cop/custom/enforce_int_primary_key'

describe RuboCop::Cop::Custom::EnforceIntPrimaryKey do
  subject(:cop) { described_class.new(config) }
  let(:config) { RuboCop::Config.new }

  it 'does not register an offense if id is set to an integer' do
    expect_no_offenses <<~RUBY
      create_table :some_table_name, id: :integer
    RUBY
  end

  context 'when create table is called with options argument' do
    it 'registers an offense if id field type is not set to the integer' do
      expect_offense <<~RUBY
        create_table :some_table_name, primary_key: :some_id
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use an integer field type for id column when creating a new table.
      RUBY
    end

    it 'registers an offense if table name is a string' do
      expect_offense <<~RUBY
        create_table "some_table_name", primary_key: :some_id
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use an integer field type for id column when creating a new table.
      RUBY
    end
  end

  context 'when create table is called without and options argument' do
    it 'registers an offense if id field type is not set to the integer' do
      expect_offense <<-RUBY
        create_table :some_table_name do |t|
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use an integer field type for id column when creating a new table.
          t.string :name
          t.string :email
        end
      RUBY
    end

    it 'registers an offense if table name is a string' do
      expect_offense <<-RUBY
        create_table "some_table_name" do |t|
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Use an integer field type for id column when creating a new table.
          t.string :name
          t.string :email
        end
      RUBY
    end
  end
end