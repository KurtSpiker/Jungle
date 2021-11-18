require 'rails_helper'

RSpec.feature "Click on a product to see its details", type: :feature, js: true do

  #SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

    scenario "Can click on one product and be redirected to product details page" do
      #ACT
      visit root_path

      # page.find(".pull-right",  match: :first).click
      page.all(".product .actions a")[0].click

      #to wait to take screen shot
      sleep 1

      # commented out b/c it's for debugging only
      save_screenshot

      # VERIFY
      expect(page).to have_css '.products-show'
      expect(page).to have_css("img[src*='apparel1.jpg']")
  end
end