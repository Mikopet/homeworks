# encoding: utf-8

#
# Készítsd el a Node osztályt.
#
# Az osztály példányainak :id, :value, :parent_id attribútumokkal kell rendelkezni.
#
# Valósítsd meg a következő osztály metódusokat:
#   Node.find_by_id(id)                   # A paraméterül kapott id-val rendelkező csúccsal tér vissza.
#   Node.find_all_by_parent_id(parent_id) # A paraméterül kapott parent_id-val rendelkező csúcsok tömbjével tér vissza.
#
# Valósítsd meg a következő példány metódusokat:
#   Node#parent               # A csúcs szülő csúcsával tér vissza. (pl.: a 3 értékű csúcs szülője az 1 értékű csúcs)
#   Node#children             # A csúcs gyermekeivel tér vissza. (pl.: a 3 értékű csúcs gyermekei az 5 és a 6 értékű csúcsok)
#   Node#descendants          # A csúcs összes leszármazottját tartalmazó tömbbel tér vissza. (pl.: a 3 értékű csúcs leszármazottai az 5, 6, 7 értékű csúcsok)
#   Node#self_and_descendants # A csúcsot és a csúcs összes leszármazottját tartalmazó tömbbel tér vissza.
#   Node#ancestors            # A csúcs összes felmenőjét tartalmazó tömbbel tér vissza. (pl.: a 4 értékű csúcs felmenői az 1, 2 értékű csúcsok)
#   Node#self_and_ancestors   # A csúcsot és a csúcs összes felmenőjét tartalmazó tömbbel tér vissza.
#   Node#siblings             # A csúcs testvéreit tartalmazó tömbbel tér vissza. (pl.: a 2 értésű csúcs testvére a 3 értékű csúcs)
#   Node#self_and_siblings    # A csúcsot és a csúcs testvéreit tartalmazó tömbbel tér vissza.

# A csúcsok (Node példányok) nyers adatai egy "adatbázis csonk" (DatabaseStub osztály) segítségével érhetőek el.
# A jelen feladatban nem cél az adatok módosítását lehetővé tenni, azaz az "adatbázisunkban szereplő adatok menet
# közben nem fognak változni.
#

class DatabaseStub
  #
  # A nyers adatokat visszaadó metódus.
  #
  def nodes
    [
      { id: 1, value: 1, parent_id: nil },
      { id: 2, value: 2, parent_id:   1 },
      { id: 3, value: 3, parent_id:   1 },
      { id: 4, value: 4, parent_id:   2 },
      { id: 5, value: 5, parent_id:   3 },
      { id: 6, value: 6, parent_id:   3 },
      { id: 7, value: 7, parent_id:   6 }
    ]
  end
end

#
# A megvalósított Node osztály segítségével fa adatszerkezetet lehet modellezni.
#
# A fenti adatokkal:
#
#                             +----------------+
#                             |        id:   1 |
#                             |     value:   1 |
#                             | parent_id: nil |
#                             +----------------+
#                               /            \
#                              /              \
#               +----------------+        +----------------+
#               |        id:   2 |        |        id:   3 |
#               |     value:   2 |        |     value:   3 |
#               | parent_id:   1 |        | parent_id:   1 |
#               +----------------+        +----------------+
#                  /                         /           \
#                 /                         /             \
#    +----------------+       +----------------+       +----------------+
#    |        id:   4 |       |        id:   5 |       |        id:   6 |
#    |     value:   4 |       |     value:   5 |       |     value:   6 |
#    | parent_id:   2 |       | parent_id:   3 |       | parent_id:   3 |
#    +----------------+       +----------------+       +----------------+
#                                                           /
#                                                          /
#                                            +----------------+
#                                            |        id:   7 |
#                                            |     value:   7 |
#                                            | parent_id:   6 |
#                                            +----------------+
#


class Node
  attr_reader :id, :value, :parent_id

  def initialize attributes={}
    attributes = attributes.transform_keys(&:to_sym)

    @id = attributes[:id]
    @value = attributes[:value]
    @parent_id = attributes[:parent_id]
  end

  class << self
    def find_by_id id
      # TODO
    end

    def find_all_by_parent_id parent_id
      # TODO
    end
  end

  def parent
    # TODO
  end

  def children
    # TODO
  end

  def descendants
    # TODO
  end

  def self_and_descendants
    # TODO
  end

  def ancestors
    # TODO
  end

  def self_and_ancestors
    # TODO
  end

  def siblings
    # TODO
  end

  def self_and_siblings
    # TODO
  end

  def == other
    [ :id, :value, :parent_id ].all? do |attribute_name|
      send(attribute_name) == other.send(attribute_name)
    end
  end
end
