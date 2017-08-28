--Begin Tools.lua :)
local SUDO = 223395979 -- ضع الايدي الخاص بك هنا ➕
function exi_files(cpath)
    local files = {}
    local pth = cpath
    for k, v in pairs(scandir(pth)) do
		table.insert(files, v)
    end
    return files
end

local function file_exi(name, cpath)
    for k,v in pairs(exi_files(cpath)) do
        if name == v then
            return true
        end
    end
    return false
end

local function index_function(user_id)
  for k,v in pairs(_config.admins) do
    if user_id == v[1] then
    	print(k)
      return k
    end
  end
  -- If not found
  return false
end

local function getindex(t,id) 
for i,v in pairs(t) do 
if v == id then 
return i 
end 
end 
return nil 
end 

local function already_sudo(user_id)
  for k,v in pairs(_config.sudo_users) do
    if user_id == v then
      return k
    end
  end
  -- If not found
  return false
end

local function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
end

local function exi_file()
    local files = {}
    local pth = tcpath..'/data/document'
    for k, v in pairs(scandir(pth)) do
        if (v:match('.lua$')) then
            table.insert(files, v)
        end
    end
    return files
end

local function pl_exi(name)
    for k,v in pairs(exi_file()) do
        if name == v then
            return true
        end
    end
    return false
end

local function sudolist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local sudo_users = _config.sudo_users
  if not lang then
 text = "*List of sudo users :*\n"
   else
 text = "_قائمة المطورين 🛃 :_\n"
  end
for i=1,#sudo_users do
    text = text..i.." - "..sudo_users[i].."\n"
end
return text
end

local function adminlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local sudo_users = _config.sudo_users
  if not lang then
 text = '*List of bot admins :*\n'
   else
 text = "_قائمة الادمنيه 🚹 :_\n"
  end
		  	local compare = text
		  	local i = 1
		  	for v,user in pairs(_config.admins) do
			    text = text..i..'- '..(user[2] or '')..' ➣ ('..user[1]..')\n'
		  	i = i +1
		  	end
		  	if compare == text then
   if not lang then
		  		text = '_No_ *admins* _available_'
      else
		  		text = '_لم يتم تعين 📬 ادمن في المجموعة 🚻_'
           end
		  	end
		  	return text
    end

local function chat_list(msg)
	i = 1
	local data = load_data(_config.moderation.data)
    local groups = 'groups'
    if not data[tostring(groups)] then
        return 'No groups at the moment'
    end
    local message = 'List of Groups:\n*Use #join (ID) to join*\n\n'
    for k,v in pairsByKeys(data[tostring(groups)]) do
		local group_id = v
		if data[tostring(group_id)] then
			settings = data[tostring(group_id)]['settings']
		end
        for m,n in pairsByKeys(settings) do
			if m == 'set_name' then
				name = n:gsub("", "")
				chat_name = name:gsub("‮", "")
				group_name_id = name .. '\n(ID: ' ..group_id.. ')\n\n'
				if name:match("[\216-\219][\128-\191]") then
					group_info = i..' - \n'..group_name_id
				else
					group_info = i..' - '..group_name_id
				end
				i = i + 1
			end
        end
		message = message..group_info
    end
	return message
end

local function botrem(msg)
	local data = load_data(_config.moderation.data)
	data[tostring(msg.to.id)] = nil
	save_data(_config.moderation.data, data)
	local groups = 'groups'
	if not data[tostring(groups)] then
		data[tostring(groups)] = nil
		save_data(_config.moderation.data, data)
	end
	data[tostring(groups)][tostring(msg.to.id)] = nil
	save_data(_config.moderation.data, data)
	if redis:get('CheckExpire::'..msg.to.id) then
		redis:del('CheckExpire::'..msg.to.id)
	end
	if redis:get('ExpireDate:'..msg.to.id) then
		redis:del('ExpireDate:'..msg.to.id)
	end
	tdcli.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
end

local function warning(msg)
	local hash = "gp_lang:"..msg.to.id
	local lang = redis:get(hash)
	local expiretime = redis:ttl('ExpireDate:'..msg.to.id)
	if expiretime == -1 then
		return
	else
	local d = math.floor(expiretime / 86400) + 1
        if tonumber(d) == 1 and not is_sudo(msg) and is_mod(msg) then
			if lang then
				tdcli.sendMessage(msg.to.id, 0, 1, '*>* _المجموعة_ *1* _يوم المهله المتبقيه لاعادة شحن ⏳ الاتصال بلبوت ومعا الانتهال من الوقت ⏰ وازالة المجموعة من قائمة البوت سوف تترك المجموعة !_', 1, 'md')
			else
				tdcli.sendMessage(msg.to.id, 0, 1, '*>* _Group 1 day ⏰ remaining charge, to recharge the robot contact with the sudo. With the completion of charging time, the group removed from the robot list and the robot will leave the group.!_', 1, 'md')
			end
		end
	end
end

local function action_by_reply(arg, data)
    local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
    if cmd == "adminprom" then
local function adminprom_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if is_admin1(tonumber(data.id_)) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already an_ *admin*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* _بلفعل انه ادمن 🚹 في المجموعه ✅_", 0, "md")
      end
   end
	    table.insert(_config.admins, {tonumber(data.id_), user_name})
		save_config()
     if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been promoted as_ *admin*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* _تم رفعة ادمن 🚹 في هذا المجموعة 🚻_", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, adminprom_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "admindem" then
local function admindem_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
	local nameid = index_function(tonumber(data.id_))
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not is_admin1(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* _ ليس ادمن 🚻 في هذا المجموعة_", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been demoted from_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* _ تم تنزيله 🚮 من قائمة الادمنيه !_", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, admindem_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "visudo" then
local function visudo_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if already_sudo(tonumber(data.id_)) then
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* _بلفعل تم رفعة 🕵🏻 مطور في المجموعة✅_0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now_ *sudoer*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* _ مبروك عزيزي تم رفعك مطور 🚹  في المجموعة !_", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "desudo" then
local function desudo_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
     if not already_sudo(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* _ليس مطور 🚹 في هذا المجموعة !_", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* _is no longer a_ *sudoer*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, desudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_لم يتم العثور 🔍 على المستخدم_", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local cmd = arg.cmd
if not arg.username then return false end
    if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
    if cmd == "adminprom" then
if is_admin1(tonumber(data.id_)) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already an_ *admin*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* _از قبل ادمین ربات بود_", 0, "md")
      end
   end
	    table.insert(_config.admins, {tonumber(data.id_), user_name})
		save_config()
     if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been promoted as_ *admin*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* _به مقام ادمین ربات منتصب شد_", 0, "md")
   end
end
    if cmd == "admindem" then
	local nameid = index_function(tonumber(data.id_))
if not is_admin1(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* _از قبل ادمین ربات نبود_", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been demoted from_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* _از مقام ادمین ربات برکنار شد_", 0, "md")
   end
end
    if cmd == "visudo" then
if already_sudo(tonumber(data.id_)) then
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* _از قبل سودو ربات بود_", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now_ *sudoer*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* _به مقام سودو ربات منتصب شد_", 0, "md")
   end
end
    if cmd == "desudo" then
     if not already_sudo(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* _‎ لم يتم تعينه 📥 مطور 🛂 في هذا البوت 🤖 !_", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* _لم يعد مطور 🚹 في هذا البوت 🤖 !_", 0, "md")
      end
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_لم يتم العثور ℹ️ على المستخدم !_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local cmd = arg.cmd
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
    if cmd == "adminprom" then
if is_admin1(tonumber(data.id_)) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already an_ *admin*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* _از قبل ادمین ربات بود_", 0, "md")
      end
   end
	    table.insert(_config.admins, {tonumber(data.id_), user_name})
		save_config()
     if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been promoted as_ *admin*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* _به مقام ادمین ربات منتصب شد_", 0, "md")
   end
end 
    if cmd == "admindem" then
	local nameid = index_function(tonumber(data.id_))
if not is_admin1(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* _از قبل ادمین ربات نبود_", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been demoted from_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* _از مقام ادمین ربات برکنار شد_", 0, "md")
   end
end
    if cmd == "visudo" then
if already_sudo(tonumber(data.id_)) then
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* _از قبل سودو ربات بود_", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now_ *sudoer*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* _به مقام سودو ربات منتصب شد_", 0, "md")
   end
end
    if cmd == "desudo" then
     if not already_sudo(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* _ لم يتم تعينه 📥 مطور 🛂 في هذا البوت 🤖 !_", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* _از مقام سودو ربات برکنار شد_", 0, "md")
      end
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_لم يتم العثور 🔍 على المستخدم !_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function pre_process(msg)
	if msg.to.type ~= 'pv' then
		local hash = "gp_lang:"..msg.to.id
		local lang = redis:get(hash)
		local data = load_data(_config.moderation.data)
		local gpst = data[tostring(msg.to.id)]
		local chex = redis:get('CheckExpire::'..msg.to.id)
		local exd = redis:get('ExpireDate:'..msg.to.id)
		if gpst and not chex and msg.from.id ~= SUDO and not is_sudo(msg) then
			redis:set('CheckExpire::'..msg.to.id,true)
			redis:set('ExpireDate:'..msg.to.id,true)
			redis:setex('ExpireDate:'..msg.to.id, 86400, true)
			if lang then
				tdcli.sendMessage(msg.to.id, msg.id_, 1, '*>* _المجموعة_ *1* _يوم المهله المتبقيه لاعادة شحن ⏳ الاتصال بلبوت ومعا الانتهال من الوقت ⏰ وازالة المجموعة من قائمة البوت سوف تترك المجموعة !__', 1, 'md')
			else
				tdcli.sendMessage(msg.to.id, msg.id_, 1, '*>* _Group charged 1 day. to recharge the robot contact with the sudo. With the completion of charging time, the group removed from the robot list and the robot will leave the group._', 1, 'md')
			end
		end
		if chex and not exd and msg.from.id ~= SUDO and not is_sudo(msg) then
			local text1 = 'عذراً ⚠️ لقد انتهت عملية الشحن 📶 \n\nID:  <code>'..msg.to.id..'</code>\n\nاذا كنت ترغب بمغادرة ℹ️ البوت من المجموعة فقط ارسل \n\n/leave '..msg.to.id..'\nويمكنك ايضاً استخدام هذا الامر:\n/jointo '..msg.to.id..'\n_________________\ن إذا كنت ترغب في إعادة شحن مجموعة يمكن استخدام التعليمات البرمجية التالية...\n\n<b>لشحن 1 شهر:</b>\n/plan 1 '..msg.to.id..'\n\n<b>توجيه الاتهام لمدة 3 أشهر:</b>\n/plan 2 '..msg.to.id..'\n\n<b>توجيه الاتهام مدى الحياة:</b>\n/plan 3 '..msg.to.id
			local text2 = '_تهمة هذه المجموعة الانتهاء. بسبب نقص التغذية، مجموعة من القائمة البوت إزالة،  المجموعات خارج._'
			local text3 = '_Charging finished._\n\n*Group ID:*\n\n*ID:* `'..msg.to.id..'`\n\n*If you want the robot to leave this group use the following command:*\n\n`/Leave '..msg.to.id..'`\n\n*For Join to this group, you can use the following command:*\n\n`/Jointo '..msg.to.id..'`\n\n_________________\n\n_If you want to recharge the group can use the following code:_\n\n*To charge 1 month:*\n\n`/Plan 1 '..msg.to.id..'`\n\n*To charge 3 months:*\n\n`/Plan 2 '..msg.to.id..'`\n\n*For unlimited charge:*\n\n`/Plan 3 '..msg.to.id..'`'
			local text4 = '_Charging finished. Due to lack of recharge remove the group from the robot list and the robot leave the group._'
			if lang then
				tdcli.sendMessage(SUDO, 0, 1, text1, 1, 'html')
				tdcli.sendMessage(msg.to.id, 0, 1, text2, 1, 'md')
			else
				tdcli.sendMessage(SUDO, 0, 1, text3, 1, 'md')
				tdcli.sendMessage(msg.to.id, 0, 1, text4, 1, 'md')
			end
			botrem(msg)
		else
			local expiretime = redis:ttl('ExpireDate:'..msg.to.id)
			local day = (expiretime / 86400)
			if tonumber(day) > 0.208 and not is_sudo(msg) and is_mod(msg) then
				warning(msg)
			end
		end
	end
	return msg
end

local function run(msg, matches)
if is_banned(msg.from.id, msg.to.id) or is_gbanned(msg.from.id, msg.to.id) or is_silent_user(msg.from.id, msg.to.id) then
return false
end
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if tonumber(msg.from.id) == SUDO then
if matches[1] == "clear cache" and is_sudo(msg) then
     run_bash("rm -rf ~/.telegram-cli/data/sticker/*")
     run_bash("rm -rf ~/.telegram-cli/data/photo/*")
     run_bash("rm -rf ~/.telegram-cli/data/animation/*")
     run_bash("rm -rf ~/.telegram-cli/data/video/*")
     run_bash("rm -rf ~/.telegram-cli/data/audio/*")
     run_bash("rm -rf ~/.telegram-cli/data/voice/*")
     run_bash("rm -rf ~/.telegram-cli/data/temp/*")
     run_bash("rm -rf ~/.telegram-cli/data/thumb/*")
     run_bash("rm -rf ~/.telegram-cli/data/document/*")
     run_bash("rm -rf ~/.telegram-cli/data/profile_photo/*")
     run_bash("rm -rf ~/.telegram-cli/data/encrypted/*")
    return "*All Cache Has Been Cleared*"
   end
if (matches[1] == "visudo" or matches[1] == "رفع مطور") and is_sudo(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="visudo"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="visudo"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="visudo"})
      end
   end
if (matches[1] == "desudo" or matches[1] == "تنزيل مطور") and is_sudo(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="desudo"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="desudo"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="desudo"})
      end
   end
end
if is_sudo(msg) then
   		if (matches[1]:lower() == 'add' or matches[1] == 'تفعيل') and not matches[2] and not redis:get('ExpireDate:'..msg.to.id) and is_admin(msg) then
			redis:set('ExpireDate:'..msg.to.id,true)
			redis:setex('ExpireDate:'..msg.to.id, 180, true)
				if not redis:get('CheckExpire::'..msg.to.id) then
					redis:set('CheckExpire::'..msg.to.id,true)
				end
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, 'تم شحن 🔋 المجموعة لمدة ⏰_ > *3 دقائق* !_', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_Group charged 3 minutes  for settings._', 1, 'md')
				end
		end
		if (matches[1]:lower() == 'rem' or matches[1] == 'تعطيل') and not matches[2] and is_admin(msg) then
			if redis:get('CheckExpire::'..msg.to.id) then
				redis:del('CheckExpire::'..msg.to.id)
			end
			redis:del('ExpireDate:'..msg.to.id)
		end
		if (matches[1]:lower() == 'gid' or matches[1] == 'ايدي المجموعه') and is_admin(msg) then
			tdcli.sendMessage(msg.to.id, msg.id_, 1, '`'..msg.to.id..'`', 1,'md')
		end
		if (matches[1] == 'leave' or matches[1] == 'خروج') and matches[2] and is_admin(msg) then
			if lang then
				tdcli.sendMessage(matches[2], 0, 1, 'عذراً ⚠️ سيتم الخروج من المجموعة بأمر من المطور ℹ️ !', 1, 'md')
				tdcli.changeChatMemberStatus(matches[2], our_id, 'Left', dl_cb, nil)
				tdcli.sendMessage(SUDO, msg.id_, 1, ''..matches[2]..' تم خروج البوت ⛔️ من المجموعة بنجاح ✅ !', 1,'md')
			else
				tdcli.sendMessage(matches[2], 0, 1, '_Robot left the group._\n*For more information contact The SUDO.*', 1, 'md')
				tdcli.changeChatMemberStatus(matches[2], our_id, 'Left', dl_cb, nil)
				tdcli.sendMessage(SUDO, msg.id_, 1, '*Robot left from under group successfully:*\n\n`'..matches[2]..'`', 1,'md')
			end
		end
		if (matches[1]:lower() == 'charge' or matches[1] == "شارژ") and matches[2] and matches[3] and is_admin(msg) then
		if string.match(matches[2], '^-%d+$') then
			if tonumber(matches[3]) > 0 and tonumber(matches[3]) < 1001 then
				local extime = (tonumber(matches[3]) * 86400)
				redis:setex('ExpireDate:'..matches[2], extime, true)
				if not redis:get('CheckExpire::'..msg.to.id) then
					redis:set('CheckExpire::'..msg.to.id,true)
				end
				if lang then
					tdcli.sendMessage(SUDO, 0, 1, 'بوت المجموعة '..matches[2]..' الى '..matches[3]..' مدة اليوم', 1, 'md')
					tdcli.sendMessage(matches[2], 0, 1, 'ربات توسط ادمین به مدت `'..matches[3]..'` روز شارژ شد\nبرای مشاهده زمان شارژ گروه دستور /check استفاده کنید...',1 , 'md')
				else
					tdcli.sendMessage(SUDO, 0, 1, '*Recharged successfully in the group:* `'..matches[2]..'`\n_Expire Date:_ `'..matches[3]..'` *Day(s)*', 1, 'md')
					tdcli.sendMessage(matches[2], 0, 1, '*Robot recharged* `'..matches[3]..'` *day(s)*\n*For checking expire date, send* `/check`',1 , 'md')
				end
			else
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_يجب أن يكون عدد 📳 أيام عدد من  *1 - 1000*', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '*>* _Expire days must be between 1 - 1000_', 1, 'md')
				end
			end
		end
		end
		if matches[1]:lower() == 'plan' or matches[1] == 'شحن' then
		if matches[2] == '1' and matches[3] and is_admin(msg) then
		if string.match(matches[3], '^-%d+$') then
			local timeplan1 = 2592000
			redis:setex('ExpireDate:'..matches[3], timeplan1, true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
			if lang then
				tdcli.sendMessage(SUDO, msg.id_, 1, ' '..matches[3]..' تم شحن البوت في هذا المجمولة🚻  لمدة *30 يوماً ! (1 شهر)', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, '_تم تفعيل البوت بنجاح، وتكون صالحة لمدة 30 يوما! ⏰_', 1, 'md')
			else
				tdcli.sendMessage(SUDO, msg.id_, 1, '*Plan 1 Successfully Activated!\nThis group recharged with plan 1 for 30 days (1 Month)*', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, '*Successfully recharged*\n*Expire Date:* `30` *Days (1 Month)*', 1, 'md')
			end
		end
		end
		if matches[2] == '2' and matches[3] and is_admin(msg) then
		if string.match(matches[3], '^-%d+$') then
			local timeplan2 = 7776000
			redis:setex('ExpireDate:'..matches[3],timeplan2,true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
			if lang then
				tdcli.sendMessage(SUDO, msg.id_, 1, ' '..matches[3]..'*>* سيتم  شحن البوت في هذا المجمولة🚻   وستكون صالحة لمدة *90 يوماً ! (3 شهر)', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, 'تم شحن البوت بنجاح، وتكون صالحة لمدة 90 يوما! ⏰(3اشهر)', 1, 'md')
			else
				tdcli.sendMessage(SUDO, msg.id_, 1, '_>_ *Plan 2 Successfully Activated!\nThis group recharged with plan 2 for 90 days (3 Month)*', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, '*Successfully recharged*\n*Expire Date:* `90` *Days (3 Months)*', 1, 'md')
			end
		end
		end
		if matches[2] == '3' and matches[3] and is_admin(msg) then
		if string.match(matches[3], '^-%d+$') then
			redis:set('ExpireDate:'..matches[3],true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
			if lang then
				tdcli.sendMessage(SUDO, msg.id_, 1, ' '..matches[3]..'*>*  مدة 3 سيتم شحن البوت 🌐 لمدة غير محدودة 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, 'تم شحن البوت بنجاح، وتكون صالحة لمدة غير محدودة ! ⏰', 1, 'md')
			else
				tdcli.sendMessage(SUDO, msg.id_, 1, '*Plan 3 Successfully Activated!\nThis group recharged with plan 3 for unlimited*', 1, 'md')
				tdcli.sendMessage(matches[3], 0, 1, '*Successfully recharged*\n*Expire Date:* `Unlimited`', 1, 'md')
			end
		end
		end
		end
		if (matches[1]:lower() == 'jointo' or matches[1] == 'دخول الى') and matches[2] and is_admin(msg) then
		if string.match(matches[2], '^-%d+$') then
			if lang then
				tdcli.sendMessage(SUDO, msg.id_, 1, 'بنجاح عزيزي ✅ '..matches[2]..' تم اضافة ➕.', 1, 'md')
				tdcli.addChatMember(matches[2], SUDO, 0, dl_cb, nil)
				tdcli.sendMessage(matches[2], 0, 1, '_تم تم اضافة مطور ℹ️ في هذا المجموعة_', 1, 'md')
			else
				tdcli.sendMessage(SUDO, msg.id_, 1, '*I added you to this group:*\n\n`'..matches[2]..'`', 1, 'md')
				tdcli.addChatMember(matches[2], SUDO, 0, dl_cb, nil)
				tdcli.sendMessage(matches[2], 0, 1, 'Admin Joined!', 1, 'md')
			end
		end
		end
end
	if (matches[1]:lower() == 'savefile' or matches[1] == 'حفظ ملف) and matches[2] and is_sudo(msg) then
		if msg.reply_id  then
			local folder = matches[2]
            function get_filemsg(arg, data)
				function get_fileinfo(arg,data)
                    if data.content_.ID == 'MessageDocument' or data.content_.ID == 'MessagePhoto' or data.content_.ID == 'MessageSticker' or data.content_.ID == 'MessageAudio' or data.content_.ID == 'MessageVoice' or data.content_.ID == 'MessageVideo' or data.content_.ID == 'MessageAnimation' then
                        if data.content_.ID == 'MessageDocument' then
							local doc_id = data.content_.document_.document_.id_
							local filename = data.content_.document_.file_name_
                            local pathf = tcpath..'/data/document/'..filename
							local cpath = tcpath..'/data/document'
                            if file_exi(filename, cpath) then
                                local pfile = folder
                                os.rename(pathf, pfile)
                                file_dl(doc_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>الملف</b> <code>'..folder..'</code> <b>تم الحفظ بنجاح 📥</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>File</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_عدم وجود الملف. إرسال الملف مرة أخرى. 🔀_', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
						if data.content_.ID == 'MessagePhoto' then
							local photo_id = data.content_.photo_.sizes_[2].photo_.id_
							local file = data.content_.photo_.id_
                            local pathf = tcpath..'/data/photo/'..file..'_(1).jpg'
							local cpath = tcpath..'/data/photo'
                            if file_exi(file..'_(1).jpg', cpath) then
                                local pfile = folder
                                os.rename(pathf, pfile)
                                file_dl(photo_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>الصوره</b> <code>'..folder..'</code> <b>تم الحفظ ✅.</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Photo</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_عدم وجود الملف. إرسال الملف مرة أخرى. 🔀_', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
		                if data.content_.ID == 'MessageSticker' then
							local stpath = data.content_.sticker_.sticker_.path_
							local sticker_id = data.content_.sticker_.sticker_.id_
							local secp = tostring(tcpath)..'/data/sticker/'
							local ffile = string.gsub(stpath, '-', '')
							local fsecp = string.gsub(secp, '-', '')
							local name = string.gsub(ffile, fsecp, '')
                            if file_exi(name, secp) then
                                local pfile = folder
                                os.rename(stpath, pfile)
                                file_dl(sticker_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>الملصق</b> <code>'..folder..'</code> <b>تم حفظه ✅.</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Sticker</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_عدم وجود الملف. إرسال الملف مرة أخرى._', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
						if data.content_.ID == 'MessageAudio' then
						local audio_id = data.content_.audio_.audio_.id_
						local audio_name = data.content_.audio_.file_name_
                        local pathf = tcpath..'/data/audio/'..audio_name
						local cpath = tcpath..'/data/audio'
							if file_exi(audio_name, cpath) then
								local pfile = folder
								os.rename(pathf, pfile)
								file_dl(audio_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>الموسيقى</b> <code>'..folder..'</code> <b>تم الحفظ بنجاح ✅</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Audio</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
							else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_عدم وجود الملف. إرسال الملف مرة أخرى._', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
							end
						end
						if data.content_.ID == 'MessageVoice' then
							local voice_id = data.content_.voice_.voice_.id_
							local file = data.content_.voice_.voice_.path_
							local secp = tostring(tcpath)..'/data/voice/'
							local ffile = string.gsub(file, '-', '')
							local fsecp = string.gsub(secp, '-', '')
							local name = string.gsub(ffile, fsecp, '')
                            if file_exi(name, secp) then
                                local pfile = folder
                                os.rename(file, pfile)
                                file_dl(voice_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>الصوت</b> <code>'..folder..'</code> <b>تم الحفظ بنجاح ✅</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Voice</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_عدم وجود الملف.🔀 إرسال الملف مرة أخرى._', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
						if data.content_.ID == 'MessageVideo' then
							local video_id = data.content_.video_.video_.id_
							local file = data.content_.video_.video_.path_
							local secp = tostring(tcpath)..'/data/video/'
							local ffile = string.gsub(file, '-', '')
							local fsecp = string.gsub(secp, '-', '')
							local name = string.gsub(ffile, fsecp, '')
                            if file_exi(name, secp) then
                                local pfile = folder
                                os.rename(file, pfile)
                                file_dl(video_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>الفيديو</b> <code>'..folder..'</code> <b>تم الحفظ بنجاح</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Video</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_عدم وجود الملف. 🔀 إرسال الملف مرة أخرى._', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
						if data.content_.ID == 'MessageAnimation' then
							local anim_id = data.content_.animation_.animation_.id_
							local anim_name = data.content_.animation_.file_name_
                            local pathf = tcpath..'/data/animation/'..anim_name
							local cpath = tcpath..'/data/animation'
                            if file_exi(anim_name, cpath) then
                                local pfile = folder
                                os.rename(pathf, pfile)
                                file_dl(anim_id)
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>الصور المتحركة</b> <code>'..folder..'</code> <b>تم الحفظ بنجاح ✅.</b>', 1, 'html')
								else
									tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Gif</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_عدم وجود الملف. إرسال الملف مرة أخرى._', 1, 'md')
								else
									tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
								end
                            end
						end
                    else
                        return
                    end
                end
                tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, get_fileinfo, nil)
            end
	        tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_ }, get_filemsg, nil)
        end
    end
	if msg.to.type == 'channel' or msg.to.type == 'chat' then
		if (matches[1] == 'charge' or matches[1] == 'المده') and matches[2] and not matches[3] and is_sudo(msg) then
			if tonumber(matches[2]) > 0 and tonumber(matches[2]) < 1001 then
				local extime = (tonumber(matches[2]) * 86400)
				redis:setex('ExpireDate:'..msg.to.id, extime, true)
				if not redis:get('CheckExpire::'..msg.to.id) then
					redis:set('CheckExpire::'..msg.to.id)
				end
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, 'ربات با موفقیت تنظیم شد\nمدت فعال بودن ربات در گروه به '..matches[2]..' روز دیگر تنظیم شد...', 1, 'md')
					tdcli.sendMessage(SUDO, 0, 1, 'بوت المجموعة '..matches[2]..' الى `'..msg.to.id..'` روز تمدید گردید.', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, 'ربات با موفقیت تنظیم شد\nمدت فعال بودن ربات در گروه به '..matches[2]..' روز دیگر تنظیم شد...', 1, 'md')
					tdcli.sendMessage(SUDO, 0, 1, 'ربات در گروه '..matches[2]..' به مدت `'..msg.to.id..'` روز تمدید گردید.', 1, 'md')
				end
			else
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_يجب أن يكون عدد 📳 أيام عدد من  *1 - 1000_', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_Expire days must be between 1 - 1000_', 1, 'md')
				end
			end
		end
		if (matches[1]:lower() == 'check' or matches[1] == 'تفعيل لمدة') and is_mod(msg) and not matches[2] and is_owner(msg) then
			local expi = redis:ttl('ExpireDate:'..msg.to.id)
			if expi == -1 then
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_ تم تفعيل البوت 🌐 لمدة غير محدودة!_', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_Unlimited Charging!_', 1, 'md')
				end
			else
				local day = math.floor(expi / 86400) + 1
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, day..' _يوم ⏰ :- المهله النتبقية لانتهاء صلاحية ⌛️ البوت !_', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '`'..day..'` *Day(s) remaining until Expire.*', 1, 'md')
				end
			end
		end
		end
		if (matches[1] == 'check' or matches[1] == 'تفعيل لمدة') and is_mod(msg) and matches[2] and is_admin(msg) then
		if string.match(matches[2], '^-%d+$') then
			local expi = redis:ttl('ExpireDate:'..matches[2])
			if expi == -1 then
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '*>* _شحن المجموعة 🔋 غير محدود !_', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '_Unlimited Charging!_', 1, 'md')
				end
			else
				local day = math.floor(expi / 86400 ) + 1
				if lang then
					tdcli.sendMessage(msg.to.id, msg.id_, 1, day..' يوم ⏰ :- المهله النتبقية لانتهاء صلاحية ⌛️ البوت !', 1, 'md')
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '-'..day..'- *Day(s) remaining until Expire.*', 1, 'md')
				end
			end
		end
	end
if (matches[1] == "adminprom" or matches[1] == "المشرف") and is_sudo(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="adminprom"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="adminprom"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="adminprom"})
      end
   end
if (matches[1] == "admindem" or matches[1] == "حذف مشرف") and is_sudo(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.to.id,cmd="admindem"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="admindem"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="admindem"})
      end
   end

if matches[1] == 'creategroup' or matches[1] == 'انشاء مجموعة' and is_admin(msg) then
local text = matches[2]
tdcli.createNewGroupChat({[0] = msg.from.id}, text, dl_cb, nil)
  if not lang then
return '_Group Has Been Created!_'
  else
return '_تم انشاء المجموعة 🚻 بنجاح !_'
   end
end

if (matches[1] == 'createsuper' or matches[1] == 'انشاء مجموعة سوبر') and is_admin(msg) then
local text = matches[2]
tdcli.createNewChannelChat(text, 1, '@ProtectionTeam', (function(b, d) tdcli.addChatMember(d.id_, msg.from.id, 0, dl_cb, nil) end), nil)
   if not lang then 
return '_SuperGroup Has Been Created and_ [`'..msg.from.id..'`] _Joined To This SuperGroup._'
  else
return '_تم انشاء مجموعة سوبر كروب_ [`'..msg.from.id..'`] _تم إضافتها إلى المجموعة._'
   end
end

if (matches[1] == 'tosuper' or matches[1] == 'تحويل سوبر') and is_admin(msg) then
local id = msg.to.id
tdcli.migrateGroupChatToChannelChat(id, dl_cb, nil)
  if not lang then
return '_Group Has Been Changed To SuperGroup!_'
  else
return '_تم تحويل 🔀 المجموعة الى سوبر كروب (مجموعة خارقة) !_'
   end
end

if (matches[1] == 'import' or matches[1] == 'دخول') and is_admin(msg) then
if matches[2]:match("^([https?://w]*.?telegram.me/joinchat/.*)$") or matches[2]:match("^([https?://w]*.?t.me/joinchat/.*)$") then
local link = matches[2]
if link:match('t.me') then
link = string.gsub(link, 't.me', 'telegram.me')
end
tdcli.importChatInviteLink(link, dl_cb, nil)
   if not lang then
return '*Done!*'
  else
return '*Done*'
  end
  end
end

if (matches[1] == 'setbotname' or matches[1] == 'تغير اسم البوت') and is_sudo(msg) then
tdcli.changeName(matches[2])
   if not lang then
return '_Bot Name Changed To:_ *'..matches[2]..'*'
  else
return '_تم تغغير اسم اابوت ℹ️ الى:_ \n*'..matches[2]..'*'
   end
end

if (matches[1] == 'setbotusername' or matches[1] == 'تغير معرف البوت') and is_sudo(msg) then
tdcli.changeUsername(matches[2])
   if not lang then
return '_Bot Username Changed To:_ @'..matches[2]
  else
return '_تم تغيير معرف البوت الى ℹ️:_ \n@'..matches[2]..''
   end
end

if (matches[1] == 'delbotusername' or matches[1] == 'حذف معرف البوت') and is_sudo(msg) then
tdcli.changeUsername('')
   if not lang then
return '*Done!*'
  else
return '*تم حذف 🚮 المعرف بنجاح!*'
  end
end

if (matches[1] == 'markread' or matches[1] == 'الماركدون') and is_sudo(msg) then
if matches[2] == 'on' or matches[2] == 'تفعيل' then
redis:set('markread','on')
   if not lang then
return '_Markread >_ *ON*'
else
return '_الماركدون ➰ >_ *تم تفعيله ✅*'
   end
end
if matches[2] == 'off' or matches[2] == 'تعطيل' then
redis:set('markread','off')
  if not lang then
return '_Markread >_ *OFF*'
   else
return '_الماركدون ➰ >_ *تم تعطيله ❌*'
      end
   end
end

if (matches[1] == 'bc' or matches[1] == 'نشر') and is_admin(msg) then
		local text = matches[2]
tdcli.sendMessage(matches[3], 0, 0, text, 0)	
end

if (matches[1] == 'broadcast' or matches[1] == 'ارسال به همه') and is_sudo(msg) then		
local data = load_data(_config.moderation.data)		
local bc = matches[2]			
for k,v in pairs(data) do				
tdcli.sendMessage(k, 0, 0, bc, 0)			
end	
end

  if is_sudo(msg) then
	if (matches[1]:lower() == "sendfile" or matches[1] == 'ارسل ملف') and matches[2] and matches[3] then
		local send_file = "./"..matches[2].."/"..matches[3]
		tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, send_file, '@Star_Wars', dl_cb, nil)
	end
	if matches[1]:lower() == "sendplug" or matches[1] == 'حفظ ملف' and matches[2] then
	    local plug = "./plugins/"..matches[2]..".lua"
		tdcli.sendDocument(msg.chat_id_, msg.id_,0, 1, nil, plug, '@ProtectionTeam', dl_cb, nil)
    end
  end

    if (matches[1]:lower() == 'save' or matches[1] == 'حفظ') and matches[2] and is_sudo(msg) then
        if tonumber(msg.reply_to_message_id_) ~= 0  then
            function get_filemsg(arg, data)
                function get_fileinfo(arg,data)
                    if data.content_.ID == 'MessageDocument' then
                        fileid = data.content_.document_.document_.id_
                        filename = data.content_.document_.file_name_
                        if (filename:lower():match('.lua$')) then
                            local pathf = tcpath..'/data/document/'..filename
                            if pl_exi(filename) then
                                local pfile = 'plugins/'..matches[2]..'.lua'
                                os.rename(pathf, pfile)
                                tdcli.downloadFile(fileid , dl_cb, nil)
                                tdcli.sendMessage(msg.to.id, msg.id_,1, '<b>Plugin</b> <code>'..matches[2]..'</code> <b>Has Been Saved.</b>', 1, 'html')
                            else
                                tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file does not exist. Send file again._', 1, 'md')
                            end
                        else
                            tdcli.sendMessage(msg.to.id, msg.id_, 1, '_This file is not Plugin File._', 1, 'md')
                        end
                    else
                        return
                    end
                end
                tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, get_fileinfo, nil)
            end
	        tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_to_message_id_ }, get_filemsg, nil)
        end
    end

if (matches[1] == 'sudolist' or  matches[1] == 'قائمة المطورين') and is_sudo(msg) then
return sudolist(msg)
    end
if (matches[1] == 'chats' or matches[1] == 'المجموعه') and is_admin(msg) then
return chat_list(msg)
    end
   if (matches[1]:lower() == 'join' or matches[1] == 'دخول') and matches[2] and is_admin(msg) and matches[2] then
	   tdcli.sendMessage(msg.to.id, msg.id, 1, 'I Invite you in '..matches[2]..'', 1, 'html')
	   tdcli.sendMessage(matches[2], 0, 1, "Admin Joined!🌚", 1, 'html')
    tdcli.addChatMember(matches[2], msg.from.id, 0, dl_cb, nil)
  end
		if (matches[1] == 'rem' or matches[1] == 'تعطيل') and matches[2] and is_admin(msg) then
    local data = load_data(_config.moderation.data)
			-- Group configuration removal
			data[tostring(matches[2])] = nil
			save_data(_config.moderation.data, data)
			local groups = 'groups'
			if not data[tostring(groups)] then
				data[tostring(groups)] = nil
				save_data(_config.moderation.data, data)
			end
			data[tostring(groups)][tostring(matches[2])] = nil
			save_data(_config.moderation.data, data)
	   tdcli.sendMessage(matches[2], 0, 1, "Group has been removed by admin command", 1, 'html')
    return '_Group_ *'..matches[2]..'* _removed_'
		end
if matches[1] == 'pct' or matches[1] == 'پروتکشن' then
return tdcli.sendMessage(msg.to.id, msg.id, 1, _config.info_text, 1, 'html')
    end
if (matches[1] == 'adminlist' or matches[1] == 'قائمة الادمنيه') and is_admin(msg) then
return adminlist(msg)
    end
     if (matches[1] == 'leave' or matches[1] == 'خروج') and is_admin(msg) then
  tdcli.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
   end
     if (matches[1] == 'autoleave' or matches[1] == 'خروج تلقائي') and is_admin(msg) then
local hash = 'auto_leave_bot'
--Enable Auto Leave
     if matches[2] == 'enable' or matches[2] == 'تفعيل' then
    redis:del(hash)
   return 'Auto leave has been enabled'
--Disable Auto Leave
     elseif matches[2] == 'disable' or matches[2] == 'اطفاء' then
    redis:set(hash, true)
   return 'Auto leave has been disabled'
--Auto Leave Status
      elseif matches[2] == 'status' or  matches[2] == 'موقعیت' then
      if not redis:get(hash) then
   return 'Auto leave is enable'
       else
   return 'Auto leave is disable'
         end
      end
   end
end

return { 
patterns = {                                                                   
command .. "([Hh]elptools)$", 
command .. "([Vv]isudo)$", 
command .. "([Dd]esudo)$",
command .. "([Ss]udolist)$",
command .. "([Vv]isudo) (.*)$", 
command .. "([Dd]esudo) (.*)$",
command .. "([Aa]dminprom)$", 
command .. "([Aa]dmindem)$",
command .. "([Aa]dminlist)$",
command .. "([Aa]dminprom) (.*)$", 
command .. "([Aa]dmindem) (.*)$",
command .. "([Ll]eave)$",
command .. "([Aa]utoleave) (.*)$", 
command .. "([Pp]ct)$",
command .. "([Cc]reategroup) (.*)$",
command .. "([Cc]reatesuper) (.*)$",
command .. "([Tt]osuper)$",
command .. "([Cc]hats)$",
command .. "([Cc]lear cache)$",
command .. "([Jj]oin) (-%d+)$",
command .. "([Rr]em) (-%d+)$",
command .. "([Ii]mport) (.*)$",
command .. "([Ss]etbotname) (.*)$",
command .. "([Ss]etbotusername) (.*)$",
command .. "([Dd]elbotusername) (.*)$",
command .. "([Mm]arkread) (.*)$",
command .. "([Bb]c) +(.*) (-%d+)$",
command .. "([Bb]roadcast) (.*)$",
command .. "([Ss]endfile) (.*) (.*)$",
command .. "([Ss]ave) (.*)$",
command .. "([Ss]endplug) (.*)$",
command .. "([Ss]avefile) (.*)$",
command .. "([Aa]dd)$",
command .. "([Gg]id)$",
command .. "([Cc]heck)$",
command .. "([Cc]heck) (-%d+)$",
command .. "([Cc]harge) (-%d+) (%d+)$",
command .. "([Cc]harge) (%d+)$",
command .. "([Jj]ointo) (-%d+)$",
command .. "([Ll]eave) (-%d+)$",
command .. "([Pp]lan) ([123]) (-%d+)$",
command .. "([Rr]em)$",
 "^([Hh]elptools)$", 
 "^([Vv]isudo)$", 
 "^([Dd]esudo)$",
 "^([Ss]udolist)$",
 "^([Vv]isudo) (.*)$", 
 "^([Dd]esudo) (.*)$",
 "^([Aa]dminprom)$", 
 "^([Aa]dmindem)$",
 "^([Aa]dminlist)$",
 "^([Aa]dminprom) (.*)$", 
 "^([Aa]dmindem) (.*)$",
 "^([Ll]eave)$",
 "^([Aa]utoleave) (.*)$", 
 "^([Pp]ct)$",
 "^([Cc]reategroup) (.*)$",
 "^([Cc]reatesuper) (.*)$",
 "^([Tt]osuper)$",
 "^([Cc]hats)$",
 "^([Cc]lear cache)$",
 "^([Jj]oin) (-%d+)$",
 "^([Rr]em) (-%d+)$",
 "^([Ii]mport) (.*)$",
 "^([Ss]etbotname) (.*)$",
 "^([Ss]etbotusername) (.*)$",
 "^([Dd]elbotusername) (.*)$",
 "^([Mm]arkread) (.*)$",
 "^([Bb]c) +(.*) (-%d+)$",
 "^([Bb]roadcast) (.*)$",
 "^([Ss]endfile) (.*) (.*)$",
 "^([Ss]ave) (.*)$",
 "^([Ss]endplug) (.*)$",
 "^([Ss]avefile) (.*)$",
 "^([Aa]dd)$",
 "^([Gg]id)$",
 "^([Cc]heck)$",
 "^([Cc]heck) (-%d+)$",
 "^([Cc]harge) (-%d+) (%d+)$",
 "^([Cc]harge) (%d+)$",
 "^([Jj]ointo) (-%d+)$",
 "^([Ll]eave) (-%d+)$",
 "^([Pp]lan) ([123]) (-%d+)$",
 "^([Rr]em)$",
}, 
patterns_fa = {
	"^(تفعيل)$",
	"^(تعطيل)$",
    "^(تعطيل) (-%d+)$",	
    "^(راهنما ابزار)$",
	"^(قائمة المطورين)$",
	"^(ايدي المجموعه)$",
	"^(انشاء مجموعه) (.*)$",
	"^(دخول الى) (-%d+)$",
	"^(انشاء مجموعه) (.*)$",
	"^(انشاء مجموعه سوبر) (.*)$",
	"^(حفظ ملف) (.*)$",
	"^(رفع مطور)$",
	"^(رفع مطور) (.*)$,
	"^(تنزيل مطور)$",
	"^(تنزيل مطور) (.*)$",	
	"^(مشرف)$",
	"^(حذف مشرف)$",
	"^(حذف مشرف) (.*)$",
	"^(ارسال ملف) (.*)$",
	"^(حذف معرف البوت) (.*)$",
    "^(تغير معرف البوت) (.*)$",
	"^(تغير اسم البوت) (.*)$",
	"^(تحويل سوبر)$",
	"^(ارسال به همه) (.*)$",
	"^(المجموعه)$",
	"^(خروج)$",
	"^(خروج) (-%d+)$",	
	"^(ارسال پلاگین) (.*)$",
	"^(قائمة الادمنيه)$",
	"^(خروج تلقائي) (.*)$",
    "^(مدة) (-%d+) (%d+)$",
    "^(مدة) (%d+)$",	
    "^(شحن) ([123]) (-%d+)$",
    "^(تفعيل لمدة)$",
    "^(تفعيل لمدة) (-%d+)$",
    "^(ذخیره پلاگین) (.*)$",
    "^(الماركدون) (.*)$",
    "^(ارسال) +(.*) (-%d+)$",
	"^(دخول) (-%d+)$",
	"^(پاک کردن حافظه)$",
	"^(پروتکشن)$",
},
run = run, pre_process = pre_process
}
-- #End By @ProtectionTeam
