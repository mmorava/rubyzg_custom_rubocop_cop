# frozen_string_literal: true

module RuboCop
  module Cop
    module Custom
      class EnforceIntPrimaryKey < Cop
        # Rails 5.1 and newer use bigint as a id field type by default
        # In Smart we want to keep using integers
        # It is not possible to override Rails default so we are using this Cop to enforce using integer
        #
        # #bad
        # create_table :something do |t|
        #    ...
        #    ...
        # end
        #
        # #good
        #
        # create_table :something, id: :integer do |t|
        #    ...
        #    ...
        # end
      end
    end
  end
end