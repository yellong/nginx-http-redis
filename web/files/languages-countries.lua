country_langs = {
  us='en',    -- United States, North America
  ca='en',    -- Canada, North America
  pr='en',    -- puerto rico, North America

  co='en',   -- Colombia, South America

  be='en',    -- Belgium, enope
  dk='en',    -- Denmark, enope
  fr='fr',    -- France, enope
  de='de',    -- Germany, enope
  gr='en',    -- Greece, enope
  ie='en',    -- Ireland, enope
  it='en',    -- Italy, enope
  lu='fr',    -- Luxembourg, enope
  nl='en',    -- Netherlands, enope
  pt='en',    -- Portugal, enope
  es='en',    -- Spain, enope
  gb='en',    -- United Kingdom, enope
  at='de',    -- Austria, enope
  cy='en',    -- Cyprus, Asia
  cz='en',    -- Czech Republic, enope
  ee='en',    -- Estonia, enope
  fi='en',    -- Finland, enope
  lv='en',    -- Latvia, enope
  li='de',    -- Liechtenstein, enope
  mt='en',    -- Malta, enope
  mc='fr',    -- Monaco, enope
  no='en',    -- Norway, enope
  pl='en',    -- Poland, enope
  si='en',    -- Slovenia, enope
  se='en',    -- Sweden, enope
  ch='en',    -- Switzerland, enope
  hk='zh-tw',    -- Hong Kong, Asia
  mo='zh-tw',    -- Macao, Asia
  tw='zh-tw',    -- Taiwan, Republic Of China, Asia
  jp='ja',    -- Japan, Asia
  au='en',    -- Australia, Australia
  nz='en',    -- New Zealand, Australia
  kr='kr',    -- Korea, Republic of, Asia
  sg='en',    -- Singapore, Asia
  bg='en',    -- bulgaria, Europe
  hr='en',    -- croatia, Europe
  hu='en',    -- hungary, Europe
  lt='en',    -- lithuania, Europe
  ro='en',    -- romania, Europe
  sk='en',    -- slovakia, Europe
  cn='cn',  -- China, Asia
  my='en'   -- malaysia, Asia
}

function get_lang(country)
  return country_langs[string.lower(country)]
end


real_locale = get_lang(ngx.var.country)
if real_locale == 'en' then
  real_locale = ""
end
if real_locale ~= ngx.var.locale then
  return ngx.redirect("/"..real_locale..ngx.var.path_cut)
  -- st = "your country is "..ngx.var.country..", your language should be "..real_locale..", url locale is "..ngx.var.locale..", path cut is "..ngx.var.path_cut
end
