class ProductsTab < Qt::Widget

  def initialize( parent = nil )
    super(parent)

    label = Qt::Label.new( tr('Productes' ) )


    self.layout = Qt::VBoxLayout.new do |m|
      m.addWidget( label )
      m.addStretch( 1 )
    end

  end
end