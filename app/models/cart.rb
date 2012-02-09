class Cart < ActiveRecord::Base

belongs_to :product
belongs_to :product, :class_name => "Product", :foreign_key => "product_id"
attr_reader :items
	
	def initialize
		@items = []
	end
	
	def add_product(product)
		current_item = @items.find { |item| item.product == product}
		if current_item
			current_item.increment_quantity
	     else
			#current_item = CartItem.new(product)
			@items << CartItem.new(product)
		end
		#current_item
	end

def total_price
@items.sum {|item| item.price}
end

def remove_product(product)
current_item = @items.find { |item| item.product == product}
if current_item
 @items.delete(current_item)
end
end

end
