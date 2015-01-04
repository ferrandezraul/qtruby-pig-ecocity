require 'Qt'

class ProductOptionsDialog < Qt::Dialog

  slots 'accept()', 'reject()',
        'update_selected_options(int)'

  def initialize( options, weight, parent = nil )
    super( parent )

    @weight = weight

    self.windowTitle = "Selecciona opcions fins #{weight} Kg"

    text_label = Qt::Label.new( "Selecciona opcions fins #{weight} Kg" )
    @label_weight_selected = Qt::Label.new( "Seleccionat 0 Kg" )

    @product_options_entries = options.map do |option|
      check_box = Qt::CheckBox.new( "#{option.quantity} x #{option.weight} #{option.name}", self )
      connect( check_box, SIGNAL('stateChanged(int)'), self, SLOT( 'update_selected_options(int)' ) )
      [ check_box, option]
    end

    @button_box = Qt::DialogButtonBox.new
    @button_box.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok

    self.layout = Qt::VBoxLayout.new do |g|
      g.addWidget(text_label)
      g.addWidget(@label_weight_selected)
      @product_options_entries.each do | checkbox, option |
        h_layout = Qt::HBoxLayout.new do |m|
          m.addWidget(checkbox)
        end
        g.addLayout(h_layout)
      end

      g.addWidget(@button_box)
    end

    connect(@button_box, SIGNAL('accepted()'), self, SLOT('accept()'))
    connect(@button_box, SIGNAL('rejected()'), self, SLOT('reject()'))
  end

  def update_selected_options( int )
    weight = get_selected_weight

    @label_weight_selected.setText( "Seleccionat #{weight} Kg" )

    if @weight > weight
      @button_box.setEnabled( false )
    else
      @button_box.setEnabled( true )
    end

  end

  def get_selected_options
    options_selected = Array.new

    @product_options_entries.map do |checkbox, option|
      options_selected << option if checkbox.checked?
    end

    options_selected
  end

  def get_selected_weight
    selected_options = get_selected_options

    total_weight = 0
    selected_options.each do | option |
      total_weight += option.weight.to_f
    end

    total_weight
  end

end

