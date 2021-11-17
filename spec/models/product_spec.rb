require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "Should save the new product if all validations pass" do
      @category = Category.new(name: "Sporting Goods")
      @product = Product.new(name: "Soccer Ball", price_cents: "8000", quantity: 8, category: @category) 
      @product.valid? 
      expect(@product.errors).not_to include("can't be blank")
    end 
    it "Should fail to save a new product if name is missing" do
      @category = Category.new(name: "Sporting Goods")
      @product = Product.new(price_cents: "8000", quantity: 8, category: @category) 
      @product.valid? 
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end 
    it "Should fail to save a new product if quantity is missing" do
      @category = Category.new(name: "Sporting Goods")
      @product = Product.new(name: "Soccer Ball", price_cents: "8000", category: @category)  
      @product.valid? 
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end 
    it "Should fail to save a new product if price is missing" do
      @category = Category.new(name: "Sporting Goods")
      @product = Product.new(name: "Soccer Ball", quantity: 8, category: @category) 
      @product.valid? 
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end 
    it "Should fail to save a new product if category is missing" do
      @category = Category.new(name: "Sporting Goods")
      @product = Product.new(name: "Soccer Ball", price_cents: "8000", quantity: 8) 
      @product.valid? 
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end 
  end
end