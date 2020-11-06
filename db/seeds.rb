require "nokogiri"
require "open-uri"


# Scrapping extraits cosmétiques AZ
file1 = "db/extraits_naturels.html"
doc_ext= Nokogiri::HTML(open(file1))
extraits = doc_ext.search(".product-title")

extraits.each do |extrait|

  part1 = extrait.search("h3")
  part2 = extrait.search(".product-link")
  full_name = part1.text.strip + " " + part2.text.strip
  puts "Create #{full_name}"
  ingredient = Ingredient.new(name: full_name)
  ingredient.save!
  puts "Next"
end

# Scrapping ingrédients naturels AZ
file2 = "db/ingredients_cosmetiques.html"
doc_ing = Nokogiri::HTML(open(file2))
ingredients = doc_ing.search(".product-title")

ingredients.each do |ingredient|
  part1 = ingredient.search("h3")
  part2 = ingredient.search(".product-link")
  full_name = part1.text.strip + " " + part2.text.strip
  puts "Create #{full_name}"
  ingredient = Ingredient.new(name: full_name)
  ingredient.save!
  puts "Next"
end

