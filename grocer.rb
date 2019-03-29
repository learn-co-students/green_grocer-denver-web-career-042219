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
=begin
require 'pry'
def apply_coupons(cart, coupons)
binding.pry

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


    #  binding.pry

      if coupons_items.include?(item)
        coupons.find do |element| #using find here returns the correct price on the coupon item
          if element[:item] == item
            if item_hash[:count] >= element[:num] #check to see if there are more items than the coupon covers
                item_count = item_hash[:count]

                cart_coupon["#{item} W/ COUPON"] = {}
                cart_coupon["#{item} W/ COUPON"][:price] = element[:cost]
                cart_coupon["#{item} W/ COUPON"][:clearance] = item_hash[:clearance]
                cart_coupon["#{item} W/ COUPON"][:count] = 1

                item_count =  item_count - element[:num]

              if item_count > 0 # build a new key:value pair based on the remaining items
                  cart_coupon[item] = {}
                  cart_coupon[item][:price] = item_hash[:price]
                  cart_coupon[item][:clearance] = item_hash[:clearance]
                  cart_coupon[item][:count] = item_count
                  item_count = 0
                end
              end
            if item_hash[:count] < element[:num]
              cart_coupon[item] = item_hash
            end

          end
        end
      end

    puts cart_coupon
    return cart_coupon
      end
end
=end

#man that was a doozy, applied what I learned from other labs to create and modify the hashes.
#a space in the w/coupon sent me on a goose chase for a while
#interesting to think about how to structure and explore data structures, and what to plan for
# created an array which took the couopon item name and stored in array, once a coupon was removed that value was deleted.
# I think there is an easier way to do this but this does work, i could also just
require 'pry'
def apply_coupons(cart, coupons)

  coupons_items = Array.new
  original_cart = cart
  original_coupons = coupons

    coupons.each do |element| # grab each item name from the coupon hash
      coupons_items << element[:item]
    end

    cart.each do |item, item_hash|
      if !coupons_items.include?(item)
        cart[item] = item_hash
      end

      if coupons_items.include?(item)
        coupons.each do |element| #using find here returns the correct price on the coupon item

         if element[:item] == item && coupons_items.include?(item)

            if item_hash[:count] >= element[:num]
              coupons_items.delete_at(coupons.index(element)) #check to see if there are more items than the coupon covers
                item_count = item_hash[:count]
                cart_coupon = Hash.new
                cart_coupon["#{item} W/COUPON"] = {}
                cart_coupon["#{item} W/COUPON"][:price] = element[:cost]
                cart_coupon["#{item} W/COUPON"][:clearance] = item_hash[:clearance]
                cart_coupon["#{item} W/COUPON"][:count] = 1
                cart = cart.merge(cart_coupon)
                item_count =  item_count - element[:num]
            end

          #    binding.pry
            if item_count >= 0 # build a new key:value pair based on the remaining items and if the coupon array is empty
                cart[item] = {}
                cart[item][:price] = item_hash[:price]
                cart[item][:clearance] = item_hash[:clearance]
                cart[item][:count] = item_count
            end

            if cart[item][:count] > element[:num]  #I dont think this is the worst way but there is a better way
              coupons_items.delete_at(coupons.index(element))
              #could have recoreded how many coupons per food there were in the begining, then created
              # the new hashes with that info
              #modify the cart
              #might not need to change the non coupon hash
              cart["#{item} W/COUPON"][:count] = cart["#{item} W/COUPON"][:count] + 1
              item_count = item_count - element[:num]
              cart[item][:count] = cart[item][:count] - element[:num]
              #binding.pry
              #after this it goes back up to the top and resets the values
            end

          if item_hash[:count] < element[:num]
            cart[item] = item_hash
          end

        end
      end
    end
  end
  return cart
end



def apply_clearance(cart)

  discount = (1 - 0.2)
  cart.each do |item, item_hash|
    if item_hash[:clearance] == true
      item_hash[:price] = (item_hash[:price] * discount).round(2)
    end
  end
end



def checkout(cart, coupons)

  total = 0
  discount = (1- 0.1)

  consolidated = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated, coupons)
  clearance_cart = apply_clearance(coupon_cart)


    clearance_cart.each do |item|
      item_total = (item[1][:price] * item[1][:count])
      total = (total + item_total)
    #  binding.pry
    end

    if total > 100
      total = (total * discount).round(2)
    end
  #binding.pry
  puts total
  return total


end


=begin

def cart
  [
    {"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
    {"AVOCADO" => {:price => 3.00, :clearance => true}},
    {"KALE" => {:price => 3.00, :clearance => false}},
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


def coupons
[
  {:item=>"AVOCADO", :num=>2, :cost=>5.0, :place=>1},
  {:item=>"AVOCADO", :num=>2, :cost=>5.0, :place=>2}
]
end





=end
