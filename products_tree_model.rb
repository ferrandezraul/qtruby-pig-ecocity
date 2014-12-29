require 'product_tree_item'

class ProductsTreeModel < Qt::AbstractItemModel
	
	def initialize( data, parent = nil )
    super( parent )
    root_data = []
    root_data << 'Nom' << 'Descripcio'
    @root_item = ProductTreeItem.new( root_data )
    setupModelData( data.to_s.split("\n"), @root_item )
	end
	
	def column_count(parent)
    if parent.valid?
      parent.internalPointer.columnCount
    else
      @root_item.columnCount
		end
  end

  # Need to overwrite columnCount but want to follow ruby coding style
  alias :columnCount :column_count
	
	def data(index, role)
    if !index.valid?
	    return Qt::Variant.new
		end
	
	  if role != Qt::DisplayRole
	    return Qt::Variant.new
		end
	
    item = index.internalPointer
    item.data(index.column)
	end
	
	def flags(index)
	  return Qt::ItemIsEnabled if !index.valid?
	
	  Qt::ItemIsEnabled | Qt::ItemIsSelectable
	end
	
	def header_data( section, orientation, role )
	  if orientation == Qt::Horizontal && role == Qt::DisplayRole
	    return Qt::Variant.new(@root_item.data(section))
		end
	
	  Qt::Variant.new
  end

  alias :headerData :header_data
	
	def index(row, column, parent)
	  if !parent.valid?
	    parent_item = @root_item
	  else
	    parent_item = parent.internalPointer
		end
	
	  @child_item = parent_item.child(row)
	  if !@child_item.nil?
	    createIndex(row, column, @child_item)
	  else
	    Qt::ModelIndex.new
		end
	end
	
	def parent(index)
	  return Qt::ModelIndex.new if !index.valid?
	
    child_item = index.internalPointer
    parent_item = child_item.parent
	

	  return Qt::ModelIndex.new if parent_item == @root_item
	
	  createIndex(parent_item.row, 0, parent_item)
	end
	
	def row_count( parent )
	  if !parent.valid?
	    parent_item = @root_item
	  else
	    parent_item = parent.internalPointer
		end
	
	  parent_item.childCount
  end

  alias :rowCount :row_count
	
	def setup_model_data(lines, parent)
    parents = []
    indentations = []
    parents << parent
    indentations << 0

    number = 0

    while number < lines.length
      position = 0
      while position < lines[number].length
        if lines[number][position, 1] != " "
          break
        end
        position += 1
      end

      line_data = lines[number][position, lines[number].length].strip

      if !line_data.empty?
      # Read the column data from the rest of the line.
      column_strings = line_data.split("\t").delete_if {|item| item == ""}
      column_data = []
      for column in 0...column_strings.length
        column_data << column_strings[column]
      end

      if position > indentations.last
        # The last child of the current parent is now the parent.new
        # unless the current parent has no children.
        if parents.last.childCount > 0
          parents << parents.last.child(parents.last.childCount - 1)
          indentations << position
        end
      else
        while position < indentations.last && parents.length > 0
          parents.pop
          indentations.pop
        end
      end

      # Append a item.new to the current parent's list of children.
      parents.last.appendChild(ProductTreeItem.new(column_data, parents.last))
    end
	
	  number += 1
	  end
  end

  alias :setupModelData :setup_model_data
end
