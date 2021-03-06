require File.expand_path(File.dirname(__FILE__) + '../../../../spec_helper')

describe "ShoppingCart" do
  before(:each) do
    @cart = SomeCart.create
  end

  describe :add do
    it "adds an item" do
      @some_object = SomeClass.create
      @cart.add(@some_object, 100)
      @cart.cart_items(true).first.should_not be_nil
      @cart.cart_items(true).first.item.should == @some_object
    end

    context "add more of an item already in the cart" do
      it "increases the quantity of the item" do
        @some_object = SomeClass.create
        @cart.add(@some_object, 100)
        @cart.add(@some_object, 100, 2)

        @cart.cart_items.first.quantity.should == 3
      end
    end
  end

  describe :subtotal do
    it "has a subtotal" do
      @cart.should respond_to(:subtotal)
    end

    context "the cart has items" do
      before(:each) do
        @cart.add(SomeClass.create, 199.99, 2)
        @cart.add(SomeClass.create, 299.99)
      end

      it "should return the sum of the item prices" do
        @cart.subtotal.should == 699.97
      end
    end

    context "the cart has no item" do
      it "should return 0" do
        @cart.subtotal == 0
      end
    end
  end
  
  describe :total do
    it "has a total" do
      @cart.should respond_to(:total)
    end

    context "the cart has items" do
      before(:each) do
        @cart.add(SomeClass.create, 199.99, 2)
        @cart.add(SomeClass.create, 299.99)
      end
      
      context "the cart has taxes"  do
        before(:each) do
          @cart.taxes = 12.99
        end
      
        context "the cart has shipping cost" do
          before(:each) do
            @cart.shipping_cost = 3.99
          end
          
          it "should return the sum of the item prices, taxes and shipping cost" do
            @cart.total.should == 716.95
          end
        end
        
        context "the cart hasn't shipping cost" do
          it "should return the sum of the item prices and taxes" do
            @cart.total.should == 712.96
          end
        end
      end
      
      context "the cart hasn't taxes" do
        context "the cart has shipping cost" do
          before(:each) do
            @cart.shipping_cost = 3.99
          end
          
          it "should return the sum of item prices and shipping cost" do
            @cart.total.should == 703.96
          end
        end
        
        context "the cart hasn't shipping cost" do
          it "should return the sum of the item prices" do
            @cart.total.should == 699.97
          end
        end
      end
    end

    context "the cart has no item" do
      context "the cart has taxes"  do
        before(:each) do
          @cart.taxes = 12.99
        end
      
        context "the cart has shipping cost" do
          before(:each) do
            @cart.shipping_cost = 3.99
          end
          
          it "should return the sum of the item prices, taxes and shipping cost" do
            @cart.total.should == 16.98
          end
        end
        
        context "the cart hasn't shipping cost" do
          it "should return the sum of the item prices and taxes" do
            @cart.total.should == 12.99
          end
        end
      end
      
      context "the cart hasn't taxes" do
        context "the cart has shipping cost" do
          before(:each) do
            @cart.shipping_cost = 3.99
          end
          
          it "should return the sum of item prices and shipping cost" do
            @cart.total.should == 3.99
          end
        end
        
        context "the cart hasn't shipping cost" do
          it "should return 0" do
            @cart.total == 0
          end
        end
      end
    end
  end

  describe :delete do
    context "the cart has items" do
      before(:each) do
        @some_object = SomeClass.create
        @cart.add(@some_object, 199.99)
        @cart.add(SomeClass.create, 299.99)
      end

      it "removes the item from the cart" do
        @cart.remove(@some_object)
        @cart.cart_items.count.should == 1
        @cart.item_for(@some_object).should be_nil
      end
    end
  end

  describe :remove do
    context "the cart has items" do
      before(:each) do
        @some_object = SomeClass.create
        @cart.add(@some_object, 199.99)
        @cart.add(SomeClass.create, 299.99)
      end

      it "removes the item from the cart" do
        @cart.remove(@some_object)
        @cart.cart_items.count.should == 1
        @cart.item_for(@some_object).should be_nil
      end
    end

    context "remove some items" do
      before(:each) do
        @some_object = SomeClass.create
        @cart.add(@some_object, 199.99, 5)
        @cart.add(SomeClass.create, 299.99)
      end

      it "removes 2 items of the specific product" do
        @cart.remove(@some_object, 2)
        @cart.item_for(@some_object).should_not be_nil
        @cart.item_for(@some_object).quantity.should == 3
      end
    end

    context "the object is not on the cart" do
      before(:each) do
        @some_object = SomeClass.create
      end
      it "does nothing" do
        @cart.remove(@some_object)
      end
    end

    describe :total_unique_items do
      context "there are different items in the cart" do
        before(:each) do
          @cart.add(SomeClass.create, 100, 1)
          @cart.add(SomeClass.create, 100, 2)
          @cart.add(SomeClass.create, 100, 3)
        end

        it "returns the sum of all the item quantities" do
          @cart.total_unique_items.should == 6
        end
      end

      context "the cart has no items" do
        it "returns 0" do
          @cart.total_unique_items == 0
        end
      end
    end
  end
end

