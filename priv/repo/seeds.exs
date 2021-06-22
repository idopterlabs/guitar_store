# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#

alias GuitarStore.Inventory

Inventory.create_guitar(%{
  make: "Gibson",
  model: "Les Paul",
  year: 1968
})

Inventory.create_guitar(%{
  make: "Fender",
  model: "Stratocaster",
  year: 1997
})

Inventory.create_guitar(%{
  make: "Solar",
  model: "AT1.6B",
  year: 2021
})
