class ProductTreeItem
	attr_reader :child_items

	def initialize(data, parent = nil)
	  @parent_item = parent
	  @item_data = data
		@child_items = []
	end
	
	def append_child(item)
	  @child_items.push(item)
  end

  alias :appendChild :append_child
	
	def child(row)
	  @child_items[row]
	end
	
	def child_count
	  @child_items.length
  end

  alias :childCount :child_count
	
	def column_count
	  @item_data.length
  end

  alias :columnCount :column_count
	
	def data( column )
    case column
      when 0
        Qt::Variant.new( @item_data[column].to_s )
      when 1
        Qt::Variant.new( @item_data[column].to_f )
      when 6
        Qt::Variant.new( @item_data[column] )
      else
        Qt::Variant.new( @item_data[column] )
    end
	end
	
	def parent
	  @parent_item
	end
	
	def row
	  return @parent_item.child_items.index(self) if !@parent_item.nil?
	
	  0
	end
end
