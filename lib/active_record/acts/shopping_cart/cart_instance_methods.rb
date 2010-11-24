module ActiveRecord
  module Acts
    module ShoppingCart
      module InstanceMethods

        #
        # Returns the subtotal by summing the price times quantity for all the items in the cart
        #
        def subtotal
          ("%.2f" % cart_items.sum("price * quantity")).to_f
        end

        #
        # Returns the total by summing the subtotal, taxes and shipping_cost
        #
        def total
          total = subtotal
          total += taxes         if self.respond_to?(:taxes)
          total += shipping_cost if self.respond_to?(:shipping_cost)

          ("%.2f" % total).to_f
        end

        #
        # Adds a product to the cart
        #
        def add(object, price, quantity = 1)
          cart_item = item_for(object)

          unless cart_item
            cart_items.create(:item => object, :price => price, :quantity => quantity)
          else
            cart_item.quantity = (cart_item.quantity + quantity)
            cart_item.save
          end
        end

        #
        # Delete an item from the cart
        #
        def delete(object)
          cart_items.destroy(item_for(object))
        end

        #
        # Remove an item from the cart
        #
        def remove(object, quantity = 1)
          if cart_item = item_for(object)
            if cart_item.quantity <= quantity
              cart_items.delete(cart_item)
            else
              cart_item.quantity = (cart_item.quantity - quantity)
              cart_item.save
            end
          else
            false
          end
        end

        #
        # Return the number of unique items in the cart
        #
        def total_unique_items
          cart_items.sum(:quantity)
        end

        #
        # Cart items enumerable
        #
        def items
          cart_items
        end
      end
    end
  end
end

