# frozen_string_literal: true

Decidim.seed!

[
{ca: "Fi de la pobresa", en: "End poverty", es: "Fin de la pobreza"},
{ca: "Fam zero", en: "End hunger", es: "Hamber cero"},
{ca: "Salut i benestar", en: "Health and well-being", es: "Salud y bienestar"},
{ca: "Educació de qualitat", en: "Quality education", es: "Educación de calidad"},
{ca: "Igualtat de gènere", en: "Gender equality", es: "Igualdad de género"},
{ca: "Aigua neta i sanejament", en: "Clean water and sanitation", es: "Agua limpia y saneamiento"},
{ca: "Energia neta i assequible", en: "Affordable and clean energy", es: "Energia limpia y asequible"},
{ca: "Treball decent i creixement econòmic", en: "Decent work and economic growth", es: "Trabajo decente y crecimiento económico"},
{ca: "Indústria, innovació i infraestructures", en: "Industry, innovation and infrastructure", es: "Indústria, innovación e infraestructuras"},
{ca: "Reducció de les desigualtats", en: "Reduced inequalities", es: "Reducción de las desigualdades"},
{ca: "Ciutats i comunitats sostenibles", en: "Sustainable cities and communities", es: "Ciudades y comunidades sostenibles"},
{ca: "Consum i producció responsables", en: "Responsible production and consumption", es: "Consumo i producción responsables"},
{ca: "Acció climàtica", en: "Climate action", es: "Acción climática"},
{ca: "Vida submarina", en: "Life below water", es: "Vida submarina"},
{ca: "Vida d'ecosistemes terrestres", en: "Life on land", es: "Vida de ecosistemas terrestres"},
{ca: "Pau, justícia i institucions sòlides", en: "Peace, justice and strong institutions", es: "Paz, justícia e instituciones fuertes"},
{ca: "Aliança per a assolir els objectius", en: "Peace, justice and strong institutions", es: "Alianza para conseguir los objetivos"}].each do |ods| SDGoal.create(name: ods) end













