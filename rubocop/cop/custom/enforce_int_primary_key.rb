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

        MSG = 'Use an integer field type for id column when creating a new table.'

        def_node_search :defines_id_field_as_integer?, <<-PATTERN
          (pair (sym :id) (sym :integer))
        PATTERN

        def on_send(node)
          return unless node.command?(:create_table)
          return if defines_id_field_as_integer?(node)

          add_offense(node)
        end
      end
    end
  end
end