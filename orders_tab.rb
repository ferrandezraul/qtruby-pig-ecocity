require 'date_dialog'
require 'customer_dialog'

class OrdersTab < Qt::Widget

  slots 'new_order()'

  def initialize( orders_model, parent = nil )
    super(parent)

    button = Qt::PushButton.new( tr( 'Nova comanda' ) )
    view = Qt::TreeView.new
    view.model = orders_model
    view.windowTitle = 'Orders Tree Model'
    view.show

    self.layout = Qt::VBoxLayout.new do |m|
      m.addWidget( button )
      m.addWidget( view )

      # Add spacer
      #m.addStretch( 1 )
    end

    connect( button, SIGNAL( 'clicked()' ), self, SLOT( 'new_order()' ) )

  end

  def new_order
    date = get_date
    #customer = get_customer
    #line_items = get_line_items
  end

  def get_date
    date_dialog = DateDialog.new(self)
    if date_dialog.exec == 1  # if user accepted the dialog
      Qt::MessageBox::information( self, tr( 'foo' ), "Returned #{date_dialog.get_date.toString}")

      date_dialog.get_date
    else
      Qt::Date.new
    end
  end

  def get_customer
    customer_dialog = CustomerDialog.new(self)
    if customer_dialog.exec == 1  # if user accepted the dialog
      Qt::MessageBox::information( self, tr( 'foo' ), "Returned #{customer_dialog.get_customer.name}")
    end
  end

end