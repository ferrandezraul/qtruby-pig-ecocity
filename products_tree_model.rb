require 'product_tree_item'

class ProductsTreeModel < Qt::AbstractItemModel
	
	def initialize( products, parent = nil )
    super( parent )
    root_data = []
    root_data << 'Nom' << 'Preu Tenda' << 'Preu Coope' << 'Preu PVP' << 'Tipus' << 'IVA' << 'Pes/un'
    @root_item = ProductTreeItem.new( root_data )
    setupModelData( products, @root_item )
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
	
	def setup_model_data( products, parent )

    products.each do | product |
      product_columns_data = [ product.name,
                               product.price_tienda,
                               product.price_coope,
                               product.price_pvp,
                               product.price_type,
                               product.iva,
                               product.weight_per_unit ]

      product_item = ProductTreeItem.new( product_columns_data, parent )

      if product.has_options?
        product.options.each do | option |
          product_item.appendChild( ProductTreeItem.new( [ option.to_s ], product_item ) )
        end
      end

      parent.appendChild( product_item )

    end

  end

  alias :setupModelData :setup_model_data

end
