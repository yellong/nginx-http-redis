country_langs = {
  us='',    -- United States, North America
  ca='',    -- Canada, North America
  pr='',    -- puerto rico, North America
  co='',   -- Colombia, South America
  be='',    -- Belgium, enope
  dk='',    -- Denmark, enope
  fr='fr',    -- France, enope
  de='de',    -- Germany, enope
  gr='',    -- Greece, enope
  ie='',    -- Ireland, enope
  it='',    -- Italy, enope
  lu='fr',    -- Luxembourg, enope
  nl='',    -- Netherlands, enope
  pt='',    -- Portugal, enope
  es='',    -- Spain, enope
  gb='',    -- United Kingdom, enope
  at='de',    -- Austria, enope
  cy='',    -- Cyprus, Asia
  cz='',    -- Czech Republic, enope
  ee='',    -- Estonia, enope
  fi='',    -- Finland, enope
  lv='',    -- Latvia, enope
  li='de',    -- Liechtenstein, enope
  mt='',    -- Malta, enope
  mc='fr',    -- Monaco, enope
  no='',    -- Norway, enope
  pl='',    -- Poland, enope
  si='',    -- Slovenia, enope
  se='',    -- Sweden, enope
  ch='',    -- Switzerland, enope
  hk='zh-tw',    -- Hong Kong, Asia
  mo='zh-tw',    -- Macao, Asia
  tw='zh-tw',    -- Taiwan, Republic Of China, Asia
  jp='ja',    -- Japan, Asia
  au='',    -- Australia, Australia
  nz='',    -- New Zealand, Australia
  kr='kr',    -- Korea, Republic of, Asia
  sg='',    -- Singapore, Asia
  bg='',    -- bulgaria, Europe
  hr='',    -- croatia, Europe
  hu='',    -- hungary, Europe
  lt='',    -- lithuania, Europe
  ro='',    -- romania, Europe
  sk='',    -- slovakia, Europe
  cn='cn',  -- China, Asia
  my=''   -- malaysia, Asia
}

function get_lang(country)
  return country_langs[string.lower(country)]
end

real_locale = get_lang(ngx.var.country)
if real_locale ~= ngx.var.locale then
  if real_locale == "" then
    if ngx.var.path_cut == "" then
      ngx.var.rurl = "/"
    else
      ngx.var.rurl = string.gsub(ngx.var.path_cut, "/+$", "")
    end
  else
    ngx.var.rurl = "/"..real_locale..string.gsub(ngx.var.path_cut, "/+$", "")
  end
  return "redirect"
end
