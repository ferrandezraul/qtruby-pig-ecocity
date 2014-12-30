$:.unshift File.join( File.dirname( __FILE__ ), '.' )
$:.unshift File.join( File.dirname( __FILE__ ), 'lib' )

require 'Qt'
require 'mainwindow.rb'

require 'product'
require 'product_csv'
require 'product_helper'
require 'customer'
require 'customers_csv'
require 'customer_helper'

require 'logger'

ORDERS_JSON_PATH = ::File.join( File.dirname( __FILE__ ), "csv/orders.json" )
PRODUCTS_CSV_PATH = ::File.join( File.dirname( __FILE__ ), "csv/products.csv" )
CUSTOMERS_CSV_PATH = ::File.join( File.dirname( __FILE__ ), "csv/customers.csv" )
ORDERS_CSV_PATH = ::File.join( File.dirname( __FILE__ ), "csv/orders.csv" )


def load_products
  begin
    ProductCSV.read( PRODUCTS_CSV_PATH )
  rescue Errors::ProductCSVError => e
    alert e.message
  end
end

def load_customers
  begin
    CustomerCSV.read( CUSTOMERS_CSV_PATH )
  rescue Errors::CustomersCSVError => e
    alert e.message
  end
end

def load_orders(products, customers)
  begin
    OrderCSV.read( ORDERS_CSV_PATH, products, customers )
  rescue Errors::CustomersCSVError => e
    alert e.message
  end
end

$log = Logger.new('development.log', 'monthly')

products = load_products
customers = load_customers
#orders = load_orders(products, customers)
orders = []

app = Qt::Application.new( ARGV )
main_win = MainWindow.new( :products => products,
                           :customers => customers,
                           :orders => orders )
main_win.show
app.exec