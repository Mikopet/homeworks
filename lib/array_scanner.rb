# encoding: utf-8

class ArrayScanner
  attr_reader :array

  #
  # Tedd lehetővé az osztály példányosítása során egy tömb (array) példány változóként történő beállítását.
  #
  def initialize array
    @array = array
  end

  #
  # Készíts egy olyan asszociatív tömböt (Hash-t), aminek két kulcsa van a következőknek megfelelően:
  # { :paros => [ ... ], :paratlan => [ ... ] }
  # A :paros kulcshoz kapcsolódó tömbbe a példányosítás során megadott tömbben (az objektum array változójában) szereplő páros számokat, a :paratlan kulcshoz kapcsolódó tömbbe a példányosítás során megadott tömbben (az objektum array változójában) szereplő páratlan számokat kellene összegyűjteni.
  #
  def even_and_odd_numbers
    even = array.select(&:even?)
    odd = array.select(&:odd?)

    { paros: even, paratlan: odd }
  end

  #
  # Keresd meg a példányosítás során megadott tömbnek (az objektum array változójának) maximális értékű, páratlan elemét.
  # Ha nincs a tömbben páratlan szám, akkor a visszatérési érték legyen 0.
  #
  def maximal_odd_number
    even_and_odd_numbers[:paratlan].max || 0
  end

  #
  # Igaz az az állítás, miszerint a példányosítás során megadott tömbnek (az objektum array változójának) minden eleme osztható 3-mal?
  #
  def all_numbers_are_dividable_by_3
    !array.detect { |n| n % 3 != 0 }
  end

  #
  # Definiálj egy olyan metódust, ami
  # * paraméterül kap egy pozitív egész számot (center) és
  # * előállít egy olyan (Hash) adatszerkezetet, ami tartalmazza, hogy a center változóban megadott szám (radius) 5 sugarú környezetében és a példányosítás során megadott tömbben (az objektum array változójában) is szereplő számok közül melyik hányszor szerepelt.
  #
  def neighborhood_of_point center
    radius = 5
    # TODO
  end
end
