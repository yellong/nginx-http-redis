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

not_redirect_paths = {
  ["^/api.*"]=true,
  ["^/china_city"]=true,
  ["^/rest.*"]=true,
  ["^/admin.*"]=true,
  ["^/cms.*"]=true,
  ["^/simple_captcha.*"]=true,
  ["^/gateway.*"]=true,
  ["^/share.*"]=true,
  ["^/roles.*"]=true,
  ["^/user_roles.*"]=true,
  ["^/events/show$"]=true,
  ["^/events/show$"]=true,
  ["^/operate.*"]=true,
  ["^/account.*"]=true,
  ["^/log.*"]=true,
  ["^/excels.*"]=true,
  ["^/mobile2.*"]=true,
  ["^/shipping/.*/%d+.*"]=true,
  ["^/user/login_remote.*"]=true,
  ["order_sync"]=true,
  ["^/mobile.*"]=true,
  ["oauth"]=true,
  ["auth"]=true,
  ["callback"]=true,
  ["wechat"]=true,
  ["sf_delivery_available"]=true,
  ["^/robots.txt$"]=true,
  ["card_pack"]=true,
  ["%.json$"]=true,
  ["%.csv$"]=true,
  ["%.xml$"]=true
}

function get_lang(country)
  return country_langs[string.lower(country)]
end

function log(msg)
  ngx.log(ngx.STDERR, msg)
end

function should_redirect(uri)

  -- 只跳转GET方法
  if ngx.var.request_method ~= 'GET' then
    return false
  end

  -- 不接受ajax请求
  if ngx.var.http_x_requested_with == "XMLHttpRequest" then
    return false
  end

  -- 黑名单判断
  for path,flag in pairs(not_redirect_paths) do
    if (flag == true and string.match(ngx.var.uri,path) ~= nil) then
      return false
    end
  end

  -- 当前url中的语言判断
  return get_lang(ngx.var.country) ~= ngx.var.locale
end

function build_redirect_url()
  local redirect_locale = get_lang(ngx.var.country)
  local redirect_url = ""
  local replace_string = ""

  -- 特殊处理英文为空的状况
  if redirect_locale == "" then
    replace_string = "/"
  else
    replace_string = "/"..redirect_locale.."/"
  end

  -- 替换url中的locale并去掉末尾的"/"
  redirect_url = ngx.re.gsub(ngx.var.request_uri, "^/"..ngx.var.locale.."/?", replace_string)
  log("uri::"..ngx.var.request_uri..",redirect_url::"..redirect_url)
  redirect_url = ngx.re.gsub(redirect_url, "/*$", "")
  if redirect_url == "" then
    redirect_url = "/"
  end
  -- log("locale::"..ngx.var.locale.." , redirect_locale::"..redirect_locale.." , redirect_url::"..redirect_url)
  return redirect_url
end

if should_redirect() then
  ngx.var.rurl = build_redirect_url()
  return "redirect"
else
  return "not_redirect"
end
