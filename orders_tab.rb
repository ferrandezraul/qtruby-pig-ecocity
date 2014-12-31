require 'date_dialog'

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
    #Qt::MessageBox::information( self, tr( 'New order dialog!' ), 'New order')
    date = DateDialog.new(self)

    if date.exec == 1  # if user accepted the dialog
      Qt::MessageBox::information( self, tr( 'foo' ), "Returned #{date.get_date}")
    end

  end

end