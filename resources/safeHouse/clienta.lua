-- Coordonnées des maisons
local maisons = {

   { x=-952.35943603516, y= -1077.5021972656, z=2.6772258281708},

   { x=-59.124889373779, y= -616.55456542969, z=37.356777191162},

   { x=-255.05390930176, y= -943.32885742188, z=31.219989776611},

   { x=-771.79888916016, y= 351.59423828125, z=87.998191833496},

 }

-- Créations des blips pour toutes les maisons
for _, maison in pairs(maisons) do

  maison.blip = AddBlipForCoord(maison.x, maison.y, maison.z)
  SetBlipSprite(maison.blip, 350);
  SetBlipAsShortRange(maison.blip, true);
  
end
