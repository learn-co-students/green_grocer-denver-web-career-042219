require 'pry'


#used a similar idea to what i learned on pigeon.  build the hash in steps.  since each key:value does not include an array
#I could use two.  Also nested a count incrementer to catch them before
def consolidate_cart(cart)
  cart_hash = Hash.new

  cart.each do |element|
    element.each do |item, item_hash|
      if cart_hash.has_key?(item)
        cart_hash[item][:count] = (cart_hash[item][:count] + 1)
      end

      item_hash.each do |k, v|
        if !cart_hash.has_key?(item)
          cart_hash[item] = {}
          cart_hash[item] = {:count => 1}
        end
        if !cart_hash[item].has_key?(k)
          cart_hash[item][k] = v
        end
      end
    end
  end
return cart_hash
end

#I think consolidate the cart first, bash up coupons, return a new hash

require 'pry'
def apply_coupons(cart, coupons)

cart_hash = Hash.new
#consolidate_cart first
  cart.each do |element|
    element.each do |item, item_hash|
      if cart_hash.has_key?(item)
        cart_hash[item][:count] = (cart_hash[item][:count] + 1)
      end
      item_hash.each do |k, v|
        if !cart_hash.has_key?(item)
          cart_hash[item] = {}
          cart_hash[item] = {:count => 1}
        end
        if !cart_hash[item].has_key?(k)
          cart_hash[item][k] = v
        end
      end
    end
  end

  #compare and find any item matches
  #compare the coupon to the cart or cart to coupon
  # copy the coupon Item array
  cart_coupon = Hash.new
  coupons_items = Array.new

    coupons.each do |element| # grab each item name from the coupon hash
      coupons_items << element[:item]
    end

    cart_hash.each do |item, item_hash|
      if !coupons_items.include?(item)
        cart_coupon[item] = item_hash
      end

      if coupons_items.include?(item)
        item_hash.each do |item_k, item_v|
          coupons.each do |element|
            element.each do |coupon_k, coupon_v|
              if item_hash[:count] > element[:num]

              end 



        binding.pry
      end
      end
      end
      end

    end
puts cart_coupon
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end


=begin
def cart
  [
    {"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
    {"KALE" => {:price => 3.00, :clearance => false}},
    {"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
    {"ALMONDS" => {:price => 9.00, :clearance => false}},
    {"TEMPEH" => {:price => 3.00, :clearance => true}},
    {"CHEESE" => {:price => 6.50, :clearance => false}},
    {"BEER" => {:price => 13.00, :clearance => false}},
    {"BEETS" => {:price => 2.50, :clearance => false}},
    {"SOY MILK" => {:price => 4.50, :clearance => true}},
    {"KALE" => {:price => 3.00, :clearance => false}}
  ]
end


def coupons
[
	{:item => "AVOCADO", :num => 2, :cost => 5.00},
	{:item => "BEER", :num => 2, :cost => 20.00},
	{:item => "CHEESE", :num => 3, :cost => 15.00}
 ]
end

def cart_hash_3
{
  "AVOCADO"=>{:count=>3, :price=>3.0, :clearance=>true},
 "KALE"=>{:count=>2, :price=>3.0, :clearance=>false},
 "BLACK_BEANS"=>{:count=>1, :price=>2.5, :clearance=>false},
 "ALMONDS"=>{:count=>1, :price=>9.0, :clearance=>false},
 "TEMPEH"=>{:count=>1, :price=>3.0, :clearance=>true},
 "CHEESE"=>{:count=>1, :price=>6.5, :clearance=>false},
 "BEER"=>{:count=>1, :price=>13.0, :clearance=>false},
 "PEANUTBUTTER"=>{:count=>1, :price=>3.0, :clearance=>true},
 "BEETS"=>{:count=>1, :price=>2.5, :clearance=>false},
 "SOY MILK"=>{:count=>1, :price=>4.5, :clearance=>true}
}
end





def cart
[
  {"KALE" => {:price => 3.00, :clearance => false}},
  {"KALE" => {:price => 3.00, :clearance => false}}
]
end

def coupons
[
	{:item => "AVOCADO", :num => 2, :cost => 5.00},
	{:item => "BEER", :num => 2, :cost => 20.00},
	{:item => "CHEESE", :num => 3, :cost => 15.00}
 ]
end





=end
