local function modadd(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- Staa and admins (because sudo are always has privilege)--By : @iiDii
    if not is_admin(msg) then
   if not lang then
        return '_You are not bot admin_'
else
     return '_عذراً ⚠️ انت ليس مطور البوت 🤖!_'
    end
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
if not lang then
   return '‏*>* _Group_* ['..msg.to.title..']*_ is already added_'
else
return '_تم تفعيل البوت ✅  في هذا المجموعة 🚻 مسبقا !_'
  end
end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
              owners = {},
      mods ={},
      banned ={},
      is_silent_users ={},
      filterlist ={},
      whitelist ={},
      settings = {
          set_name = msg.to.title,
          lock_link = 'yes',
          lock_tag = 'yes',
		  lock_username = 'yes',		  		  
          lock_spam = 'yes',
          lock_webpage = 'no',
          lock_mention = 'no',
          lock_markdown = 'no',
          lock_flood = 'yes',
          lock_bots = 'yes',
          lock_pin = 'no',
          welcome = 'no',
		  lock_join = 'no',
		  lock_badword = 'no',
		  lock_tabchi = 'no',
		  lock_english = 'no',		  
                 mute_fwd = 'no',
                  mute_audio = 'no',
                  mute_video = 'no',
                  mute_contact = 'no',
                  mute_text = 'no',
                  mute_photos = 'no',
                  mute_gif = 'no',
                  mute_loc = 'no',
                  mute_doc = 'no',
                  mute_sticker = 'no',
                  mute_voice = 'no',
                   mute_all = 'no',
				   mute_keyboard = 'no'
				},
				
                 }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
    if not lang then
  return "*Group* _has been added_\n*BY :* `"..msg.from.id.."` "
else
  return '*>* تم تفعيل ✅ البوت في هذا المجموعة 🚻 بنجاح !'
end
end

local function modrem(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then
     if not lang then
        return '_You are not bot admin_'
   else
        return '_عذراً ⚠️ انت ليس مطور البوت 🤖!_'
    end
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.to.id
  if not data[tostring(msg.to.id)] then
  if not lang then
    return '_Group is not added_'
else
    return '*>* _لم يتم تفعيل 📳 البوت 🤖  في هذا المجموعة !_'
   end
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
 if not lang then
  return "`Group` *has been removed*\n*BY :* `"..msg.from.id.."` "
 else
  return '*>* _تم تعطيل 📴 البوت في هذا المجموعة 🚻 بنجاح !_'
end
end

 local function config_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
  print(serpent.block(data))
   for k,v in pairs(data.members_) do
   local function config_mods(arg, data)
       local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    return
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   end
tdcli_function ({
    ID = "GetUser",
    user_id_ = v.user_id_
  }, config_mods, {chat_id=arg.chat_id,user_id=v.user_id_})
 
if data.members_[k].status_.ID == "ChatMemberStatusCreator" then
owner_id = v.user_id_
   local function config_owner(arg, data)
  print(serpent.block(data))
       local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    return
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   end
tdcli_function ({
    ID = "GetUser",
    user_id_ = owner_id
  }, config_owner, {chat_id=arg.chat_id,user_id=owner_id})
   end
end
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_All group admins has been promoted and group creator is now group owner_", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "*>* _تمت ترقية جميع المشرفين على المجموعة 🚻 وأصبح منشئ المجموعة الآن مدير 👮🏻 المجموعة !_", 0, "md")
     end
 end

local function filter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.to.id)]['filterlist'][(word)] then
   if not lang then
         return "_Word_ *"..word.."* _is already filtered_"
            else
         return "*>* _الكلمة_ *"..word.."* _تم اضافتها الى قائمة المنع ⛔️ مسبقا !_"
    end
end
   data[tostring(msg.to.id)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)
   if not lang then
         return "_Word_ *"..word.."* _added to filtered words list_"
            else
         return "*>* _الكلمة_ *:-"..word.."* _تم اضافتها الى قائمة المنع ⛔️ بنجاح ✅ !_"
    end
end

local function unfilter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.to.id)]['filterlist'][word] then
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
       if not lang then
         return "_Word_ *"..word.."* _removed from filtered words list_"
       elseif lang then
         return "*>* _الكلمه_ *"..word.."* _تم حذفها 🚮 من قائمة المنع 📵 !_"
     end
      else
       if not lang then
         return "_Word_ *"..word.."* _is not filtered_"
       elseif lang then
         return "*>* _الكلمه_ *"..word.."* _لم يتم اضافتها 📥 الى قائمة المنع📵 !_"
      end
   end
end

local function modlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then
  if not lang then
    return "_Group is not added_"
 else
    return "*>* _لم يتم تفعيل 📳 البوت 🤖  في هذا المجموعة !_"
  end
 end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way
  if not lang then
    return "_No_ *moderator* _in this group_"
else
   return "*>* _عذراً ℹ️ لايوجد مشرفين في هذا المجموعة 📭 ! _"
  end
end
if not lang then
   message = '*>* *List of moderators :*\n'
else
   message = '*>* _قائمة الادمنية 🚻  :_\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.to.id)] then
if not lang then
    return "_Group is not added_"
else
return "*>* _لم يتم تفعيل 📳 البوت 🤖  في هذا المجموعة !_"
  end
end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
 if not lang then
    return "_No_ *owner* _in this group_"
else
    return "*>* _عذراً ℹ️ لايوجد مدراء في هذا المجموعة 📭 ! _"
  end
end
if not lang then
   message = '*List of owners :*\n'
else
   message = '*>* _قائمة المدراء 🚻 !_ :\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end



local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
  if not administration[tostring(data.chat_id_)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "*>* _لم يتم تفعيل 📳 البوت 🤖  في هذا المجموعة !_", 0, "md")
     end
  end
   if cmd == "ban" then
local function ban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't ban_ *mods,owners and bot admins*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*>* _عذراً ⚠️ لايمكنك حظر - المدراء - المشرفين - الادمنيه - في هذا المجموعة 🚻 !_", 0, "md")
         end
     end
if administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already_ *banned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* * تم حظره ⛔️ من المجموعة مسبقاً ✅ !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *banned*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم حظره ⛔️ من المجموعة بنجاح ✅ !*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, ban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
   if cmd == "unban" then
local function unban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not_ *banned*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *لم يتم حظره ⛔️ من المجموعة  ✅ !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *unbanned*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم الغاء الحظر ⛔️ عنه في هذا المجموعة ✅*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, unban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "silent" then
local function silent_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't silent_ *mods,owners and bot admins*", 0, "md")
    else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*>* _عذراً ⚠️ لايمكنك كتم 🔕 - المدراء - المشرفين - الادمنيه - في هذا المجموعة 🚻 !_", 0, "md")
       end
     end
if administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already_ *silent*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم كتمه 🔕 مسبقاً في هذا المجموعة ✅ !*", 0, "md")
     end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
  if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _added to_ *silent users list*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم اضافة 📥 الى قائمة المكتومين 🔕 بنجاح ✅ !*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, silent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "unsilent" then
local function unsilent_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not_ *silent*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *‎ لم يتم كتمه 🤐 في هذا المجموعة 🚻 !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _removed from_ *silent users list*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم ازالتة 🚮 من قائمة الكتم 📳 في هذا المجموعة بنجاح ✅ !*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, unsilent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "banall" then
local function gban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
   if is_admin1(data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't_ *globally ban* _other admins_", 0, "md")
  else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*>* _عذراً ⚠️ لايمكنك حظر ⛔️ - المدراء - المشرفين - الادمنيه - في هذا المجموعة 🚻 !_", 0, "md")
        end
     end
if is_gbanned(data.id_) then
   if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already_ *globally banned*", 0, "md")
    else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم حظره عام 📛 من جميع  مجموعاتي مسبقا ✅ !*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
     if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *globally banned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم حظره عام 📛 من جميع مجموعاتي بنجاح ✅ !*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, gban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "unbanall" then
local function ungban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
if not is_gbanned(data.id_) then
   if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not_ *globally banned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *لم يتم حظره ⛔️ من هذا المجموعة 🚻 !*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *globally unbanned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم الغاء حظر عام 📛 عنه في هذا  المجموعة 🚻 !*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, ungban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "kick" then
   if is_mod1(data.chat_id_, data.sender_user_id_) then
   if not lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_You can't kick_ *mods,owners and bot admins*", 0, "md")
    elseif lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "*>* _عذراً ⚠️ لايمكنك طرد 🚷 - المدراء - المشرفين - الادمنيه - في هذا المجموعة 🚻 !_", 0, "md")
   end
  else
     kick_user(data.sender_user_id_, data.chat_id_)
     end
  end
  if cmd == "delall" then
   if is_mod1(data.chat_id_, data.sender_user_id_) then
   if not lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_You can't delete messages_ *mods,owners and bot admins*", 0, "md")
   elseif lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "*>* _عذراً ⚠️ لايمكنك حذف رسائل 🚮 - المدراء - المشرفين - الادمنيه - في هذا المجموعة 🚻 !_", 0, "md")
   end
  else
tdcli.deleteMessagesFromUser(data.chat_id_, data.sender_user_id_, dl_cb, nil)
   if not lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_All_ *messages* _of_ *[ "..data.sender_user_id_.." ]* _has been_ *deleted*", 0, "md")
      elseif lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "*جميع رسائل 📨 :- * *[ "..data.sender_user_id_.." ]* *تم حذفها 🚮 بنجاح ✅ !*", 0, "md")
       end
    end
  end
if cmd == "setmanager" then
local function manager_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  channel_set_admin(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group manager*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *_is now the_ *group manager**", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, manager_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
if cmd == "remmanager" then
local function rem_manager_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  channel_demote(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer_ *group manager*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer_ *group manager*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_manager_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "setwhitelist" then
local function setwhitelist_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already in_ *white list*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم اضافة ➕ الى القائمة البيضاء 🗒 مسبقاً !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been added to_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم اضافة ➕ الى القائمة البيضاء 🗒 بنجاح ✅ !*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, setwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "remwhitelist" then
local function remwhitelist_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not in_ *white list*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *لم تم اضافة ➕ الى القائمة البيضاء 🗒  !*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been removed from_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *لم تم ازالة 🚮 الى القائمة البيضاء 🗒 بنجاح ✅  !*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, remwhitelist_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *بلفعل تم رفعة مدير 👮🏻 في هذا المجموعة 🚻 !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم رفعة مدير 👮🏻 في هذا المجموعة 🚻 بنجاح ✅ !*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *بلفعل تم رفعة ادمن 👨🏻‍🔧  في هذا المجموعة 🚻 !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم رفعة ادمن 👨🏻‍🔧 في هذا المجموعة 🚻 بنجاح ✅ !*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام صاحب گروه برکنار شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *لم يتم رفعة ادمن 🚻 في هذا المجموعة ⚠️ !*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم تنزيلة 📥 من الادمنية 🚻 في هذا المجموعة !*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "id" then
local function id_cb(arg, data)
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_لم يتم العثور🔍 على المستخدم, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "*>* _لم يتم تفعيل 📳 البوت 🤖  في هذا المجموعة !_", 0, "md")
     end
  end
if not arg.username then return false end
   if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
  if cmd == "ban" then
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't ban_ *mods,owners and bot admins*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*>* _عذراً ⚠️ لايمكنك حظر ⛔️ - المدراء - المشرفين - الادمنيه - في هذا المجموعة 🚻 !_", 0, "md")
         end
     end
if administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already_ *banned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* * تم حظره ⛔️ مسبقاً من هذا المجموعة 🚻 !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *banned*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "*>* _المستخدم_ "..user_name.." *"..data.id_.."* *تم حظره ⛔️  من هذا المجموعة 🚻 بنجاح ✅  !*", 0, "md")
   end
end
   if cmd == "unban" then
if not administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not_ *banned*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *لم يتم حظره ⛔️ من هذا المجموعة 🚻 !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *unbanned*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "*>* _المستخدم_ "..user_name.." *"..data.id_.."* *تم الغاء الحظر ⛔️ عنه بنجاح ✅ !*", 0, "md")
   end
end
  if cmd == "silent" then
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't silent_ *mods,owners and bot admins*", 0, "md")
    else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*>* _عذراً ⚠️ لايمكنك كتم 🔕 - المدراء - المشرفين - الادمنيه - في هذا المجموعة 🚻 !_", 0, "md")
       end
     end
if administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already_ *silent*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم اضافة ➕ الى قائمة  الكتم 🔕 مسبقاً ✅ !*", 0, "md")
     end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
  if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _added to_ *silent users list*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم اضافة ➕ الى قائمة  الكتم 🔕 بنجاح ✅ !*", 0, "md")
   end
end
  if cmd == "unsilent" then
if not administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not_ *silent*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *لم يتم كتمه 🤐 من هذا المجموعة 🚻 !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _removed from_ *silent users list*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم الغاء الكتم 🔕 عنه في هذا المجموعة 🚻 بنجاح ✅ !*", 0, "md")
   end
end
  if cmd == "banall" then
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
   if is_admin1(data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't_ *globally ban* _other admins_", 0, "md")
  else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*>* _عذراً ⚠️ لايمكنك حظر عام ⛔️ - المدراء - المشرفين - الادمنيه - في هذا المجموعة 🚻 !_", 0, "md")
        end
     end
if is_gbanned(data.id_) then
   if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already_ *globally banned*", 0, "md")
    else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم حظره  عام 🚫  من هذا المجموعة 🚻 مسبقاً ✅  !*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
     if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *globally banned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم حظره  عام 📵  من جميع مجموعاتي 🚻 بنجاح ✅  !*", 0, "md")
   end
end
  if cmd == "unbanall" then
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
if not is_gbanned(data.id_) then
     if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not_ *globally banned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *لم يتم  حظره  عام 📵  من جميع مجموعاتي 🚻   !*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *globally unbanned*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم الغاء ❌  حظره  عام 📵  من جميع مجموعاتي 🚻 بنجاح ✅   !*", 0, "md")
   end
end
  if cmd == "kick" then
   if is_mod1(arg.chat_id, data.id_) then
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't kick_ *mods,owners and bot admins*", 0, "md")
    elseif lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*>* _عذراً ⚠️ لايمكنك طرد 🚷 - المدراء - المشرفين - الادمنيه - في هذا المجموعة 🚻 !_", 0, "md")
   end
  else
     kick_user(data.id_, arg.chat_id)
     end
  end
  if cmd == "delall" then
   if is_mod1(arg.chat_id, data.id_) then
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't delete messages_ *mods,owners and bot admins*", 0, "md")
   elseif lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*>* _عذراً ⚠️ لايمكنك حذف رسائل 🚮 - المدراء - المشرفين - الادمنيه - في هذا المجموعة 🚻 !_", 0, "md")
   end
  else
tdcli.deleteMessagesFromUser(arg.chat_id, data.id_, dl_cb, nil)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_All_ *messages* _of_ "..user_name.." *[ "..data.id_.." ]* _has been_ *deleted*", 0, "md")
      elseif lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*جميع رسائل 📑 :-* "..user_name.." *[ "..data.id_.." ]* *تم حذفها 🚮 بنجاح !*", 0, "md")
       end
    end
  end
if cmd == "setmanager" then
  channel_set_admin(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group manager*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *ادمین گروه شد*", 0, "md")
   end
end
if cmd == "remmanager" then
  channel_demote(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer_ *group manager*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از ادمینی گروه برکنار شد*", 0, "md")
   end
 end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already in_ *white list*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *بلفعل تم اضافة ➕ الى القائمة البيضاء 🗒  !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been added to_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم اضافة ➕ الى القائمة البيضاء 🗒 بنجاح ✅ !*", 0, "md")
   end
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not in_ *white list*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "*>* _المستخدم_ "..user_name.." *"..data.id_.."* *لم يتم اضافة ➕ الى القائمة البيضاء 🗒 !*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been removed from_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم ازالة 🚮 من القائمة البيضاء 🗒 بنجاح !*", 0, "md")
   end
end
if cmd == "setowner" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *بلفعل تم رفعة مدير 👮🏻 في هذا المجموعة ✅ !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام صاحب گروه منتصب شد*", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *بلفعل تم رفعة ادمن 🚻 في هذا المجموعة ✅ !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم رفعة  ادمن 🚻 في هذا المجموعة ✅ !*", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *لم يتم رفعة مدير 👮🏻 في هذا المجموعة 🚻 !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *لم يعد  مدير 🚻 هذا المجموعة ⚠️ !*", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم تنزيلة 📥 من ادمنية 🚻 المجموعة ! *", 0, "md")
   end
end
   if cmd == "id" then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
    if cmd == "res" then
    if not lang then
     text = "Result for [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. ""..check_markdown(data.title_).."\n"
    .. " ["..data.id_.."]"
  else
     text = "معلومات عن ℹ️ [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. "".. check_markdown(data.title_) .."\n"
    .. " [".. data.id_ .."]"
         end
       return tdcli.sendMessage(arg.chat_id, 0, 1, text, 1, 'md')
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_لم يتم العثور 🔍 على المستخدم !_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "*>* _المجموعة 🚻 لم يتم تفعيلها اطلب من المطور 🤖 تفعيل البوت في مجموعتك ✅ !_", 0, "md")
     end
  end
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.first_name_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if cmd == "setmanager" then
  channel_set_admin(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group manager*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *ادمین گروه شد*", 0, "md")
   end
end
if cmd == "remmanager" then
  channel_demote(arg.chat_id, data.id_)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer_ *group manager*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *لم يعد  مشرف 👨🏻‍🔧 هذا المجموعة ⚠️ !*", 0, "md")
   end
 end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already in_ *white list*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم اضافة ➕ الى القائمة البيضاء 🗒 مسبقاً !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been added to_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم اضافة ➕ الى القائمة البيضاء 🗒 بنجاح !*", 0, "md")
   end
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not in_ *white list*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *لم يتم اضافة 📥  الى القائمة البيضاء 🗒 !*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been removed from_ *white list*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *تم ازالة 🚮 من القائمة البيضاء 🗒 !*", 0, "md")
   end
end
  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *بلفعل مدير 👮🏻 هذهِ المجموعة 🚻 !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *لم يعد  مدير 🚻 هذا المجموعة ⚠️ !*", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *تم رفعة ادمن 🚻 في هذا المجموعة  مسبقاً ✅ !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "*>* _المستخدم_ "..user_name.." *"..data.id_.."* *تم رفعة ادمن 🚻 في هذا المجموعة ✅ !*", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *لم يعد  مدير 🚻 هذا المجموعة ⚠️ !*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم_ "..user_name.." *"..data.id_.."* *لم يعد  مدير 🚻 هذا المجموعة ⚠️ !*", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_المستخدم__ "..user_name.." *"..data.id_.."* *تم تنزيلة📥 من ادمنية 🚻 المجموعة !*", 0, "md")
   end
end
    if cmd == "whois" then
if data.username_ then
username = '@'..check_markdown(data.username_)
else
if not lang then
username = 'not found'
 else
username = 'ندارد'
  end
end
     if not lang then
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'Info for [ '..data.id_..' ] :\nUserName : '..username..'\nName : '..data.first_name_, 1)
   else
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'معلومات عن ℹ️ : [ '..data.id_..' ] :\nالمعرف : '..username..'\nالاسم : '..data.first_name_, 1)
      end
   end
 else
    if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User not founded_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*>* _لم يتم العثور 🔍 على المستخدم !_", 0, "md")
    end
  end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*>* _لم يتم العثور 🔍 على المستخدم !_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end


---------------Lock Link-------------------
local function lock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ انت ليس ادمن 🚻 في هذا المجموعة !_"
end
end

local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == "yes" then
if not lang then
 return "*>* _Link_ *Posting Is Already* _Locked_"
elseif lang then
 return "*>* _الروابط 📎 بلفعل تم قفلها 🔐 في المجموعة_"
end
else
data[tostring(target)]["settings"]["lock_link"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*>* _Link_ *Posting Has Ben * _Locked_\n*BY :* `"..msg.from.id.."`"
else
 return "*>* _تم قفل 🔐 الروابط 📎 في هذا المجموعة !_\n*بواسطة :* `"..user_name.."`"
end
end
end

local function unlock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ انت ليس ادمن 🚻 في هذا المجموعة !_"
end
end 

local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == "no" then
if not lang then
return "*>* _Link_ *Posting is Not * _Locked_" 
elseif lang then
return "‎*>* _الروابط 📎 لم يتم قفلها 🔓  في المجموعة ! _ "
end
else 
data[tostring(target)]["settings"]["lock_link"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*>* _Link_ *Posting Has Ben * _UnLocked_\n *BY :* `"..msg.from.id.."`" 
else
return "*>* _تم فتح  🔓 الروابط 📎 في المجموعة ✅_ \n*بواسطة :* `"..user_name.."`"
end
end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ انت ليس ادمن 🚻 في هذا المجموعة !_"
end
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == "yes" then
if not lang then
 return "‏*>* _Tag_ *Posting Is Already* _Locked_"
elseif lang then
 return "‎*>* _التاك #️⃣ بلفعل تم قفلها 🔐 في المجموعة_"
end
else
 data[tostring(target)]["settings"]["lock_tag"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*>* _Tag_ *Posting Has Ben * _Locked_\n *BY :* `"..msg.from.id.."`"
else
 return "*>* _تم قفل 🔐 التاك #️⃣  في هذا المجموعة ✅!_\n*بواسطة :* `"..user_name.."`"
end
end
end

local function unlock_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ انت ليس ادمن 🚻 في هذا المجموعة !_"
end 
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
 if lock_tag == "no" then
if not lang then
return "‏*>* _Tag_ *Posting is Not * _Locked_" 
elseif lang then
return "‎*>* _التاك #️⃣  لم يتم قفلها 🔓  في المجموعة ! _"
end
else 
data[tostring(target)]["settings"]["lock_tag"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*>* _Tag_ *Posting Has Ben * _UnLocked_\n *BY :* `"..msg.from.id.."`" 
else
return "*>* _تم فتح 🔓  التعديل 📝  في هذا المجموعة ✅!_\n*بواسطة :-* `"..user_name.."`"
end
end
end

---------------Lock Username-------------------
local function lock_username(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ انت ليس ادمن 🚻 في هذا المجموعة !_"
end
end

local lock_username = data[tostring(target)]["settings"]["lock_username"] 
if lock_username == "yes" then
if not lang then
 return "‏*>* _Username_ *Posting Is Already* _Locked_"
elseif lang then
 return "*>* _المعرف 🚹 بلفعل تم قفلها 🔐 في المجموعة_"
end
else
data[tostring(target)]["settings"]["lock_username"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*>* _username_ *Posting Has Ben * _Locked_\n *BY :* `"..msg.from.id.."`"
else
 return "*>* _تم قفل 🔐  المعرف 🚹  في هذا المجموعة ✅!_\n*بواسطة :-* `"..user_name.."`"
end
end
end

local function unlock_username(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ انت ليس ادمن 🚻 في هذا المجموعة !_"
end
end 

local lock_username = data[tostring(target)]["settings"]["lock_username"]
 if lock_username == "no" then
if not lang then
return "‏*>* _Username_ *Posting is Not * _Locked_" 
elseif lang then
return "‎*>* _المعرف 🚹 لم يتم قفلة 🔐 في المجموعة_"
end
else 
data[tostring(target)]["settings"]["lock_username"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*>* _Username_ *Posting Has Ben * _UnLocked_\n *BY :* `"..msg.from.id.."`" 
else
return "*>* _تم فتح 🔓  المعرف 🚹  في هذا المجموعة ✅!_\n*بواسطة :-* `"..user_name.."`"
end
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
 local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ انت ليس ادمن 🚻 في هذا المجموعة !_"
end
end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == "yes" then
if not lang then
 return "*>* _Mention_ *Posting Is Already* _Locked_"
elseif lang then
 return "ارسال فراخوانی افراد هم اکنون ممنوع است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["lock_mention"] = "yes"
save_data(_config.moderation.data, data)
if not lang then 
 return "*>* _mention_ *Posting Has Ben * _Locked_\n *BY :* `"..msg.from.id.."`"
else 
 return "ارسال فراخوانی افراد در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ انت ليس ادمن 🚻 في هذا المجموعة !_"
end
end 

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
 if lock_mention == "no" then
if not lang then
return "*>* _Mention_ *Posting is Not * _Locked_" 
elseif lang then
return "ارسال فراخوانی افراد در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_mention"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*>* _mention_ *Posting Has Ben * _UnLocked_\n *BY :* `"..msg.from.id.."`" 
else
return "ارسال فراخوانی افراد در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock Arabic--------------
local function lock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ انت ليس ادمن 🚻 في هذا المجموعة !_"
end
end

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"] 
if lock_arabic == "yes" then
if not lang then
 return "*>*  *Arabic* _Posting Is Already_ *Locked*"
elseif lang then
 return "‎*>* _اللغة العربية 🔤 بلفعل تم قفلها 🔐 في المجموعة_"
end
else
data[tostring(target)]["settings"]["lock_arabic"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*>* _Arabic_ *Posting Has Ben * _Locked_\n *BY :* `"..msg.from.id.."`"
else
 return "*>* _تم قفل 🔐  اللغة العربية 🔡  في هذا المجموعة ✅!_\n*بواسطة :-* `"..msg.from.id.."`"
end
end
end

local function unlock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ انت ليس ادمن 🚻 في هذا المجموعة !_"
end
end 

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"]
 if lock_arabic == "no" then
if not lang then
return "‏*>* _Arabic_ *Posting is Not * _Locked_" 
elseif lang then
return "‎*>* _اللغة العربية 🔡 لم يتم قفلة 🔐 في هذا  المجموعة_"
end
else 
data[tostring(target)]["settings"]["lock_arabic"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*>* _Arabic_ *Posting Has Ben * _UnLocked_\n *BY :* `"..msg.from.id.."`" 
else
return "*>* _تم فتح 🔓  اللغة العربية 🔤  في هذا المجموعة ✅!_\n*بواسطة :-* `"..msg.from.id.."`"
end
end
end

---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == "yes" then
if not lang then
 return "‏*>* _Editing_ *Posting Is Already* _Locked_"
elseif lang then
 return "*>* _التعديل 📝  بلفعل تم قفلها 🔐 في  هذا المجموعة_"
end
else
 data[tostring(target)]["settings"]["lock_edit"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*>* _Editing_ *Posting Has Ben * _Locked_\n *BY :* `"..msg.from.id.."`"
else
 return "*>* _تم فتح 🔓  التعديل 📝  في هذا المجموعة ✅!_\n*بواسطة :-* `"..msg.from.id.."`"
end
end
end

local function unlock_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ انت ليس ادمن 🚻 في هذا المجموعة !_"
end
end 

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
 if lock_edit == "no" then
if not lang then
return "*>* _Editing_ *Posting is Not * _Locked_" 
elseif lang then
return "*>* _ هذا التعديل  📝 لم يتم قفلة 🔐 في المجموعة_"
end
else 
data[tostring(target)]["settings"]["lock_edit"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "‏*>* _Editing_ *Posting Has Ben * _UnLocked_\n *BY :* `"..msg.from.id.."`" 
else
return "*>* _تم فتح 🔓  التعديل 📝  في هذا المجموعة ✅!_\n*بواسطة :-* `"..msg.from.id.."`"
end
end
end

---------------Lock spam-------------------
local function lock_spam(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ انت ليس ادمن 🚻 في هذا المجموعة !_"
end
end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == "yes" then
if not lang then
 return "*>* _Spam_ *Posting Is Already* _Locked_"
elseif lang then
 return "‎*>* _الكلايش 📑  بلفعل تم قفلها 🔐 في المجموعة_"
end
else
 data[tostring(target)]["settings"]["lock_spam"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "‏*>* _Spam_ *Posting Has Ben * _Locked_\n *BY :* `"..msg.from.id.."`"
else
 return "‎*>* _تم قفل 🔐  الكلايش الطويلة 📑  في هذا المجموعة ✅!_\n*بواسطة :* `"..msg.from.id.."`"
end
end
end

local function unlock_spam(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end 

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
 if lock_spam == "no" then
if not lang then
return "‏*>* _Spam_ *Posting is Not * _Locked_" 
elseif lang then
 return "‎*>* _الكلايش الطويلة 📑 لم يتم قفلة 🔐 في هذا المجموعة_"
end
else 
data[tostring(target)]["settings"]["lock_spam"] = "no" 
save_data(_config.moderation.data, data)
if not lang then 
return "‏*>* _Spam_ *Posting Has Ben * _UnLocked_\n *BY :* `"..msg.from.id.."`" 
else
 return "‎*>* _تم فتح 🔓  الكلايش الطويلة 📑  في هذا المجموعة ✅!_\n*بواسطة :* `"..msg.from.id.."`"
end
end
end

---------------Lock Badword-------------------
local function lock_badword(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local lock_badword = data[tostring(target)]["settings"]["lock_badword"] 
if lock_badword == "yes" then
if not lang then
 return "*>* _badword_ *Posting Is Already* _Locked_"
elseif lang then
 return "*>* _الكلام السيء 🔞  بلفعل تم قفلها 🔐 في المجموعة_"
end
else
data[tostring(target)]["settings"]["lock_badword"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*>* _Badword_ *Posting Has Ben * _Locked_\n *BY :* `"..msg.from.id.."`"
else
 return "‎*>* _تم قفل 🔐  الكلام السيء 🔞  في هذا المجموعة ✅!_\n*بواسطة :-* `"..msg.from.id.."`"
end
end
end

local function unlock_badword(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end 

local lock_badword = data[tostring(target)]["settings"]["lock_badword"]
 if lock_badword == "no" then
if not lang then
return "*>* _Badword_ *Posting is Not * _Locked_" 
elseif lang then
return "*>* _الكلام السيء 🔞 لم يتم قفلة 🔓  في المجموعة ! _"
end
else 
data[tostring(target)]["settings"]["lock_badword"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*>* _Badword_ *Posting Has Ben * _Locked_\n *BY :* `"..msg.from.id.."`" 
else
return "‎*>* _تم فتح 🔓  الكلام السيء 🔞  في هذا المجموعة ✅!_\n*بواسطة :-* `"..msg.from.id.."`"
end
end
end

---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local lock_flood = data[tostring(target)]["settings"]["lock_flood"] 
if lock_flood == "yes" then
if not lang then
 return "‏*>* _Flood_ *Posting Is Already* _Locked_"
elseif lang then
 return "‎*>* _التكرار 🔢  بلفعل تم قفلها 🔐 في هذا المجموعة_"
end
else
 data[tostring(target)]["settings"]["lock_flood"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "‏*>* _Flood_ *Posting Has Ben * _Locked_\n *BY :* `"..msg.from.id.."`"
else
 return "‎*>* _تم قفل 🔐  التكرار  🔢  في هذا المجموعة ✅!_\n*بواسطة :* `"..msg.from.id.."`"
end
end
end

local function unlock_flood(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end 

local lock_flood = data[tostring(target)]["settings"]["lock_flood"]
 if lock_flood == "no" then
if not lang then
return "‏*>* _Flood_ *Posting is Not * _Locked_" 
elseif lang then
return "‎*>* _التكرار 🔢  لم يتم قفلها 🔓  في المجموعة ! _"
end
else 
data[tostring(target)]["settings"]["lock_flood"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "‏*>* _Flood_ *Posting Has Ben * _UnLocked_\n *BY :* `"..msg.from.id.."`" 
else
return "‎*>* _تم فتح 🔓  التكرار  🔢  في هذا المجموعة ✅!_\n*بواسطة :-* `"..msg.from.id.."`"
end
end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "yes" then
if not lang then
 return "‏*>* _Bots_ *Posting Is Already* _Locked_"
elseif lang then
 return "‎*>* _البوتات  🤖  بلفعل تم قفلها 🔐 في هذا  المجموعة_"
end
else
 data[tostring(target)]["settings"]["lock_bots"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "‏*>* _Bots_ *Posting Has Ben * _Locked_\n *BY :* `"..msg.from.id.."`"
else
 return "‎*>* _تم قفل 🔐  البوتات  🤖  في هذا المجموعة ✅!_\n*بواسطة :* `"..msg.from.id.."`"
end
end
end

local function unlock_bots(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end 
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == "no" then
if not lang then
return "‏*>* _Bots_ *Posting is Not * _Locked_" 
elseif lang then
return "‎*>* _البوتات 🤖  لم يتم قفلها 🔓  في المجموعة ! _"
end
else 
data[tostring(target)]["settings"]["lock_bots"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "‏*>* _Bots_ *Posting Has Ben * _UnLocked_\n *BY :* `"..msg.from.id.."`" 
else
return "‎*>* _تم فتح 🔓  البوتات  🤖  في هذا المجموعة ✅!_\n*بواسطة :-* `"..msg.from.id.."`"
end
end
end

---------------Lock Join-------------------
local function lock_join(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local lock_join = data[tostring(target)]["settings"]["lock_join"] 
if lock_join == "yes" then
if not lang then
 return "*>* _Join_ *Posting Is Already* _Locked_"
elseif lang then
 return "*>* _الاضافة ➕ بلفعل تم قفلها 🔐 في المجموعة_"
end
else
 data[tostring(target)]["settings"]["lock_join"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*>* _Join_ *Posting Has Ben * _Locked_\n *BY :* `"..msg.from.id.."`"
else
 return "‎*>* _تم قفل 🔐  الاضافة 🚻  في هذا المجموعة ✅!_\n*بواسطة :* `"..msg.from.id.."`"
end
end
end

local function unlock_join(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end 
end

local lock_join = data[tostring(target)]["settings"]["lock_join"]
 if lock_join == "no" then
if not lang then
return "‏*>* _Join_ *Posting is Not * _Locked_" 
elseif lang then
return "‎*>* _الاضافة ➕  لم يتم قفلها 🔓  في المجموعة ! _"
end
else 
data[tostring(target)]["settings"]["lock_join"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "*>* _Join_ *Posting Has Ben * _UnLocked_\n *BY :* `"..msg.from.id.."`" 
else
return "*>* _تم فتح 🔓  الاضافة 🚻  في هذا المجموعة ✅!_\n*بواسطة :* `"..msg.from.id.."`"
end
end
end

---------------Lock Tabchi-------------------
local function lock_tabchi(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local lock_tabchi = data[tostring(target)]["settings"]["lock_tabchi"] 
if lock_tabchi == "yes" then
if not lang then
 return "`Ƭαвcнι` *Ƥσѕтιηg Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "تبچی در گروه هم اکنون ممنوع است⚠️♻️"
end
else
data[tostring(target)]["settings"]["lock_tabchi"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`Ƭαвcнι` *Ƥσѕтιηg Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "تبچی در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_tabchi(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end 

local lock_tabchi = data[tostring(target)]["settings"]["lock_tabchi"]
 if lock_tabchi == "no" then
if not lang then
return "`Ƭαвcнι` *Ƥσѕтιηg Iѕ Ɲσт Lσcкєɗ*⚠️🚫" 
elseif lang then
return "تبچی در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_tabchi"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "`Ƭαвcнι` *Ƥσѕтιηg Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "تبچی در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == "yes" then
if not lang then 
 return "‏*>* _Markdown_ *Posting Is Already* _Locked_"
elseif lang then
 return "*>* _الماركدون Ⓜ️  بلفعل تم قفلها 🔐 في المجموعة_"
end
else
 data[tostring(target)]["settings"]["lock_markdown"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "‏*>* _Markdown_ *Posting Is Already* _Locked_ `"..msg.from.id.."`"
else
 return "*>* _تم قفل 🔐  الماركدون Ⓜ️  في هذا المجموعة ✅!_\n*بواسطة :* `"..msg.from.id.."`"
end
end
end

local function unlock_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end 
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
 if lock_markdown == "no" then
if not lang then
return "‏*>* _Markdown_ *Posting is Not * _Locked_"
elseif lang then
return "*>* _الماركدون Ⓜ️ لم يتم قفلها 🔓  في المجموعة ! _"
end
else 
data[tostring(target)]["settings"]["lock_markdown"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "*>* _Markdown_ *Posting Has Ben * _UnLocked_\n *BY :* `"..msg.from.id.."`"
else
return "*>* _تم فتح 🔓  الماركدون Ⓜ️  في هذا المجموعة ✅!_\n*بواسطة :-* `"..msg.from.id.."`"
end
end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == "yes" then
if not lang then
 return "`Ɯєвραgє` *Iѕ AƖяєαɗу Lσcкєɗ*⚠️♻️"
elseif lang then
 return "ارسال صفحات وب در گروه هم اکنون ممنوع است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["lock_webpage"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "`Ɯєвραgє` *Hαѕ Ɓєєη Lσcкєɗ*🔒\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "ارسال صفحات وب در گروه ممنوع شد🔒\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unlock_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end 
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
 if lock_webpage == "no" then
if not lang then
return "`Ɯєвραgє` *Iѕ Ɲσт Lσcкєɗ*⚠️🚫" 
elseif lang then
return "ارسال صفحات وب در گروه ممنوع نمیباشد⚠️🚫"
end
else 
data[tostring(target)]["settings"]["lock_webpage"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "`Ɯєвραgє` *Hαѕ Ɓєєη UηƖσcкєɗ*🔓\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "ارسال صفحات وب در گروه آزاد شد🔓\n*توسط :* `"..msg.from.id.."`"
end
end
end

---------------Lock English-------------------
local function lock_english(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local lock_badword = data[tostring(target)]["settings"]["lock_english"] 
if lock_english == "yes" then
if not lang then
 return "*>* _English_ *Posting Is Already* _Locked_"
elseif lang then
 return "*>* _اللغة الانكليزيه 🔠 بلفعل تم قفلها 🔐 في المجموعة_"
end
else
data[tostring(target)]["settings"]["lock_english"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "‏*>* _English_ *Posting Has Ben * _Locked_\n *BY :* `"..msg.from.id.."`"
else
 return "*>* _تم قفل 🔐  اللغة الانكليزية 🔠  في هذا المجموعة ✅!_\n*بواسطة :* `"..msg.from.id.."`"
end
end
end

local function unlock_english(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end 

local lock_english = data[tostring(target)]["settings"]["lock_english"]
 if lock_english == "no" then
if not lang then
return "‏*>* _Engleish_ *Posting is Not * _Locked_" 
elseif lang then
return "‎*>* _اللغة الانكليزية 🔠 لم يتم قفلها 🔓  في المجموعة ! _"
end
else 
data[tostring(target)]["settings"]["lock_english"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "‏*>* _Engleish_ *Posting Has Ben * _UnLocked_\n *BY :* `"..msg.from.id.."`" 
else
return "‎*>* _تم فتح 🔓  اللغة الانكليزية 🔠  في هذا المجموعة ✅!_\n*بواسطة :-* `"..msg.from.id.."`"
end
end
end

---------------Lock Pin-------------------
local function lock_pin(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "*>* _You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == "yes" then
if not lang then
 return "‏*>* _Pin_ *Posting Is Already* _Locked_"
elseif lang then
 return "‎*>* _التثبيت  📩  بلفعل تم قفلها 🔐 في المجموعة_"
end
else
 data[tostring(target)]["settings"]["lock_pin"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "*>* _Pinned Message_ *Posting Has Ben * _Locked_\n *BY :* `"..msg.from.id.."`"
else
 return "‎*>* _تم قفل 🔐  التعديل 📩  في هذا المجموعة ✅!_\n*بواسطة :* `"..msg.from.id.."`"
end
end
end

local function unlock_pin(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end 
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
 if lock_pin == "no" then
if not lang then
return "‏*>* _Pinned Message_ *Posting is Not * _Locked_" 
elseif lang then
return "‎*>* _التثبيت 📩 لم يتم قفلها 🔓  في المجموعة ! _"
end
else 
data[tostring(target)]["settings"]["lock_pin"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "‏*>* _Pinned Message_ *Posting Has Ben * _UnLocked_\n *BY :* `"..msg.from.id.."`" 
else
return "‎*>* _تم فتح 🔓  التثبيت  📩  في هذا المجموعة ✅!_\n*بواسطة :-* `"..msg.from.id.."`"
end
end
end

--------settings---------
---------------Mute Gif-------------------
local function mute_gif(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local mute_gif = data[tostring(target)]["settings"]["mute_gif"] 
if mute_gif == "yes" then
if not lang then
 return "*>* _Mute Gifs_ *Posting Is Already* _Locked_"
elseif lang then
 return "‎*>* _الصور المتحركة 📽 بلفعل تم قفلها 🔐 في المجموعة_"
end
else
 data[tostring(target)]["settings"]["mute_gif"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then 
 return "‏*>* _Mute Gifs_ *Posting Has Ben * _Locked_\n *BY :* `"..msg.from.id.."`"
else
 return "*>* _تم قفل 🔐  الصور المتحركة  📽  في هذا المجموعة ✅!_\n*بواسطة :-* `"..msg.from.id.."`"
end
end
end

local function unmute_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end 

local mute_gif = data[tostring(target)]["settings"]["mute_gif"]
 if mute_gif == "no" then
if not lang then
return "*>* *Mute Gifs* *is Already* _Enabled_" 
elseif lang then
return "بیصدا کردن تصاویر متحرک غیر فعال بود⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_gif"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє Ɠιf` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "*>* _تم فتح 🔓  الصور المتحركة  📽  في هذا المجموعة ✅!_\n*بواسطة :-* `"..msg.from.id.."`"
end
end
end
---------------Mute Game-------------------
local function mute_game(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local mute_game = data[tostring(target)]["settings"]["mute_game"] 
if mute_game == "yes" then
if not lang then
 return "`Mυтє Ɠαмє` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن بازی های تحت وب فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_game"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Ɠαмє` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن بازی های تحت وب فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end 
end

local mute_game = data[tostring(target)]["settings"]["mute_game"]
 if mute_game == "no" then
if not lang then
return "`Mυтє Ɠαмє` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن بازی های تحت وب غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_game"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "`Mυтє Ɠαмє` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن بازی های تحت وب غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Inline-------------------
local function mute_inline(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local mute_inline = data[tostring(target)]["settings"]["mute_inline"] 
if mute_inline == "yes" then
if not lang then
 return "`Mυтє IηƖιηє` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن کیبورد شیشه ای فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_inline"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє IηƖιηє` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن کیبورد شیشه ای فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end 

local mute_inline = data[tostring(target)]["settings"]["mute_inline"]
 if mute_inline == "no" then
if not lang then
return "`Mυтє IηƖιηє` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن کیبورد شیشه ای غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_inline"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє IηƖιηє` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن کیبورد شیشه ای غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Text-------------------
local function mute_text(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local mute_text = data[tostring(target)]["settings"]["mute_text"] 
if mute_text == "yes" then
if not lang then
 return "`Mυтє Ƭєxт` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن متن فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_text"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Ƭєxт` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن متن فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end 
end

local mute_text = data[tostring(target)]["settings"]["mute_text"]
 if mute_text == "no" then
if not lang then
return "`Mυтє Ƭєxт` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫"
elseif lang then
return "بیصدا کردن متن غیر فعال است⚠️🚫" 
end
else 
data[tostring(target)]["settings"]["mute_text"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє Ƭєxт` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن متن غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute photo-------------------
local function mute_photo(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local mute_photo = data[tostring(target)]["settings"]["mute_photo"] 
if mute_photo == "yes" then
if not lang then
 return "`Mυтє Ƥнσтσ` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن عکس فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_photo"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Ƥнσтσ` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن عکس فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end
 
local mute_photo = data[tostring(target)]["settings"]["mute_photo"]
 if mute_photo == "no" then
if not lang then
return "`Mυтє Ƥнσтσ` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن عکس غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_photo"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє Ƥнσтσ` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن عکس غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Video-------------------
local function mute_video(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local mute_video = data[tostring(target)]["settings"]["mute_video"] 
if mute_video == "yes" then
if not lang then
 return "`Mυтє Ʋιɗєσ` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن فیلم فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_video"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then 
 return "`Mυтє Ʋιɗєσ` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن فیلم فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end 

local mute_video = data[tostring(target)]["settings"]["mute_video"]
 if mute_video == "no" then
if not lang then
return "`Mυтє Ʋιɗєσ` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن فیلم غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_video"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє Ʋιɗєσ` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن فیلم غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Audio-------------------
local function mute_audio(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local mute_audio = data[tostring(target)]["settings"]["mute_audio"] 
if mute_audio == "yes" then
if not lang then
 return "`Mυтє Aυɗισ` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن آهنگ فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_audio"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Aυɗισ` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else 
return "بیصدا کردن آهنگ فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end 

local mute_audio = data[tostring(target)]["settings"]["mute_audio"]
 if mute_audio == "no" then
if not lang then
return "`Mυтє Aυɗισ` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن آهنک غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_audio"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "`Mυтє Aυɗισ` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
return "بیصدا کردن آهنگ غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`" 
end
end
end
---------------Mute Voice-------------------
local function mute_voice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local mute_voice = data[tostring(target)]["settings"]["mute_voice"] 
if mute_voice == "yes" then
if not lang then
 return "`Mυтє Ʋσιcє` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن صدا فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_voice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Ʋσιcє` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن صدا فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end 

local mute_voice = data[tostring(target)]["settings"]["mute_voice"]
 if mute_voice == "no" then
if not lang then
return "`Mυтє Ʋσιcє` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن صدا غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_voice"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "`Mυтє Ʋσιcє` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن صدا غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Sticker-------------------
local function mute_sticker(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local mute_sticker = data[tostring(target)]["settings"]["mute_sticker"] 
if mute_sticker == "yes" then
if not lang then
 return "`Mυтє Sтιcкєя` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن برچسب فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_sticker"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Sтιcкєя` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن برچسب فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end 
end

local mute_sticker = data[tostring(target)]["settings"]["mute_sticker"]
 if mute_sticker == "no" then
if not lang then
return "`Mυтє Sтιcкєя` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن برچسب غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_sticker"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "`Mυтє Sтιcкєя` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
return "بیصدا کردن برچسب غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end 
end
end
---------------Mute Contact-------------------
local function mute_contact(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local mute_contact = data[tostring(target)]["settings"]["mute_contact"] 
if mute_contact == "yes" then
if not lang then
 return "`Mυтє Ƈσηтαcт` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن مخاطب فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_contact"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Ƈσηтαcт` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن مخاطب فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end 

local mute_contact = data[tostring(target)]["settings"]["mute_contact"]
 if mute_contact == "no" then
if not lang then
return "`Mυтє Ƈσηтαcт` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن مخاطب غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_contact"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє Ƈσηтαcт` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن مخاطب غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Forward-------------------
local function mute_forward(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local mute_forward = data[tostring(target)]["settings"]["mute_forward"] 
if mute_forward == "yes" then
if not lang then
 return "`Mυтє Ƒσяωαяɗ` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن نقل قول فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_forward"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Ƒσяωαяɗ` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن نقل قول فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end 

local mute_forward = data[tostring(target)]["settings"]["mute_forward"]
 if mute_forward == "no" then
if not lang then
return "`Mυтє Ƒσяωαяɗ` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫"
elseif lang then
return "بیصدا کردن نقل قول غیر فعال است⚠️🚫"
end 
else 
data[tostring(target)]["settings"]["mute_forward"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "`Mυтє Ƒσяωαяɗ` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن نقل قول غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Location-------------------
local function mute_location(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local mute_location = data[tostring(target)]["settings"]["mute_location"] 
if mute_location == "yes" then
if not lang then
 return "`Mυтє Lσcαтιση` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن موقعیت فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_location"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then
 return "`Mυтє Lσcαтιση` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن موقعیت فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_location(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end 

local mute_location = data[tostring(target)]["settings"]["mute_location"]
 if mute_location == "no" then
if not lang then
return "`Mυтє Lσcαтιση` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن موقعیت غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_location"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє Lσcαтιση` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن موقعیت غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute Document-------------------
local function mute_document(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local mute_document = data[tostring(target)]["settings"]["mute_document"] 
if mute_document == "yes" then
if not lang then
 return "`Mυтє Ɗσcυмєηт` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن اسناد فعال لست⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_document"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Ɗσcυмєηт` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
 return "بیصدا کردن اسناد فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end 

local mute_document = data[tostring(target)]["settings"]["mute_document"]
 if mute_document == "no" then
if not lang then
return "`Mυтє Ɗσcυмєηт` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫" 
elseif lang then
return "بیصدا کردن اسناد غیر فعال است⚠️🚫"
end
else 
data[tostring(target)]["settings"]["mute_document"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє Ɗσcυмєηт` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`" 
else
return "بیصدا کردن اسناد غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end
end
end
---------------Mute TgService-------------------
local function mute_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local mute_tgservice = data[tostring(target)]["settings"]["mute_tgservice"] 
if mute_tgservice == "yes" then
if not lang then
 return "`Mυтє ƬgSєяνιcє` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن خدمات تلگرام فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_tgservice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє ƬgSєяνιcє` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
return "بیصدا کردن خدمات تلگرام فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end 
end

local mute_tgservice = data[tostring(target)]["settings"]["mute_tgservice"]
 if mute_tgservice == "no" then
if not lang then
return "`Mυтє ƬgSєяνιcє` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫"
elseif lang then
return "بیصدا کردن خدمات تلگرام غیر فعال است⚠️🚫"
end 
else 
data[tostring(target)]["settings"]["mute_tgservice"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє ƬgSєяνιcє` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
return "بیصدا کردن خدمات تلگرام غیر فعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end 
end
end

---------------Mute Keyboard-------------------
local function mute_keyboard(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end
end

local mute_keyboard = data[tostring(target)]["settings"]["mute_keyboard"] 
if mute_keyboard == "yes" then
if not lang then
 return "`Mυтє Ƙєувσαяɗ` *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
elseif lang then
 return "بیصدا کردن صفحه کلید فعال است⚠️♻️"
end
else
 data[tostring(target)]["settings"]["mute_keyboard"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "`Mυтє Ƙєувσαяɗ` *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
return "بیصدا کردن صفحه کلید فعال شد🔇\n*توسط :* `"..msg.from.id.."`"
end
end
end

local function unmute_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "*>* _عذراً ⚠️ فقط الادمن  🚻 يمكنه التحكم في البوت 🤖  !_"
end 
end
local mute_keyboard = data[tostring(target)]["settings"]["mute_keyboard"]
 if mute_keyboard == "no" then
if not lang then
return "`Mυтє Ƙєувσαяɗ` *Iѕ AƖяєαɗу ƊιѕαвƖєɗ*⚠️🚫"
elseif lang then
return "بیصدا کردن صفحه کلید غیرفعال است⚠️🚫"
end 
else 
data[tostring(target)]["settings"]["mute_keyboard"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "`Mυтє Ƙєувσαяɗ` *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
else
return "بیصدا کردن صفحه کلید غیرفعال شد🔊\n*توسط :* `"..msg.from.id.."`"
end 
end
end

function group_settings(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if not is_mod(msg) then
if not lang then
 	return "_You're Not_ *Moderator*"
else
  return "شما مدیر گروه نمیباشید"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
if data[tostring(target)]["settings"]["set_char"] then 	
SETCHAR = tonumber(data[tostring(target)]['settings']['set_char'])
	print('custom'..SETCHAR) 	
else 	
SETCHAR = 40
end
if data[tostring(target)]["settings"]["time_check"] then 	
TIME_CHECK = tonumber(data[tostring(target)]['settings']['time_check'])
	print('custom'..TIME_CHECK) 	
else 	
TIME_CHECK = 2
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_username"] then			
data[tostring(target)]["settings"]["lock_username"] = "yes"		
end
end


if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_arabic"] then			
data[tostring(target)]["settings"]["lock_arabic"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_english"] then			
data[tostring(target)]["settings"]["lock_english"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = "no"		
end
end

 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_badword"] then			
 data[tostring(target)]["settings"]["lock_badword"] = "no"		
 end
 end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tabchi"] then			
data[tostring(target)]["settings"]["lock_tabchi"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "no"		
end
end

 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_pin"] then			
 data[tostring(target)]["settings"]["lock_pin"] = "no"		
 end
 end
if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_join"] then			
 data[tostring(target)]["settings"]["lock_join"] = "no"		
 end
 end
 if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_gif"] then			
data[tostring(target)]["settings"]["mute_gif"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_text"] then			
data[tostring(target)]["settings"]["mute_text"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_photo"] then			
data[tostring(target)]["settings"]["mute_photo"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_video"] then			
data[tostring(target)]["settings"]["mute_video"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_audio"] then			
data[tostring(target)]["settings"]["mute_audio"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_voice"] then			
data[tostring(target)]["settings"]["mute_voice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_sticker"] then			
data[tostring(target)]["settings"]["mute_sticker"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_contact"] then			
data[tostring(target)]["settings"]["mute_contact"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_forward"] then			
data[tostring(target)]["settings"]["mute_forward"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_location"] then			
data[tostring(target)]["settings"]["mute_location"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_document"] then			
data[tostring(target)]["settings"]["mute_document"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_tgservice"] then			
data[tostring(target)]["settings"]["mute_tgservice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_inline"] then			
data[tostring(target)]["settings"]["mute_inline"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_game"] then			
data[tostring(target)]["settings"]["mute_game"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_keyboard"] then			
data[tostring(target)]["settings"]["mute_keyboard"] = "no"		
end
end
 local expire_date = ''
local expi = redis:ttl('ExpireDate:'..msg.to.id)
if expi == -1 then
if lang then
	expire_date = 'غير محدود!'
else
	expire_date = 'Unlimited!'
end
else
	local day = math.floor(expi / 86400) + 1
if lang then
	expire_date = day..' ايام'
else
	expire_date = day..' Days'
end
end
local cmdss = redis:hget('group:'..msg.to.id..':cmd', 'bot')
	local cmdsss = ''
	if lang then
	if cmdss == 'owner' then
	cmdsss = cmdsss..'اونر و بالاتر'
	elseif cmdss == 'moderator' then
	cmdsss = cmdsss..'مدیر و بالاتر'
	else
	cmdsss = cmdsss..'کاربر و بالاتر'
	end
	else
	if cmdss == 'owner' then
	cmdsss = cmdsss..'Owner or higher'
	elseif cmdss == 'moderator' then
	cmdsss = cmdsss..'Moderator or higher'
	else
	cmdsss = cmdsss..'Member or higher'
	end
	end
local hash = "muteall:"..msg.to.id
local check_time = redis:ttl(hash)
day = math.floor(check_time / 86400)
bday = check_time % 86400
hours = math.floor( bday / 3600)
bhours = bday % 3600
min = math.floor(bhours / 60)
sec = math.floor(bhours % 60)
if not lang then
if not redis:get(hash) or check_time == -1 then
 mute_all1 = 'no'
elseif tonumber(check_time) > 1 and check_time < 60 then
 mute_all1 = '_enable for_ *'..sec..'* _sec_'
elseif tonumber(check_time) > 60 and check_time < 3600 then
 mute_all1 = '_enable for_ '..min..' _min_ *'..sec..'* _sec_'
elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
 mute_all1 = '_enable for_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
elseif tonumber(check_time) > 86400 then
 mute_all1 = '_enable for_ *'..day..'* _day_ *'..hours..'* _hour_ *'..min..'* _min_ *'..sec..'* _sec_'
 end
elseif lang then
if not redis:get(hash) or check_time == -1 then
 mute_all2 = '*no*'
elseif tonumber(check_time) > 1 and check_time < 60 then
 mute_all2 = '_تم تفعيل لمدة ⏰_ *'..sec..'* _ثانیه_'
elseif tonumber(check_time) > 60 and check_time < 3600 then
 mute_all2 = '_تم تفعيل لمدة ⏰_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه_'
elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
 mute_all2 = '_تم تفعيل لمدة ⏰_ *'..hours..'* _ساعة و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه_'
elseif tonumber(check_time) > 86400 then
 mute_all2 = '_تم تفعيل لمدة ⏰_ *'..day..'* _يوم و_ *'..hours..'* _ساعة و_ *'..min..'* _دقیقه و_ *'..sec..'* _ثانیه_'
 end
end
if not lang then
local settings = data[tostring(target)]["settings"] 
text = "*Settings Group 🌐:*\n*>* *Lock Edit:* "..settings.lock_edit.."\n*>* *Lock Link :* "..settings.lock_link.."\n*>* *Lock Tag :* "..settings.lock_tag.."\n*>* *Lock Join :* "..settings.lock_join.."\n*>* *Lock Flood :* "..settings.lock_flood.."\n*>* *Lock Username :* "..settings.lock_username.."\n*>* *Lock Spam :* "..settings.lock_spam.."\n*>* *Lock Mention :* "..settings.lock_mention.."\n*>* *Lock English :* "..settings.lock_english.."\n*>* *Lock Arabic :* "..settings.lock_arabic.."\n*>* *Lock Webpage :* "..settings.lock_webpage.."\n*>* *Lock Badword :* "..settings.lock_badword.."\n*>* *Lock Markdown :* "..settings.lock_markdown.."\n*>* *Lock Tabchit :* "..settings.lock_tabchi.."\n*>* *Grouo Welcome :* "..settings.welcome.."\n*>* *Lock Pin  :* "..settings.lock_pin.."\n*>* *Lock Bots :* "..settings.lock_bots.."\n*>* *Flood Sensitie :* *"..NUM_MSG_MAX.."*\n*>* *Character sensitiuty :* *"..SETCHAR.."*\n*>* *Flood Check Time :* *"..TIME_CHECK"*\n➖➖➖➖➖➖➖➖➖\n*Group Mute List* : \n*>* *Mute Gif :* "..settings.mute_gif.."\n*>* *Mute Text :* "..settings.mute_text.."\n*>* *Mute Inline :* "..settings.mute_inline.."\n*>* *Mute Game :* "..settings.mute_game.."\n*>* *Mute Photo :* "..settings.mute_photo.."\n*>* *Mute ̅Video :* "..settings.mute_video.."\n*>* *Mute Audio :* "..settings.mute_audio.."\n*>* *Mute ̅Voice :* "..settings.mute_voice.."\n*>* *Mute Sticker :* "..settings.mute_sticker.."\n*>* *Mute Contact :* "..settings.mute_contact.."\n*>* *Mute Forward :* "..settings.mute_forward.."\n*>* *Mute location :* "..settings.mute_location.."\n*>* *Mute document :* "..settings.mute_document.."\n*>* *Mute tgservice :* "..settings.mute_tgservice.."\n*> *Mute Keyboard :* "..settings.mute_keyboard.."\n*>* *Mute All :* "..mute_all1.."\n➖➖➖➖➖➖➖➖➖\n*Exbire Date :* *"..expire_date.."*\n*Bot Commands :* *"..cmdsss.."*\n*Bot Channel:* @Star_Wars\n*Group Lange:* *̅E̅N*"
else
local settings = data[tostring(target)]["settings"] 
 text = "*الاعدادات الخاصه في المجموعة. 📄:*\n*>* _قفل التعديل :_ "..settings.lock_edit.."\n*>*_قفل الروابط 📎:_ "..settings.lock_link.."\n*>* _قفل ورود :_ "..settings.lock_join.."\n*>* _قفل التاك #️⃣ :_ "..settings.lock_tag.."\n*>* _قفل التكرار 📳 :_ "..settings.lock_flood.."\n*>* _قفل المعرف ℹ️ :_ "..settings.lock_username.."\n*>* _قفل الكلايش 🗄 :_ "..settings.lock_spam.."\n*>* _ فراخوانی :_ "..settings.lock_mention.."\n*>* _قفل الانكليزيه 🔠 :_ "..settings.lock_english.."\n*>* _قفل العربيه 🔤 :_ "..settings.lock_arabic.."\n*>* _قفل الاعلانات 🌐 :_ "..settings.lock_webpage.."\n*>* _قفل الكلام السئ 🔞 :_ "..settings.lock_badword.."\n*>* _قفل الماركدون Ⓜ️ :_ "..settings.lock_markdown.."\n*>* _قفل تبچی :_ "..settings.lock_tabchi.."\n*>* _قفل الترحيب 🎉 :_ "..settings.welcome.."\n*>* _قفل التثبيت 📌 :_ "..settings.lock_pin.."\n*>* _قفل البوتات 🤖 :_ "..settings.lock_bots.."\n*>* _عدد التكرار 🔢 :_ *"..NUM_MSG_MAX.."*\n*>* _حداکثر حروف مجاز :_ *"..SETCHAR.."*\n*>* _مدة التكرار في المجموعه :_ *"..TIME_CHECK.."*\n➖➖➖➖➖➖➖➖➖\n*قائمة الكتم 📳* : \n*>* _قفل الصور المتحركة_ :_ "..settings.mute_gif.."\n*>* _قفل الكتابه_ :_ "..settings.mute_text.."\n*>* _الكيبورد الشفاف :_ "..settings.mute_inline.."\n*>* _قفل الالعاب:_ "..settings.mute_game.."\n*>* _قفل الصور 🌉 :_ "..settings.mute_photo.."\n*>* _قفل الفيديو 🎦 :_ "..settings.mute_video.."\n*>* _قفل الصوت 📶 :_ "..settings.mute_audio.."\n*>* _قفل البصمات 🎤 :_ "..settings.mute_voice.."\n*>* _قفل الملصقات 🗽 :_ "..settings.mute_sticker.."\n*>* _بیصدا مخاطب :_ "..settings.mute_contact.."\n*>* _قفل اعادة التوجيه 🔂 :_ "..settings.mute_forward.."\n*>* _قفل المواقع 🌐 :_ "..settings.mute_location.."\n*>* _بیصدا اسناد :_ "..settings.mute_document.."\n*>* _قفل الاشعارات 📲 :_ "..settings.mute_tgservice.."\n*>* _قفل الكيبورد ⌨️	:_ "..settings.mute_keyboard.."\n*>* _قفل جميع الوسائط 📴 :_ "..mute_all2.."\n*____________________*\n_اوامر البوت :_ *"..cmdsss.."*\n_مدة تفعيل البوت ⏰  :_ *"..expire_date.."*\n*قناتنا*: @STAR_WARS\n_ لغة البوت :_ `اللغة العربيه`"
end
text = string.gsub(text, 'yes', '🔒')
text = string.gsub(text, 'no', '🔓')
return text
end


local function run(msg, matches)
if is_banned(msg.from.id, msg.to.id) or is_gbanned(msg.from.id, msg.to.id) or is_silent_user(msg.from.id, msg.to.id) then
return false
end
local cmd = redis:hget('group:'..msg.to.id..':cmd', 'bot')
local mutealll = redis:get('group:'..msg.to.id..':muteall')
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
if cmd == 'moderator' and not is_mod(msg) or cmd == 'owner' and not is_owner(msg) or mutealll and not is_mod(msg) then
 return 
 else
if msg.to.type ~= 'pv' then
if matches[1]:lower() == "id" or matches[1] == 'ايدي' then
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
   if data.photos_[0] then
       if not lang then
            tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'> Chat ID : '..msg.to.id..'\n> User ID : '..msg.from.id,dl_cb,nil)
       elseif lang then
          tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'> ايدي المجموعة 🚻 :-  '..msg.to.id..'\n> ايديك الخاص 🚹 :- '..msg.from.id,dl_cb,nil)
     end
   else
       if not lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "`You Have Not Profile Photo...!`\n\n> *Chat ID :* `"..msg.to.id.."`\n*User ID :* `"..msg.from.id.."`", 1, 'md')
       elseif lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "_لا توجد صورة شخصية في هذا المستخدم !_\n\n*>* _ايدي المجموعة 🚻 :-_ `"..msg.to.id.."`\n*>* _ايديك الخاص 🚹 :-_ `"..msg.from.id.."`", 1, 'md')
            end
        end
   end
   tdcli_function ({
    ID = "GetUserProfilePhotos",
    user_id_ = msg.from.id,
    offset_ = 0,
    limit_ = 1
  }, getpro, nil)
end
if msg.reply_id and not matches[2] then
tdcli.getMessage(msg.to.id, msg.reply_id, action_by_reply, {chat_id=msg.to.id,cmd="id"})
  end
if matches[2] and #matches[2] > 3 and not matches[3] then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="id"})
      end
   end
if (matches[1]:lower() == "pin" or matches[1] == 'تثبيت') and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*"
elseif lang then
return "*>* _تم تثبيت📥 الرسالة بنجاح ✅ !_"
end
elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == 'no' then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*"
elseif lang then
return "*>* _تم تثبيت📥 الرسالة بنجاح ✅ !_"
end
end
end
if (matches[1]:lower() == 'unpin' or matches[1] == 'الغاء التثبيت') and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*"
elseif lang then
return "*>* _تم الغاء تثبيت📥 الرسالة بنجاح ✅ !_"
end
elseif not is_owner(msg) then
   return 
 end
 elseif lock_pin == 'no' then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*"
elseif lang then
return "*>* _تم الغاء تثبيت📥 الرسالة بنجاح ✅ !_"
end
end
end
if matches[1]:lower() == "add" or matches[1] == 'تفعيل' then
return modadd(msg)
end
if matches[1]:lower() == "rem" or matches[1] == 'تعطيل' then
return modrem(msg)
end
if (matches[1]:lower() == "setmanager" or matches[1] == 'رفع مشرف') and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setmanager"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setmanager"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setmanager"})
      end
   end
if (matches[1]:lower() == "remmanager" or matches[1] == 'تنزيل مشرف') and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remmanager"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remmanager"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remmanager"})
      end
   end
if (matches[1]:lower() == "whitelist" or matches[1] == 'القائمه البيضاء') and matches[2] == "+" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="setwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="setwhitelist"})
      end
   end
if (matches[1]:lower() == "whitelist" or matches[1] == 'القائمه البيضاء') and matches[2] == "-" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="remwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="remwhitelist"})
      end
   end
if (matches[1]:lower() == "setowner" or matches[1] == 'رفع مدير') and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
      end
   end
if (matches[1]:lower() == "remowner" or matches[1] == 'تنزيل مدير') and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
      end
   end
if (matches[1]:lower() == "promote" or matches[1] == 'رفع ادمن') and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
      end
   end
if (matches[1]:lower() == "demote" or matches[1] == 'تنزيل ادمن') and is_owner(msg) then
if not matches[2] and msg.reply_id then
 tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
      end
   end
if (matches[1]:lower() == "lock" or matches[1] == 'قفل') and is_mod(msg) then
local target = msg.to.id
if not lang then
if matches[2] == "link" then
return lock_link(msg, data, target)
end
if matches[2] == "tag" then
return lock_tag(msg, data, target)
end
if matches[2] == 'username' then
return lock_username(msg, data, target)
end
if matches[2] == "mention" then
return lock_mention(msg, data, target)
end
if matches[2] == "arabic" then
return lock_arabic(msg, data, target)
end
if matches[2] == 'english' then
return lock_english(msg, data, target)
end
if matches[2] == "edit" then
return lock_edit(msg, data, target)
end
if matches[2] == "spam" then
return lock_spam(msg, data, target)
end
if matches[2] == "flood" then
return lock_flood(msg, data, target)
end
if matches[2] == 'tabchi' then
return lock_tabchi(msg, data, target)
end
if matches[2] == "bots" then
return lock_bots(msg, data, target)
end
if matches[2] == "markdown" then
return lock_markdown(msg, data, target)
end
if matches[2] == "webpage" then
return lock_webpage(msg, data, target)
end
if matches[2] == 'badword' then
return lock_badword(msg, data, target)
end
if matches[2] == "pin" and is_owner(msg) then
return lock_pin(msg, data, target)
end
if matches[2] == "join" then
return lock_join(msg, data, target)
end
if matches[2] == 'cmds' then
			redis:hset('group:'..msg.to.id..':cmd', 'bot', 'moderator')
			return 'cmds has been locked for member'
			end
else
if matches[2] == 'الروابط' then
return lock_link(msg, data, target)
end
if matches[2] == 'التاك' then
return lock_tag(msg, data, target)
end
if matches[2] == 'المعرف' then
return lock_username(msg, data, target)
end
if matches[2] == 'فراخوانی' then
return lock_mention(msg, data, target)
end
if matches[2] == 'العربي' then
return lock_arabic(msg, data, target)
end
if matches[2] == 'الانكليزي' then
return lock_english(msg, data, target)
end
if matches[2] == 'التعديل' then
return lock_edit(msg, data, target)
end
if matches[2] == 'الكلايش' then
return lock_spam(msg, data, target)
end
if matches[2] == 'التكرار' then
return lock_flood(msg, data, target)
end
if matches[2] == 'تبچی' then
return lock_tabchi(msg, data, target)
end
if matches[2] == 'البوتات' then
return lock_bots(msg, data, target)
end
if matches[2] == 'الماركدون' then
return lock_markdown(msg, data, target)
end
if matches[2] == 'الويب' then
return lock_webpage(msg, data, target)
end
if matches[2] == 'الكلام السيئ' then
return lock_badword(msg, data, target)
end
if matches[2] == 'التثبيت' and is_owner(msg) then
return lock_pin(msg, data, target)
end
if matches[2] == "الاضافه" then
return lock_join(msg, data, target)
end
if matches[2] == 'الاوامر' then
			redis:hset('group:'..msg.to.id..':cmd', 'bot', 'moderator')
			return 'دستورات برای کاربر عادی قفل شد'
			end
			end
end
if (matches[1]:lower() == "unlock" or matches[1] == 'فتح') and is_mod(msg) then
local target = msg.to.id
if not lang then
if matches[2] == "link" then
return unlock_link(msg, data, target)
end
if matches[2] == "tag" then
return unlock_tag(msg, data, target)
end
if matches[2] == 'username' then
return unlock_username(msg, data, target)
end
if matches[2] == "mention" then
return unlock_mention(msg, data, target)
end
if matches[2] == "arabic" then
return unlock_arabic(msg, data, target)
end
if matches[2] == 'english' then
return unlock_english(msg, data, target)
end
if matches[2] == "edit" then
return unlock_edit(msg, data, target)
end
if matches[2] == "spam" then
return unlock_spam(msg, data, target)
end
if matches[2] == "flood" then
return unlock_flood(msg, data, target)
end
if matches[2] == 'tabchi' then
return unlock_tabchi(msg, data, target)
end
if matches[2] == "bots" then
return unlock_bots(msg, data, target)
end
if matches[2] == "markdown" then
return unlock_markdown(msg, data, target)
end
if matches[2] == "webpage" then
return unlock_webpage(msg, data, target)
end
if matches[2] == 'badword' then
return unlock_badword(msg, data, target)
end
if matches[2] == "pin" and is_owner(msg) then
return unlock_pin(msg, data, target)
end
if matches[2] == "join" then
return unlock_join(msg, data, target)
end
if matches[2] == 'cmds' then
			redis:del('group:'..msg.to.id..':cmd')
			return 'cmds has been unlocked for member'
			end
	else
if matches[2] == 'الروابط' then
return unlock_link(msg, data, target)
end
if matches[2] == 'التاك' then
return unlock_tag(msg, data, target)
end
if matches[2] == 'المعرف' then
return unlock_username(msg, data, target)
end
if matches[2] == 'فراخوانی' then
return unlock_mention(msg, data, target)
end
if matches[2] == 'العربي' then
return unlock_arabic(msg, data, target)
end
if matches[2] == 'الانكليزي' then
return unlock_english(msg, data, target)
end
if matches[2] == 'التعديل' then
return unlock_edit(msg, data, target)
end
if matches[2] == 'الكلايش' then
return unlock_spam(msg, data, target)
end
if matches[2] == 'التكرار' then
return unlock_flood(msg, data, target)
end
if matches[2] == 'تبچی' then
return unlock_tabchi(msg, data, target)
end
if matches[2] == 'البوتات' then
return unlock_bots(msg, data, target)
end
if matches[2] == 'الماركدون' then
return unlock_markdown(msg, data, target)
end
if matches[2] == 'الويب' then
return unlock_webpage(msg, data, target)
end
if matches[2] == 'فحش' then
return unlock_badword(msg, data, target)
end
if matches[2] == 'التثبيت' and is_owner(msg) then
return unlock_pin(msg, data, target)
end
if matches[2] == "الاضافه" then
return unlock_join(msg, data, target)
end
if matches[2] == 'الاوامر' then
			redis:del('group:'..msg.to.id..':cmd')
			return 'دستورات برای کاربر عادی باز شد'
			end
	end
end
if (matches[1]:lower() == "mute" or matches[1] == 'قفل') and is_mod(msg) then
local target = msg.to.id
if not lang then
if matches[2] == "gif" then
return mute_gif(msg, data, target)
end
if matches[2] == "text" then
return mute_text(msg ,data, target)
end
if matches[2] == "photo" then
return mute_photo(msg ,data, target)
end
if matches[2] == "video" then
return mute_video(msg ,data, target)
end
if matches[2] == "audio" then
return mute_audio(msg ,data, target)
end
if matches[2] == "voice" then
return mute_voice(msg ,data, target)
end
if matches[2] == "sticker" then
return mute_sticker(msg ,data, target)
end
if matches[2] == "contact" then
return mute_contact(msg ,data, target)
end
if matches[2] == "forward" then
return mute_forward(msg ,data, target)
end
if matches[2] == "location" then
return mute_location(msg ,data, target)
end
if matches[2] == "document" then
return mute_document(msg ,data, target)
end
if matches[2] == "tgservice" then
return mute_tgservice(msg ,data, target)
end
if matches[2] == "inline" then
return mute_inline(msg ,data, target)
end
if matches[2] == "game" then
return mute_game(msg ,data, target)
end
if matches[2] == "keyboard" then
return mute_keyboard(msg ,data, target)
end
if matches[2] == 'all' then
local hash = 'muteall:'..msg.to.id
redis:set(hash, true)
return "*Mute All* *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
end
else
if matches[2] == 'الصور المتحركه' then
return mute_gif(msg, data, target)
end
if matches[2] == 'الكتابه' then
return mute_text(msg ,data, target)
end
if matches[2] == 'الصور' then
return mute_photo(msg ,data, target)
end
if matches[2] == 'الفيديو' then
return mute_video(msg ,data, target)
end
if matches[2] == 'البصمات' then
return mute_audio(msg ,data, target)
end
if matches[2] == 'الصوت' then
return mute_voice(msg ,data, target)
end
if matches[2] == 'الملصقات' then
return mute_sticker(msg ,data, target)
end
if matches[2] == 'الجهات' then
return mute_contact(msg ,data, target)
end
if matches[2] == 'اعاده التوجيه' then
return mute_forward(msg ,data, target)
end
if matches[2] == 'المواقع' then
return mute_location(msg ,data, target)
end
if matches[2] == 'الملفات' then
return mute_document(msg ,data, target)
end
if matches[2] == 'الاشعارات' then
return mute_tgservice(msg ,data, target)
end
if matches[2] == 'الانلاين' then
return mute_inline(msg ,data, target)
end
if matches[2] == 'الالعاب' then
return mute_game(msg ,data, target)
end
if matches[2] == 'الكيبورد' then
return mute_keyboard(msg ,data, target)
end
if matches[2]== 'الكل' then
local hash = 'muteall:'..msg.to.id
redis:set(hash, true)
return "*>* _تم تفعيل كتم 🔕 جميع الوسائط في هذا المجموعة  🚻 !_ "
end
end
end
if (matches[1]:lower() == "unmute" or matches[1] == 'فتح') and is_mod(msg) then
local target = msg.to.id
if not lang then
if matches[2] == "gif" then
return unmute_gif(msg, data, target)
end
if matches[2] == "text" then
return unmute_text(msg, data, target)
end
if matches[2] == "photo" then
return unmute_photo(msg ,data, target)
end
if matches[2] == "video" then
return unmute_video(msg ,data, target)
end
if matches[2] == "audio" then
return unmute_audio(msg ,data, target)
end
if matches[2] == "voice" then
return unmute_voice(msg ,data, target)
end
if matches[2] == "sticker" then
return unmute_sticker(msg ,data, target)
end
if matches[2] == "contact" then
return unmute_contact(msg ,data, target)
end
if matches[2] == "forward" then
return unmute_forward(msg ,data, target)
end
if matches[2] == "location" then
return unmute_location(msg ,data, target)
end
if matches[2] == "document" then
return unmute_document(msg ,data, target)
end
if matches[2] == "tgservice" then
return unmute_tgservice(msg ,data, target)
end
if matches[2] == "inline" then
return unmute_inline(msg ,data, target)
end
if matches[2] == "game" then
return unmute_game(msg ,data, target)
end
if matches[2] == "keyboard" then
return unmute_keyboard(msg ,data, target)
end
 if matches[2] == 'all' then
         local hash = 'muteall:'..msg.to.id
        redis:del(hash)
          return "*Mute All* *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
end
else
if matches[2] == 'الصور المتحركه' then
return unmute_gif(msg, data, target)
end
if matches[2] == 'الكتابه' then
return unmute_text(msg, data, target)
end
if matches[2] == 'الصور' then
return unmute_photo(msg ,data, target)
end
if matches[2] == 'الفيديو' then
return unmute_video(msg ,data, target)
end
if matches[2] == 'البصمات' then
return unmute_audio(msg ,data, target)
end
if matches[2] == 'الصوت' then
return unmute_voice(msg ,data, target)
end
if matches[2] == 'الملصقات' then
return unmute_sticker(msg ,data, target)
end
if matches[2] == 'الجهات' then
return unmute_contact(msg ,data, target)
end
if matches[2] == 'اعاده التوجيه' then
return unmute_forward(msg ,data, target)
end
if matches[2] == 'المواقع' then
return unmute_location(msg ,data, target)
end
if matches[2] == 'الملفات' then
return unmute_document(msg ,data, target)
end
if matches[2] == 'الاشعارات' then
return unmute_tgservice(msg ,data, target)
end
if matches[2] == 'الانلاين' then
return unmute_inline(msg ,data, target)
end
if matches[2] == 'الالعاب' then
return unmute_game(msg ,data, target)
end
if matches[2] == 'الكيبورد' then
return unmute_keyboard(msg ,data, target)
end
 if matches[2]=='الكل' and is_mod(msg) then
         local hash = 'muteall:'..msg.to.id
        redis:del(hash)
          return "گروه ازاد شد و افراد می توانند دوباره پست بگذارند"
		  
end
end
end
if (matches[1]:lower() == 'cmds' or matches[1] == 'العلامات') and is_owner(msg) then 
	if not lang then
		if matches[2]:lower() == 'owner' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'owner') 
		return 'cmds set for owner or higher' 
		end
		if matches[2]:lower() == 'moderator' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'moderator')
		return 'cmds set for moderator or higher'
		end 
		if matches[2]:lower() == 'member' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'member') 
		return 'cmds set for member or higher' 
		end 
	else
		if matches[2] == 'المدير' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'owner') 
		return 'دستورات برای مدیرکل به بالا دیگر جواب می دهد' 
		end
		if matches[2] == 'الادمن' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'moderator')
		return 'دستورات برای مدیر به بالا دیگر جواب می دهد' 
		end 
		if matches[2] == 'المشرف' then 
		redis:hset('group:'..msg.to.id..':cmd', 'bot', 'member') 
		return 'دستورات برای کاربر عادی به بالا دیگر جواب می دهد' 
		end 
		end
	end
if (matches[1]:lower() == "gpinfo" or matches[1] == 'معلومات المجموعه') and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)
if not lang then
ginfo = "*Group Info :*\n_Admin Count :_ *"..data.administrator_count_.."*\n_Member Count :_ *"..data.member_count_.."*\n_Kicked Count :_ *"..data.kicked_count_.."*\n_Group ID :_ *"..data.channel_.id_.."*"
elseif lang then
ginfo = "*معلومات المجموعة ℹ️ ! *\n*>* _عدد الادمنية :_ *"..data.administrator_count_.."*\n*>* _عدد الاعضاء :_ *"..data.member_count_.."*\n*>* _عدد الاعضاء المطرودين :_ *"..data.kicked_count_.."*\n*>* _ايدي المجموعة :_ *"..data.channel_.id_.."*"
end
        tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdcli.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if (matches[1]:lower() == 'newlink' or matches[1] == 'رابط جديد') and is_mod(msg) and not matches[2] then
	local function callback_link (arg, data)
    local administration = load_data(_config.moderation.data) 
				if not data.invite_link_ then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_Bot is not group creator_\n_set a link for group with using_ /setlink", 1, 'md')
       elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_البوت ليس منشئ المجموعة 🚻 قم بأراسل 📮  *> ضع رابط* لتعيين رابط جديد ✅ !_", 1, 'md')
    end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_
					save_data(_config.moderation.data, administration)
        if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*Newlink Created*", 1, 'md')
        elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_شكراً ياعزيزي تم حفظ 📥 الرابط بنجاح ✅_", 1, 'md')
            end
				end
			end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if (matches[1]:lower() == 'newlink' or matches[1] == 'رابط جديد') and is_mod(msg) and (matches[2] == 'pv' or matches[2] == 'خاص') then
	local function callback_link (arg, data)
		local result = data.invite_link_
		local administration = load_data(_config.moderation.data) 
				if not result then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_Bot is not group creator_\n_set a link for group with using_ /setlink", 1, 'md')
       elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_يمكنك وضع 📤 رابط الى مجموعتك 🚻 من خلال ارسال_ */setlink* - او *ضع رابط !*", 1, 'md')
    end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = result
					save_data(_config.moderation.data, administration)
        if not lang then
		tdcli.sendMessage(user, msg.id, 1, "*Newlink Group* _:_ `"..msg.to.id.."`\n"..result, 1, 'md')
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*New link Was Send In Your Private Message*", 1, 'md')
        elseif lang then
		tdcli.sendMessage(user, msg.id, 1, "*رابط المجموعة * _:-_ `"..msg.to.id.."`\n"..result, 1, 'md')
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*>* _تم ارسال 📩 الرابط اليك في الخاص 📮 !_, 1, 'md')
            end
				end
			end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if (matches[1]:lower() == 'setlink' or matches[1] == 'ضع رابط') and is_owner(msg) then
		if not matches[2] then
		data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)
			if not lang then
			return '_Please send the new group_ *link* _now_'
    else 
         return '*>* _الان عزيزي 😃  من فضلك ارسال 📥 الرابط 🖇  ليتم وضعة في المجموعة !_'
       end
	   end
		 data[tostring(chat)]['settings']['linkgp'] = matches[2]
			 save_data(_config.moderation.data, data)
      if not lang then
			return '_Group Link Was Saved Successfully._'
    else 
         return '_تم حفظ 🆙 رابط المجموعة بنجاح ! ✅_'
       end
		end
		if msg.text then
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.text
				save_data(_config.moderation.data, data)
            if not lang then
				return "*Newlink* _has been set_"
           else
           return "*>* _الان عزيزي 😃  من فضلك ارسال 📥 الرابط الجديد !_"
		 	end
       end
		end
    if (matches[1]:lower() == 'link' or matches[1] == 'الرابط') and is_mod(msg) and not matches[2] then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "*عذراً ℹ️  لم يتم تعين رابط الى المجموعة 🚻\nيمكنك تعين الرابط من خلال ارسال 📥* _ضع رابط_  او _انشاء رابط_"
      end
      end
     if not lang then
       text = "<b>Group Link :</b>\n"..linkgp
     else
      text = "<b>رابط المجموعة :-</b>\n"..linkgp
         end
        return tdcli.sendMessage(chat, msg.id, 1, text, 1, 'html')
     end
    if (matches[1]:lower() == 'link' or matches[1] == 'الرابط') and (matches[2] == 'pv' or matches[2] == 'خاص') then
	if is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "*عذراً ℹ️  لم يتم تعين رابط الى المجموعة 🚻\nيمكنك تعين الرابط من خلال ارسال 📥* _ضع رابط_  او _انشاء رابط_"
      end
      end
     if not lang then
	 tdcli.sendMessage(chat, msg.id, 1, "<b>link Was Send In Your Private Message !</b>", 1, 'html')
     tdcli.sendMessage(user, "", 1, "<b>Group Link "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
     else
	 tdcli.sendMessage(chat, msg.id, 1, "<b>تم ارسال رابط 📎  المجموعة في الخاص 📥 !</b>", 1, 'html')
      tdcli.sendMessage(user, "", 1, "<b>رابط المجموعة :- "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
         end
     end
	 end
  if (matches[1]:lower() == "setrules" or matches[1] == 'ضع قوانین') and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)
     if not lang then
    return "*Group rules* _has been set_"
   else 
  return "*>* _من فضلك عزيزي 😃 ارسل القوانين 📬 ليتم ضعها في المجموعة !_"
   end
  end
  if matches[1]:lower() == "rules" or matches[1] == 'القوانين' then
 if not data[tostring(chat)]['rules'] then
   if not lang then
     rules = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban.\n@ProtectionTeam"
    elseif lang then
       rules = "ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.\n@ProtectionTeam"
 end
        else
     rules = "*Group Rules :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end
if (matches[1]:lower() == "res" or matches[1] == 'فحص') and matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="res"})
  end
if (matches[1]:lower() == "whois" or matches[1] == 'شناسه') and matches[2] and string.match(matches[2], '^%d+$') and is_mod(msg) then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="whois"})
  end
		if matches[1]:lower() == 'setchar' or matches[1]:lower() == 'حداکثر حروف مجاز' then
			if not is_mod(msg) then
				return
			end
			local chars_max = matches[2]
			data[tostring(msg.to.id)]['settings']['set_char'] = chars_max
			save_data(_config.moderation.data, data)
    if not lang then
     return "*Character sensitivity* _has been set to :_ *[ "..matches[2].." ]*"
   else
     return "_حداکثر حروف مجاز در پیام تنظیم شد به :_ *[ "..matches[2].." ]*"
		end
  end
  if (matches[1]:lower() == 'setflood' or matches[1] == 'ضع تكرار') and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
				return "*>* _Wrong number, range is_ *[2-50]*"
      end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "*>* _Group_ *flood* _sensitivity has been set to :_ *[ "..matches[2].." ]*"
    else
    return '_محدودیت پیام مکرر به_ *'..tonumber(matches[2])..'* _تنظیم شد._'
    end
       end
  if (matches[1]:lower() == 'setfloodtime' or matches[1] == 'ضع مدة التكرار') and is_mod(msg) then
			if tonumber(matches[2]) < 2 or tonumber(matches[2]) > 10 then
				return "_Wrong number, range is_ *[2-10]*"
      end
			local time_max = matches[2]
			data[tostring(chat)]['settings']['time_check'] = time_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "_Group_ *flood* _check time has been set to :_ *[ "..matches[2].." ]*"
    else
    return "*>* _تم تعيين  الحد الأقصى لفحص الوقت ⏰ للرسائل المتكررة_ *:-* *[ "..matches[2].." ]*"
    end
       end
		if (matches[1]:lower() == 'clean' or matches[1] == 'تنظيف') and is_owner(msg) then
		if not lang then
			if matches[2] == 'mods' then
				if next(data[tostring(chat)]['mods']) == nil then
					return "_No_ *moderators* _in this group_"
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "_All_ *moderators* _has been demoted_"
         end
			if matches[2] == 'filterlist' then
				if next(data[tostring(chat)]['filterlist']) == nil then
					return "*Filtered words list* _is empty_"
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "*Filtered words list* _has been cleaned_"
			end
			if matches[2] == 'rules' then
				if not data[tostring(chat)]['rules'] then
					return "_No_ *rules* _available_"
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
				return "*Group rules* _has been cleaned_"
       end
			if matches[2] == 'welcome' then
				if not data[tostring(chat)]['setwelcome'] then
					return "*Welcome Message not set*"
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
				return "*Welcome message* _has been cleaned_"
       end
			if matches[2] == 'about' then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then
					return "_No_ *description* _available_"
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end
				return "*Group description* _has been cleaned_"
		   	end
			else
			if matches[2] == 'مدیران' then
				if next(data[tostring(chat)]['mods']) == nil then
                return "هیچ مدیری برای گروه انتخاب نشده است"
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            return "تمام مدیران گروه تنزیل مقام شدند"
         end
			if matches[2] == 'قائمه المنع' then
				if next(data[tostring(chat)]['filterlist']) == nil then
					return "*>* _عذراً  قائمة المنع 📵 فارغة 📭 ياعزيزي !_"
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "*>* _تم تنظيف 🚮 قائمة المنع 📵 بنجاح ✅ !_"
			end
			if matches[2] == 'القوانين' then
				if not data[tostring(chat)]['rules'] then
               return "*>* _لم يتم وضع قوانين 📑 في هذا المجموعة 🚻 !_"
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
            return "*>* _تم تنظيف 🚮 قوانين 📑 المجموعة  بنجاح ✅ !_"
       end
			if matches[2] == 'الترحيب' then
				if not data[tostring(chat)]['setwelcome'] then
               return "پیام خوشآمد گویی ثبت نشده است"
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
            return "پیام خوشآمد گویی پاک شد"
       end
			if matches[2] == 'الوصف' then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then
              return "پیامی مبنی بر درباره گروه ثبت نشده است"
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end
              return "پیام مبنی بر درباره گروه پاک شد"
		   	end
			
			end
        end
		if (matches[1]:lower() == 'clean' or matches[1] == 'تنظيف') and is_admin(msg) then
		if not lang then
			if matches[2] == 'owners' then
				if next(data[tostring(chat)]['owners']) == nil then
					return "_No_ *owners* _in this group_"
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "_All_ *owners* _has been demoted_"
			end
			else
			if matches[2] == 'المدراء' then
				if next(data[tostring(chat)]['owners']) == nil then
                return "مالکی برای گروه انتخاب نشده است"
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            return "تمامی مالکان گروه تنزیل مقام شدند"
			end
			end
     end
if (matches[1]:lower() == "setname" or matches[1] == 'ضع اسم') and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if (matches[1]:lower() == "setabout" or matches[1] == 'ضع وصف') and matches[2] and is_mod(msg) then
     if msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil)
    elseif msg.to.type == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end
     if not lang then
    return "*Group description* _has been set_"
    else
     return "*>* _تم تعيين 📥 وصف لهذا المجموعة 🚻 !_"
      end
  end
  if matches[1]:lower() == "about" or matches[1] == 'الوصف' and msg.to.type == "chat" then
 if not data[tostring(chat)]['about'] then
     if not lang then
     about = "*>* _No_ *description* _available_"
      elseif lang then
      about = "*>* _لم يتم وضع وصف 📥 في هذا المجموعة 🚻 !_"
       end
        else
     about = "*Group Description :*\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if (matches[1]:lower() == 'filter' or matches[1] == 'منع') and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if (matches[1]:lower() == 'unfilter' or matches[1] == 'الغاء المنع') and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if (matches[1]:lower() == 'config' or matches[1] == 'الحمايه') and is_admin(msg) then
tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, config_cb, {chat_id=msg.to.id})
  end
  if (matches[1]:lower() == 'filterlist' or matches[1] == 'قائمه المنع') and is_mod(msg) then
    return filter_list(msg)
  end
if (matches[1]:lower() == "modlist" or matches[1] == 'قائمه الادمنيه') and is_mod(msg) then
return modlist(msg)
end
if (matches[1]:lower() == "whitelist" or matches[1] == 'القائمه البيضاء') and not matches[2] and is_mod(msg) then
return whitelist(msg.to.id)
end
if (matches[1]:lower() == "ownerlist" or matches[1] == 'قائمه المدراء') and is_owner(msg) then
return ownerlist(msg)
end
if (matches[1]:lower() == "settings" or matches[1] == 'الاعدادات') and is_mod(msg) then
return group_settings(msg, target)
end
if matches[1]:lower() == "setlang" and is_owner(msg) then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if matches[2] == "Ar" then
redis:set(hash, true)
return "*>* تم تغيير 🔄 لغة البوت ال* :- _العربية_ "
end
end
if matches[1] == 'تحويل لغه En' then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 redis:del(hash)
return "*>* _Group Language Set To:_ *EN*"
end
 if (matches[1] == 'mutetime' or matches[1] == 'كتم لمدة') and is_mod(msg) then
local hash = 'muteall:'..msg.to.id
local hour = tonumber(matches[2])
local num1 = (tonumber(hour) * 3600)
local minutes = tonumber(matches[3])
local num2 = (tonumber(minutes) * 60)
local second = tonumber(matches[4])
local num3 = tonumber(second) 
local num4 = tonumber(num1 + num2 + num3)
redis:setex(hash, num4, true)
if not lang then
 return "_Mute all has been enabled for_ \n> *hours :* `"..matches[2].."`\n> *minutes :* `"..matches[3].."`\n> *seconds :* `"..matches[4].."`"
 elseif lang then
 return "*>* _تم تفعيل كتم 🔕 جميع الوسائط \n⏺ ساعة : "..matches[2].."\n⏺ دقیقه : "..matches[3].."\n⏺ ثانیه : "..matches[4]
 end
 end
 if (matches[1] == 'mutehours' or matches[1]== 'كتم لمدة ساعه') and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
local hour = matches[2]
local num1 = tonumber(hour) * 3600
local num4 = tonumber(num1)
redis:setex(hash, num4, true)
if not lang then
 return "Mute all has been enabled for \n⏺ hours : "..matches[2]
 elseif lang then
 return "*>* _تم تفعيل كتم 🔕 جميع الوسائط لمدة ⏰\nمن الساعات *:-* "..matches[2]
 end
 end
  if (matches[1] == 'muteminutes' or matches[1]== 'كتم لمدة دقيقه')  and is_mod(msg) then
 local hash = 'muteall:'..msg.to.id
local minutes = matches[2]
local num2 = tonumber(minutes) * 60
local num4 = tonumber(num2)
redis:setex(hash, num4, true)
if not lang then
 return "Mute all has been enabled for \n⏺ minutes : "..matches[2]
 elseif lang then
 return "*>* _تم تفعيل كتم 🔕 جميع الوسائط لمدة ⏰\nمن الدقائق *:-* "..matches[2]
 end
 end
  if (matches[1] == 'settingseconds' or matches[1] == 'كتم لمدة ثانيه') and is_mod(msg) then
       local hash = 'muteall:'..msg.to.id
local second = matches[2]
local num3 = tonumber(second) 
local num4 = tonumber(num3)
redis:setex(hash, num3, true)
if not lang then
 return "*>* *Mute all* has been enabled for \n⏺ seconds : "..matches[2]
 elseif lang then
 return "*>* _تم تفعيل كتم 🔕 جميع الوسائط لمدة ⏰\nمن الثواني *:-*"..matches[2]
 end
 end
 if (matches[1] == 'muteall' or matches[1] == 'موقعیت') and (matches[2] == 'status' or matches[2] == 'بیصدا') and is_mod(msg) then
         local hash = 'muteall:'..msg.to.id
      local mute_time = redis:ttl(hash)
		
		if tonumber(mute_time) < 0 then
		if not lang then
		return '_Mute All is Disable._'
		else
		return '*>* _تم تعطيل 📴 كتم جميع الوسائط 🔕 !_'
		end
		else
		if not lang then
          return mute_time.." Sec"
		  elseif lang then
		  return mute_time.."ثانیه"
		end
		end
  end
-------------Edit--------------
if matches[1] == 'edit' or matches[1] == 'تعديل' and msg.reply_to_message_id_ ~= 0 and is_sudo(msg) then
local text = matches[2]
tdcli.editMessageText(msg.to.id, msg.reply_to_message_id_, nil, text, 1, 'md')
end

if matches[1] == 'edit' or matches[1] == 'تعديل' and msg.reply_to_message_id_ ~= 0 and is_sudo(msg) then
local tExt = matches[2]
tdcli.editMessageCaption(msg.to.id, msg.reply_to_message_id_, nil, tExt)
end
--------------Plugin----------------
  local function plugin_enabled( name )
  for k,v in pairs(_config.enabled_plugins) do
    if name == v then
      return k
    end
  end
  -- If not found
  return false
end

-- Returns true if file exists in plugins folder
local function plugin_exists( name )
  for k,v in pairs(plugins_names()) do
    if name..'.lua' == v then
      return true
    end
  end
  return false
end

local function list_all_plugins(only_enabled, msg)
  local tmp = '\nt.me/Star_Wars'
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    --  ✔ enabled, ❌ disabled
    local status = '➖-»'
    nsum = nsum+1
    nact = 0
    -- Check if is enabled
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '➕-»'
      end
      nact = nact+1
    end
    if not only_enabled or status == '➕-»'then
      -- get the name
      v = string.match (v, "(.*)%.lua")
      text = text..nsum..'.'..status..' '..v..' \n'
    end
  end
  text = '<code>'..text..'</code>\n\n'..nsum..' <b>📂plugins installed</b>\n\n'..nact..' <i>➕️plugins enabled</i>\n\n'..nsum-nact..' <i>➖plugins disabled</i>'..tmp
  tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
end

local function list_plugins(only_enabled, msg)
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    --  ✔ enabled, ❌ disabled
    local status = '*➖-»*'
    nsum = nsum+1
    nact = 0
    -- Check if is enabled
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '*|➕|-»*'
      end
      nact = nact+1
    end
    if not only_enabled or status == '*➕-»*'then
      -- get the name
      v = string.match (v, "(.*)%.lua")
     -- text = text..v..'  '..status..'\n'
    end
  end
  text = "*BotReloaded :|*"
  tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'md')
end

local function reload_plugins(checks, msg)
  plugins = {}
  load_plugins()
  return list_plugins(true, msg)
end


local function enable_plugin( plugin_name, msg )
  print('checking if '..plugin_name..' exists')
  -- Check if plugin is enabled
  if plugin_enabled(plugin_name) then
    local text = '<b>'..plugin_name..'</b> <i>is enabled.</i>'
	tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
	return
  end
  -- Checks if plugin exists
  if plugin_exists(plugin_name) then
    -- Add to the config table
    table.insert(_config.enabled_plugins, plugin_name)
    print(plugin_name..' added to _config table')
    save_config()
    -- Reload the plugins
    return reload_plugins(true, msg)
  else
    local text = '<b>'..plugin_name..'</b> <i>does not exists.</i>'
	tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
  end
end

local function disable_plugin( name, msg )
  local k = plugin_enabled(name)
  -- Check if plugin is enabled
  if not k then
    local text = '<b>'..name..'</b> <i>not enabled.</i>'
	tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
	return
  end
  -- Check if plugins exists
  if not plugin_exists(name) then
    local text = '<b>'..name..'</b> <i>does not exists.</i>'
	tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
  else
  -- Disable and reload
  table.remove(_config.enabled_plugins, k)
  save_config( )
  return reload_plugins(true, msg)
end  
end

local function disable_plugin_on_chat(receiver, plugin, msg)
  if not plugin_exists(plugin) then
    return "_Plugin doesn't exists_"
  end

  if not _config.disabled_plugin_on_chat then
    _config.disabled_plugin_on_chat = {}
  end

  if not _config.disabled_plugin_on_chat[receiver] then
    _config.disabled_plugin_on_chat[receiver] = {}
  end

  _config.disabled_plugin_on_chat[receiver][plugin] = true

  save_config()
  local text = '<b>'..plugin..'</b> <i>disabled on this chat.</i>'
  tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
end

local function reenable_plugin_on_chat(receiver, plugin, msg)
  if not _config.disabled_plugin_on_chat then
    return 'There aren\'t any disabled plugins'
  end

  if not _config.disabled_plugin_on_chat[receiver] then
    return 'There aren\'t any disabled plugins for this chat'
  end

  if not _config.disabled_plugin_on_chat[receiver][plugin] then
    return '_This plugin is not disabled_'
  end

  _config.disabled_plugin_on_chat[receiver][plugin] = false
  save_config()
  local text = '<b>'..plugin..'</b> <i>is enabled again.</i>'
  tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
end

  -- Show the available plugins 
  if is_sudo(msg) then
  if (matches[1]:lower() == 'plugin' or matches[1] == 'الملفات') then --after changed to moderator mode, set only sudo
    return list_all_plugins(false, msg)
  end
  -- Re-enable a plugin for this chat
   if matches[1]:lower() == 'pl' or matches[1] == 'ملف' then
  if matches[2] == '+' and matches[4] == 'chat' or matches[4] == 'گروه' then
      if is_mod(msg) then
    local receiver = msg.chat_id_
    local plugin = matches[3]
    print("enable "..plugin..' on this chat')
    return reenable_plugin_on_chat(receiver, plugin, msg)
  end
    end

  -- Enable a plugin
  if matches[2] == '+' and is_sudo(msg) then --after changed to moderator mode, set only sudo
    local plugin_name = matches[3]
    print("enable: "..matches[3])
    return enable_plugin(plugin_name, msg)
  end
  -- Disable a plugin on a chat
  if matches[2] == '-' and matches[4] == 'chat' or matches[4] == 'گروه' then
      if is_mod(msg) then
    local plugin = matches[3]
    local receiver = msg.chat_id_
    print("disable "..plugin..' on this chat')
    return disable_plugin_on_chat(receiver, plugin, msg)
  end
    end
  -- Disable a plugin
  if matches[2] == '-' and is_sudo(msg) then --after changed to moderator mode, set only sudo
    if matches[3] == 'plugins' then
		return 'This plugin can\'t be disabled'
    end
    print("disable: "..matches[3])
    return disable_plugin(matches[3], msg)
  end

  -- Reload all the plugins!
  if matches[2] == '*' and is_sudo(msg) then --after changed to moderator mode, set only sudo
    return reload_plugins(true, msg)
  end
  end
  if (matches[1]:lower() == 'reload' or matches[1] == 'اعادة التحميل') and is_sudo(msg) then --after changed to moderator mode, set only sudo
    return reload_plugins(true, msg)
  end
end
--------------------Me---------------------
local function setrank(msg, user_id, value,chat_id)
  local hash = nil

    hash = 'rank:'..msg.to.id..':variables'

  if hash then
    redis:hset(hash, user_id, value)
  return tdcli.sendMessage(chat_id, '', 0, '_set_ *Rank* _for_ *[ '..user_id..' ]* _To :_ *'..value..'*', 0, "md")
  end
end
local function info_by_reply(arg, data)
    if tonumber(data.sender_user_id_) then
local function info_cb(arg, data)
    if data.username_ then
  username = "@"..check_markdown(data.username_)
    else
  username = ""
  end
    if data.first_name_ then
  firstname = check_markdown(data.first_name_)
    else
  firstname = ""
  end
    if data.last_name_ then
  lastname = check_markdown(data.last_name_)
    else
  lastname = ""
  end
	local hash = 'rank:'..arg.chat_id..':variables'
   local text = "*>* _First name :_ *"..firstname.."*\n*>* _Last name :_ *"..lastname.."*\n*>* _Username :_ "..username.."\n*>* _ID :_ *"..data.id_.."*\n"
		    if data.id_ == tonumber(MRlucas) then
		       text = text..'*>* _Rank :_ *Executive Admin*\n'
			   elseif is_sudo1(data.id_) then
	           text = text..'*>* _Rank :_ *Full Access Admin*\n'
		     elseif is_admin1(data.id_) then
		       text = text..'*>* _Rank :_ *Bot Admin*\n'
		     elseif is_owner1(arg.chat_id, data.id_) then
		       text = text..'*>* _Rank :_ *Group Owner*\n'
		     elseif is_mod1(arg.chat_id, data.id_) then
		       text = text..'*>* _Rank :_ *Group Moderator*\n'
		 else
		       text = text..'*>* _Rank :_ *Group Member*\n'
			end
         local user_info = {} 
  local uhash = 'user:'..data.id_
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..data.id_..':'..arg.chat_id
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'Total messages : '..user_info_msgs..'\n'
  text = text..BDRpm
  tdcli.sendMessage(arg.chat_id, arg.msgid, 0, text, 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, info_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_,msgid=data.id_})
    else
tdcli.sendMessage(data.chat_id_, "", 0, "*User not found*", 0, "md")
   end
end

local function info_by_username(arg, data)
    if tonumber(data.id_) then
    if data.type_.user_.username_ then
  username = "@"..check_markdown(data.type_.user_.username_)
    else
  username = ""
  end
    if data.type_.user_.first_name_ then
  firstname = check_markdown(data.type_.user_.first_name_)
    else
  firstname = ""
  end
    if data.type_.user_.last_name_ then
  lastname = check_markdown(data.type_.user_.last_name_)
    else
  lastname = ""
  end
	local hash = 'rank:'..arg.chat_id..':variables'
   local text = "_First name :_ *"..firstname.."*\n_Last name :_ *"..lastname.."*\n_Username :_ "..username.."\n_ID :_ *"..data.id_.."*\n"
		    if data.id_ == tonumber(MRlucas) then
		       text = text..'_Rank :_ *Executive Admin*\n'
			   elseif is_sudo1(data.id_) then
	           text = text..'_Rank :_ *Full Access Admin*\n'
		     elseif is_admin1(data.id_) then
		       text = text..'_Rank :_ *Bot Admin*\n'
		     elseif is_owner1(arg.chat_id, data.id_) then
		       text = text..'_Rank :_ *Group Owner*\n'
		     elseif is_mod1(arg.chat_id, data.id_) then
		       text = text..'_Rank :_ *Group Moderator*\n'
		 else
		       text = text..'_Rank :_ *Group Member*\n'
			end
         local user_info = {} 
  local uhash = 'user:'..data.id_
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..data.id_..':'..arg.chat_id
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'Total messages : '..user_info_msgs..'\n'
  text = text..BDRpm
  tdcli.sendMessage(arg.chat_id, arg.msgid, 0, text, 0, "md")
   else
   tdcli.sendMessage(arg.chat_id, "", 0, "*User not found*", 0, "md")
  end
end

local function info_by_id(arg, data)
      if tonumber(data.id_) then
    if data.username_ then
  username = "@"..check_markdown(data.username_)
    else
  username = ""
  end
    if data.first_name_ then
  firstname = check_markdown(data.first_name_)
    else
  firstname = ""
  end
    if data.last_name_ then
  lastname = check_markdown(data.last_name_)
    else
  lastname = ""
  end
	local hash = 'rank:'..arg.chat_id..':variables'
   local text = "_First name :_ *"..firstname.."*\n_Last name :_ *"..lastname.."*\n_Username :_ "..username.."\n_ID :_ *"..data.id_.."*\n"
		    if data.id_ == tonumber(MRlucas) then
		       text = text..'_Rank :_ *Executive Admin*\n'
			   elseif is_sudo1(data.id_) then
	           text = text..'_Rank :_ *Full Access Admin*\n'
		     elseif is_admin1(data.id_) then
		       text = text..'_Rank :_ *Bot Admin*\n'
		     elseif is_owner1(arg.chat_id, data.id_) then
		       text = text..'_Rank :_ *Group Owner*\n'
		     elseif is_mod1(arg.chat_id, data.id_) then
		       text = text..'_Rank :_ *Group Moderator*\n'
		 else
		       text = text..'_Rank :_ *Group Member*\n'
			end
         local user_info = {} 
  local uhash = 'user:'..data.id_
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..data.id_..':'..arg.chat_id
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'Total messages : '..user_info_msgs..'\n'
  text = text..BDRpm
  tdcli.sendMessage(arg.chat_id, arg.msgid, 0, text, 0, "md")
   else
   tdcli.sendMessage(arg.chat_id, "", 0, "*User not found*", 0, "md")
   end
end

local function setrank_by_reply(arg, data)

end

if matches[1]:lower() == "me" or matches[1] == "موقعي" then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, info_by_reply, {chat_id=msg.chat_id_})
  end
  if matches[2] and string.match(matches[2], '^%d+$') and tonumber(msg.reply_to_message_id_) == 0 then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, info_by_id, {chat_id=msg.chat_id_,user_id=matches[2],msgid=msg.id_})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') and tonumber(msg.reply_to_message_id_) == 0 then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, info_by_username, {chat_id=msg.chat_id_,username=matches[2],msgid=msg.id_})
      end
  if not matches[2] and tonumber(msg.reply_to_message_id_) == 0 then
local function info2_cb(arg, data)
      if tonumber(data.id_) then
    if data.username_ then
  username = "@"..check_markdown(data.username_)
    else
  username = ""
  end
    if data.first_name_ then
  firstname = check_markdown(data.first_name_)
    else
  firstname = ""
  end
    if data.last_name_ then
  lastname = check_markdown(data.last_name_)
    else
  lastname = ""
  end
	local hash = 'rank:'..arg.chat_id..':variables'
   local text = "_First name :_ *"..firstname.."*\n_Last name :_ *"..lastname.."*\n_Username :_ "..username.."\n_ID :_ *"..data.id_.."*\n"
		    if data.id_ == tonumber(MRlucas) then
		       text = text..'_Rank :_ *Executive Admin*\n'
			   elseif is_sudo1(data.id_) then
	           text = text..'_Rank :_ *Full Access Admin*\n'
		     elseif is_admin1(data.id_) then
		       text = text..'_Rank :_ *Bot Admin*\n'
		     elseif is_owner1(arg.chat_id, data.id_) then
		       text = text..'_Rank :_ *Group Owner*\n'
		     elseif is_mod1(arg.chat_id, data.id_) then
		       text = text..'_Rank :_ *Group Moderator*\n'
		 else
		       text = text..'_Rank :_ *Group Member*\n'
		 end
         local user_info = {} 
  local uhash = 'user:'..data.id_
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..data.id_..':'..arg.chat_id
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'Total messages : '..user_info_msgs..'\n'
  text = text..BDRpm
  tdcli.sendMessage(arg.chat_id, arg.msgid, 0, text, 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = msg.from.id,
  }, info_by_id, {chat_id=msg.chat_id_,user_id=msg.from.id,msgid=msg.id_})
      end
   end
-------------Echo--------------
if matches[1] == 'echo' or  matches[1] == 'كرر' then
local pext = matches[2]
tdcli.sendMessage(msg.to.id, 0,1, pext,1,'html')
end
  -----------cleanbot----------
   if matches[1] == 'cleanbot' or matches[1] == 'تنظيف البوتات' then
  function clbot(arg, data)
    for k, v in pairs(data.members_) do
      kick_user(v.user_id_, msg.to.id)
	end
    tdcli.sendMessage(msg.to.id, msg.id, 1, '_All Bots was cleared._', 1, 'md')
  end
  tdcli.getChannelMembers(msg.to.id, 0, 'Bots', 200, clbot, nil)
  end
--------------Delete Message----------------
local function delmsg (i,naji)
    msgs = i.msgs 
    for k,v in pairs(naji.messages_) do
        msgs = msgs - 1
        tdcli.deleteMessages(v.chat_id_,{[0] = v.id_}, dl_cb, cmd)
        if msgs == 1 then
            tdcli.deleteMessages(naji.messages_[0].chat_id_,{[0] = naji.messages_[0].id_}, dl_cb, cmd)
            return false
        end
    end
    tdcli.getChatHistory(naji.messages_[0].chat_id_, naji.messages_[0].id_,0 , 100, delmsg, {msgs=msgs})
end
    if matches[1] == 'del' or matches[1] == 'مسح' and is_owner(msg) then
        if tostring(msg.to.id):match("^-100") then
            if tonumber(matches[2]) > 1000 or tonumber(matches[2]) < 1 then
                return  '🚫 *1000*> _تعداد پیام های قابل پاک سازی در هر دفعه_ >*1* 🚫'
            else
        tdcli.getChatHistory(msg.to.id, msg.id,0 , 100, delmsg, {msgs=matches[2]})
        return ""..matches[2].." _پیام اخیر با موفقیت پاکسازی شدند_ 🚮"
            end
        else
            return '⚠️ _این قابلیت فقط در سوپرگروه ممکن است_ ⚠️'
        end
	end	
--------------------------------
if matches[1]:lower() == 'clean' or matches[1] == 'تنظيف' and matches[2]:lower() == 'blacklist' or matches[2] == 'قائمه البلوك' then
    if not is_mod(msg) then
      return -- «Mods allowed»
    end
	
    local function cleanbl(ext, res)
      if tonumber(res.total_count_) == 0 then -- «Blocklist is empty or maybe Bot is not group's admin»
        return tdcli.sendMessage(ext.chat_id, ext.msg_id, 0, ' _قائمة البلوك 🚫 فارغة 📭 ياعزيزي _ !', 1, 'md')
      end
      local x = 0
      for x,y in pairs(res.members_) do
        x = x + 1
        tdcli.changeChatMemberStatus(ext.chat_id, y.user_id_, 'Left', dl_cb, nil) -- «Changing user status to left, removes user from blocklist»
      end
      return tdcli.sendMessage(ext.chat_id, ext.msg_id, 0, ' _ تم تنظيف 🚮 قائمة البلوك 🚫 بنجاح ✅ !_', 1, 'md')
    end
	
    return tdcli.getChannelMembers(msg.to.id, 0, 'Kicked', 200, cleanbl, {chat_id = msg.to.id, msg_id = msg.id}) -- «Gets channel blocklist»
  end
--------------------------------
if matches[1] == 'addkick' or matches[1] == 'افزودن ریمو' and is_owner(msg) then
        if gp_type(msg.to.id) == "channel" then
            tdcli.getChannelMembers(msg.to.id, 0, "Kicked", 200, function (i, naji)
                for k,v in pairs(naji.members_) do
                    tdcli.addChatMember(i.chat_id, v.user_id_, 50, dl_cb, nil)
                end
            end, {chat_id=msg.to.id})
            return "*>Banned User has been added Again Sussecfully✅*"
        end
        return "*Just in the super group may be :(*"
    end
--------------------------------
if matches[1] == 'ping'or matches[1] == 'اونلاين' then
tdcli.sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './data/ping.webp', '', dl_cb,msg.reply_id, nil)
end
--------------------------------
if matches [1] == 'setnerkh' or matches[1] == 'تنظیم نرخ' then 
if not is_admin(msg) then 
return '_You are Not_ *Moderator*' 
end 
local nerkh = matches[2] 
redis:set('bot:nerkh',nerkh) 
return 'نرخ باموفقیت ثبت گردید😐❤️' 
end 
if matches[1] == 'nerkh' or matches[1] == 'نرخ' then 
if not is_mod(msg) then 
return 
end 
    local hash = ('bot:nerkh') 
    local nerkh = redis:get(hash) 
    if not nerkh then 
    return 'نرخ ثبت نشده📛' 
    else 
     tdcli.sendMessage(msg.chat_id_, 0, 1, nerkh, 1, 'html') 
    end 
    end 
if matches[1]== "delnerkh" or matches[1] == 'پاک کردن نرخ' then 
if not is_admin(msg) then 
return '_You are Not_ *Moderator*' 
end 
    local hash = ('bot:nerkh') 
    redis:del(hash) 
return 'نرخ پاک شد🗑' 
end
------------------Invite---------------------
function getMessage(chat_id, message_id,cb)
  tdcli_function ({
    ID = "GetMessage",
    chat_id_ = chat_id,
    message_id_ = message_id
  }, cb, nil)
end
-------------------------------------------------------------------------------------------------------------------
function from_username(msg)
  function gfrom_user(extra,result,success)
    if result.username_ then
      F = result.username_
    else
      F = 'nil'
    end
    return F
  end
  local username = getUser(msg.sender_user_id_,gfrom_user)
  return username
end
 --Start Function
  if matches[1] == "invite" and matches[2] and is_owner(msg) then
if string.match(matches[2], '^%d+$') then
tdcli.addChatMember(msg.to.id, matches[2], 0)
end
------------------------Username------------------------------------------------------------------------------------
if matches[1] == "invite" and matches[2] and is_owner(msg) then
if string.match(matches[2], '^.*$') then
function invite_by_username(extra, result, success)
if result.id_ then
tdcli.addChatMember(msg.to.id, result.id_, 5)
end
end
resolve_username(matches[2],invite_by_username)
end
end
------------------------Reply---------------------------------------------------------------------------------------
if matches[1] == "invite" and msg.reply_to_message_id_ ~= 0 and is_owner(msg) then
function inv_reply(extra, result, success)
tdcli.addChatMember(msg.to.id, result.sender_user_id_, 5)
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,inv_reply)
end
end
-----------------------------------------
if matches[1]:lower() == "help" or matches[1] == 'الاوامر' and is_mod(msg) then
if not lang then
text = [[*>* *Welcome To List Help* _Bot Star Wars_
  
_>_ */helplock* *:–* _لعرض اوامر 
القفل والفتح في المجموعة_ 

_>_ */helpwars* *:–* _لعرض اوامر 
التحكم في المجموعة_ 

_>_ */helpstar* *:–* _لعرض اوامر اصافية في المجموعة_ 

_>_ */helpmute* *:–* _لعرض اوامر الكتم_ 

_>_ */helptest* *:–* _لعرص اوامر المطورين_ 

*Bot Channel :-* @Star_Wars]]

elseif lang then

lock = [[*>* *_اهلا بك عزيزي 😃 في قائمة 📄 اوامر بوت_ *Star Wars*

*>* _تعمل الاوامر بلاشارات *[!/#]* وبدون الاشارات !_

_>_ *م1* *:–* _لعرض اوامر القفل والفتح في المجموعة_

_>_ *م2* *:–* _لعرض اوامر التحكم في المجموعة_

_>_ *م3* *:–* _لعرض اوامر اصافية في المجموعة_
_>_ *م4* *:–* _لعرض اوامر الكتم_

_>_ *م4* *:–* _لعرص اوامر المطورين_

لغة البوت :- _العربية_

Bot Channel :-* @Star_Wars*]]
end
return lock
end
-----------------------------------------
if matches[1]:lower() == "helpmute" or matches[1] == 'م2' and is_mod(msg) then
if not lang then
mute = [[*Welcome To List Help* _Mute_ 📳

*>* _اوامر الكتم 🔕 في المجموعة !_

_>_ */mute - unmute* _gif_ *:–* _لقفل الصور المتحركة_

_>_ */mute - unmute* _photo_ *:–* _لقفل الصور_

_>_ */mute - unmute* _text_ *:–* _لقفل الكتابه_

_>_ */mute - unmute* _forward_ *:–* _لقفل اعادة التوجيه_

_>_ */mute - unmute* _sticker_ *:–* _لقفل - فتح الملصقات_

_>_ */mute - unmute* _audio_ *:–* _لقفل - فتح الصوتيات_

_>_ */mute - unmute* _video_ *:–* _لقفل الفيديوهات_

_>_ */mute - unmute* _contact_ :–* _لقفل - فتح جهاة اللتصال_

_>_ */mute - unmute* _all_ :–* _لقفل جميع الوسائط_

>_ */mute - unmute* _keyboard_ *:–* _لقفل الكيبورد الشفاف_

*>* _ويمكنك استخدام الكتم 🔕 في الوقت ⏰_
_>_ */mutetime* _hours_ - _minute_ - _seconds_]]

elseif lang then

mute = [[
*دستورات ربات نوارس :*

●||● بیصدا : برای بیصدا کردن
●||● باصدا: برای باصدا کردن

❖--------------------------------❖

〽️||●》همه 

〽️||●》تصاویر متحرک 

〽️||●》عکس 

〽️||●》اسناد 

〽️||●》برچسب

〽️||●》صفحه کلید

〽️||●》فیلم

〽️||●》متن

〽️||●》نقل قول

〽️||●》موقعیت

〽️||●》اهنگ

〽️||●》صدا

〽️||●》مخاطب

〽️||●》کیبورد شیشه ای

〽️||●》بازی

〽️||●》خدمات تلگرام

⚜️زمان بیصدا (ساعت) (دقیقه) (ثانیه)
بیصدا کردن گروه با ساعت و دقیقه و ثانیه 
🔹ساعت بیصدا (عدد)
🔺بیصدا کردن گروه در ساعت 
🔹دقیقه بیصدا (عدد)
🔺بیصدا کردن گروه در دقیقه 
🔹ثانیه بیصدا (عدد)
🔺بیصدا کردن گروه در ثانیه ⚜️

شما میتوانید از [!/#] در اول دستورات برای اجرای آنها بهره بگیرید
------------------------------------------------------------

DVE↝ @oollmlloo

CH↝ @Asayelelarab

_این راهنما فقط برای مدیران/مالکان گروه میباشد!
این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!_
*موفق باشید ;)*]]
end
return mute
end
-----------------------------------------
if matches[1]:lower() == "helpmanag" or matches[1] == 'م3' and is_mod(msg) then
if not lang then
Management = [[
*PCT Bot Management:*
*!setmanager* `[username|id|reply]` 
_Add User To Group Admins(CreatorBot)_

*!Remmanager* `[username|id|reply]` 
 _Remove User From Owner List(CreatorBot)_

*!setowner* `[username|id|reply]` 
_Set Group Owner(Multi Owner)_

*!remowner* `[username|id|reply]` 
 _Remove User From Owner List_

*!promote* `[username|id|reply]` 
_Promote User To Group Admin_

*!demote* `[username|id|reply]` 
_Demote User From Group Admins List_

*!setflood* `[2-50]`
_Set Flooding Number_

*!silent* `[username|id|reply]` 
_Silent User From Group_

*!unsilent* `[username|id|reply]` 
_Unsilent User From Group_

*!kick* `[username|id|reply]` 
_Kick User From Group_

*!ban* `[username|id|reply]` 
_Ban User From Group_

*!unban* `[username|id|reply]` 
_UnBan User From Group_

*!res* `[username]`
_Show User ID_

*!id* `[reply]`
_Show User ID_

*!whois* `[id]`
_Show User's Username And Name_

*!clean* `[bans | mods | bots | rules | about | silentlist | filtelist | welcome]`   
_Bot Clean Them_

*!filter* `[word]`
_Word filter_

*!unfilter* `[word]`
_Word unfilter_

*!pin* `[reply]`
_Pin Your Message_

*!unpin* 
_Unpin Pinned Message_

*!welcome enable/disable*
_Enable Or Disable Group Welcome_

*!settings*
_Show Group Settings_

*!cmds* `[member | moderator | owner]`
_set cmd_

*!whitelist* `[+ | -]`
_Add User To White List_

*!silentlist*
_Show Silented Users List_

*!filterlist*
_Show Filtered Words List_

*!banlist*
_Show Banned Users List_

*!ownerlist*
_Show Group Owners List_ 

*!whitelist*
_Show Group whitelist List_

*!modlist* 
_Show Group Moderators List_

*!rules*
_Show Group Rules_

*!about*
_Show Group Description_

*!id*
_Show Your And Chat ID_

*!gpinfo*
_Show Group Information_

*!newlink*
_Create A New Link_

*!newlink pv*
_Create A New Link The Pv_

*!link*
_Show Group Link_

*!link pv*
_Send Group Link In Your Private Message_

*!setlang fa*
_Set Persian Language_

*!setwelcome [text]*
_set Welcome Message_

_You Can Use_ *[!/#]* _To Run The Commands_
_This Help List Only For_ *Moderators/Owners!*
_Its Means, Only Group_ *Moderators/Owners* _Can Use It!_
*Good luck ;)*]]

elseif lang then

Management = [[
*دستورات ربات پروتکشن:*

دستورات ربات نورس

❖--------------------------------❖

🔹ادمین گروه [username|id|reply] 
🔺افزودن ادمین گروه(درصورت اینکه ربات سازنده  گروه)

🔹حذف ادمین گروه [username|id|reply] 
🔺حذف ادمین گروه(درصورت اینکه ربات سازنده  گروه)

🔹مالک [username|id|reply] 
🔺انتخاب مالک گروه(قابل انتخاب چند مالک)

🔹حذف مالک [username|id|reply] 
🔺 حذف کردن فرد از فهرست مالکان گروه

🔹مدیر [username|id|reply] 
🔺ارتقا مقام کاربر به مدیر گروه

🔹حذف مدیر [username|id|reply] 
🔺تنزیل مقام مدیر به کاربر

🔹تنظیم پیام مکرر [2-50]
🔺تنظیم حداکثر تعداد پیام مکرر

🔹سکوت [username|id|reply] 
🔺بیصدا کردن کاربر در گروه

🔹حذف سکوت [username|id|reply] 
🔺در آوردن کاربر از حالت بیصدا در گروه

🔹اخراج [username|id|reply] 
🔺حذف کاربر از گروه

🔹بن [username|id|reply] 
🔺مسدود کردن کاربر از گروه

🔹حذف بن [username|id|reply] 
🔺در آوردن از حالت مسدودیت کاربر از گروه

🔹کاربری [username]
🔺نمایش شناسه کاربر

🔹ایدی [reply]
🔺نمایش شناسه کاربر

🔹شناسه [id]
🔺نمایش نام کاربر, نام کاربری و اطلاعات حساب

🔹تنظیم[قوانین | نام | لینک | درباره | خوشآمد]
🔺ربات آنهارا ثبت خواهد کرد
🔹پاک کردن [بن | مدیران | ربات | قوانین | درباره | لیست سکوت | خوشآمد]   
🔺ربات آنهارا پاک خواهد کرد

🔹لیست سفید [+|-]
🔺افزودن افراد به لیست سفید

🔹فیلتر [کلمه]
🔺فیلتر‌کلمه مورد نظر

🔹حذف فیلتر [کلمه]
🔺ازاد کردن کلمه مورد نظر

🔹سنجاق [reply]
🔺ربات پیام شمارا در گروه سنجاق خواهد کرد

🔹حذف سنجاق 
🔺ربات پیام سنجاق شده در گروه را حذف خواهد کرد

🔹خوشآمد فعال/غیرفعال
🔺فعال یا غیرفعال کردن خوشآمد گویی

🔹تنظیمات
🔺نمایش تنظیمات گروه

🔹دستورات [کاربر | مدیر | مالک] 
🔺نتخاب کردن قفل cmd بر چه مدیریتی

🔹لیست سکوت
🔺نمایش فهرست افراد بیصدا

🔹فیلتر لیست
🔺نمایش لیست کلمات فیلتر شده

🔹لیست سفید
🔺نمایش افراد سفید شده از گروه

🔹لیست بن
🔺نمایش افراد مسدود شده از گروه

🔹لیست مالکان
🔺نمایش فهرست مالکان گروه 

🔹لیست مدیران 
🔺نمایش فهرست مدیران گروه

🔹قوانین
🔹نمایش قوانین گروه

🔹درباره
🔺نمایش درباره گروه

🔹ایدی
🔺نمایش شناسه شما و گروه

🔹اطلاعات گروه
🔺نمایش اطلاعات گروه

🔹لینک جدید
🔺ساخت لینک جدید

🔹لینک جدید خصوصی
🔺ساخت لینک جدید در پیوی

🔹لینک
🔺نمایش لینک گروه

🔹لینک خصوصی
🔺ارسال لینک گروه به چت خصوصی شما

🔹زبان انگلیسی
🔺تنظیم زبان انگلیسی

🔹تنظیم خوشآمد [متن]
🔺ثبت پیام خوش آمد گویی

شما میتوانید از [!/#] در اول دستورات برای اجرای آنها بهره بگیرید
------------------------------------------------------------

DVE↝ @oollmlloo

CH↝ @Asayelelarab

_این راهنما فقط برای مدیران/مالکان گروه میباشد!
این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!_
*موفق باشید ;)*]]
end
return Management
end
-----------------------------------------
if matches[1]:lower() == "helpfun" or matches[1] == "م4" and is_mod(msg) then
if not lang then
helpfun = [[
_PCT Reborn Fun Help Commands:_

*!time*
_Get time in a sticker_

*!short* `[link]`
_Make short url_

*!voice* `[text]`
_Convert text to voice_

*!tr* `[lang] [word]`
_Translates FA to EN and EN to FA_
_Example:_
*!tr fa hi*

*!sticker* `[word]`
_Convert text to sticker_

*!photo* `[word]`
_Convert text to photo_

*!azan* `[city]`
_Get Azan time for your city_

*!calc* `[number]`
Calculator

*!praytime* `[city]`
_Get Patent (Pray Time)_

*!tosticker* `[reply]`
_Convert photo to sticker_

*!tophoto* `[reply]`
_Convert text to photo_

*!weather* `[city]`
_Get weather_

_You can use_ *[!/#]* _at the beginning of commands._

*Good luck ;)*]]
tdcli.sendMessage(msg.chat_id_, 0, 1, helpfun, 1, 'md')
else

helpfun = [[
راهنمای سرگرمی ربات نورس

❖--------------------------------❖

🔹ساعت
🔺دریافت ساعت به صورت استیکر

🔹لینک کوتاه [لینک]
🔺کوتاه کننده لینک

🔹تبدیل به صدا [متن]
🔺تبدیل متن به صدا

🔹ترجمه [زبان] [کلمه]
🔺ترجمه متن فارسی به انگلیسی وبرعکس
مثال:
ترجمه زبان سلام

🔹استیکر [کلمه]
🔺تبدیل متن به استیکر

🔹عکس [کلمه]
🔺تبدیل متن به عکس

🔹اذان [شهر]
🔺دریافت اذان

🔹حساب کن [عدد]
🔺ماشین حساب

🔹ساعات شرعی [شهر]
🔺اعلام ساعات شرعی

🔹تبدیل به استیکر [ریپلی]
🔺تبدیل عکس به استیکر

🔹تبدیل به عکس [ریپلی]
🔺تبدیل استیکر‌به عکس

🔹اب هوا [شهر]
🔺دریافت اب وهوا

شما میتوانید از [!/#] در اول دستورات برای اجرای آنها بهره بگیرید

------------------------------------------------------------

DVE↝ @oollmlloo

CH↝ @Asayelelarab


موفق باشید ;)]]
tdcli.sendMessage(msg.chat_id_, 0, 1, helpfun, 1, 'md')
end
end
-----------------------------------------
if matches[1] == "helptools" or  matches[1] == "م5" and is_mod(msg) then
if not lang then
text = [[

_Sudoer And Admins PCT Bot Help :_

*!visudo* `[username|id|reply]`
_Add Sudo_

*!desudo* `[username|id|reply]`
_Demote Sudo_

*!sudolist *
_Sudo(s) list_

*!adminprom* `[username|id|reply]`
_Add admin for bot_

*!admindem* `[username|id|reply]`
_Demote bot admin_

*!adminlist *
_Admin(s) list_

*!leave *
_Leave current group_

*!autoleave* `[disable/enable]`
_Automatically leaves group_

*!creategroup* `[text]`
_Create normal group_

*!createsuper* `[text]`
_Create supergroup_

*!tosuper *
_Convert to supergroup_

*!chats*
_List of added groups_

*!join* `[id]`
_Adds you to the group_

*!rem* `[id]`
_Remove a group from Database_

*!import* `[link]`
_Bot joins via link_

*!setbotname* `[text]`
_Change bot's name_

*!setbotusername* `[text]`
_Change bot's username_

*!delbotusername *
_Delete bot's username_

*!markread* `[off/on]`
_Second mark_

*!broadcast* `[text]`
_Send message to all added groups_

*!bc* `[text] [gpid]`
_Send message to a specific group_

*!sendfile* `[folder] [file]`
_Send file from folder_

*!sendplug* `[plug]`
_Send plugin_

*!del* `[Reply]`
_Remove message Person you are_

*!save* `[plugin name] [reply]`
_Save plugin by reply_

*!savefile* `[address/filename] [reply]`
_Save File by reply to specific folder_

*!clear cache*
_Clear All Cache Of .telegram-cli/data_

*!check*
_Stated Expiration Date_

*!check* `[GroupID]`
_Stated Expiration Date Of Specific Group_

*!charge* `[GroupID]` `[Number Of Days]`
_Set Expire Time For Specific Group_

*!charge* `[Number Of Days]`
_Set Expire Time For Group_

*!jointo* `[GroupID]`
_Invite You To Specific Group_

*!leave* `[GroupID]`
_Leave Bot From Specific Group_

_You can use_ *[!/#]* _at the beginning of commands._

`This help is only for sudoers/bot admins.`
 
*This means only the sudoers and its bot admins can use mentioned commands.*

*Good luck ;)*]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
else

text = [[
راهنمای ادمین و سودو های ربات نورس

❖--------------------------------❖

🔹سودو [username|id|reply]
🔺اضافه کردن سودو

🔹حذف سودو [username|id|reply]
🔺حذف کردن سودو

🔹لیست سودو 
🔺لیست سودو‌های ربات

🔹ادمین [username|id|reply]
🔺اضافه کردن ادمین به ربات

🔹حذف ادمین [username|id|reply]
🔺حذف فرد از ادمینی ربات

🔹لیست ادمین 
🔺لیست ادمین ها

🔹خروج 
🔺خارج شدن ربات از گروه

🔹خروج خودکار [غیرفعال/فعال | موقعیت]
🔺خروج خودکار

🔹ساخت گروه [اسم انتخابی]
🔺ساخت گروه ریلم

🔹ساخت سوپر گروه [اسم انتخابی]
🔺ساخت سوپر گروه

🔹تبدیل به سوپر 
🔺تبدیل به سوپر گروه

🔹لیست گروه ها
🔺لیست گروه های مدیریتی ربات

🔹افزودن [ایدی گروه]
🔺جوین شدن توسط ربات

🔹حذف گروه [ایدی گروه]
🔺حذف گروه ازطریق پنل مدیریتی

🔹ورود لینک [لینک_]
🔺جوین شدن ربات توسط لینک

🔹تغییر نام ربات [text]
🔺تغییر اسم ربات

🔹تغییر یوزرنیم ربات [text]
🔺تغییر یوزرنیم ربات

🔹حذف یوزرنیم ربات 
🔺پاک کردن یوزرنیم ربات

🔹تیک دوم [فعال/غیرفعال]
🔺تیک دوم

🔹ارسال به همه [متن]
🔺فرستادن پیام به تمام گروه های مدیریتی ربات

🔹ارسال [متن] [ایدی گروه]
🔺ارسال پیام مورد نظر به گروه خاص

🔹ارسال فایل [cd] [file]
🔺ارسال فایل موردنظر از پوشه خاص

🔹ارسال پلاگین [اسم پلاگین]
🔺ارسال پلاگ مورد نظر

🔹ذخیره پلاگین [اسم پلاگین] [reply]
🔺ذخیره کردن پلاگین

🔹ذخیره فایل [address/filename] [reply]
🔺ذخیره کردن فایل در پوشه مورد نظر

🔹پاک کردن حافظه
🔺پاک کردن کش مسیر .telegram-cli/data

🔹اعتبار
🔺اعلام تاریخ انقضای گروه

🔹اعتبار [ایدی گروه]
🔺اعلام تاریخ انقضای گروه مورد نظر

🔹شارژ [ایدی گروه] [تعداد روز]
🔺تنظیم تاریخ انقضای گروه مورد نظر

🔹شارژ [تعداد روز]
🔺تنظیم تاریخ انقضای گروه

🔹ورود به [ایدی گروه]
🔺دعوت شدن شما توسط ربات به گروه مورد نظر

🔹خروج [ایدی گروه]
🔺خارج شدن ربات از گروه مورد نظر

شما میتوانید از [!/#] در اول دستورات برای اجرای آنها بهره بگیرید

این راهنما فقط برای سودو ها/ادمین های ربات میباشد!
------------------------------------------------------------

DVE↝ @oollmlloo

CH↝ @Asayelelarab

*شما میتوانید از [!/#] در اول دستورات برای اجرای آنها بهره بگیرید*

_این راهنما فقط برای سودو ها/ادمین های ربات میباشد!_

`این به این معناست که فقط سودو ها/ادمین های ربات میتوانند از دستورات بالا استفاده کنند!`

*موفق باشید ;)*]]
tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
end
end
--------------------- Welcome -----------------------
	if (matches[1]:lower() == "welcome" or matches[1] == 'الترحيب') and is_mod(msg) then
	if not lang then
		if matches[2] == "enable" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "yes" then
				return "_Group_ *welcome* *Iѕ AƖяєαɗу ƐηαвƖєɗ*⚠️♻️"
			else
		data[tostring(chat)]['settings']['welcome'] = "yes"
	    save_data(_config.moderation.data, data)
				return "_Group_ *welcome* *Hαѕ Ɓєєη ƐηαвƖєɗ*🔇\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
			end
		end
		
		if matches[2] == "disable" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "no" then
				return "_Group_ *Welcome* *Iѕ AƖready Disable*"
			else
		data[tostring(chat)]['settings']['welcome'] = "no"
	    save_data(_config.moderation.data, data)
				return "_Group_ *welcome* *Hαѕ Ɓєєη ƊιѕαвƖєɗ*🔊\n*OяƊєя Ɓу :* `"..msg.from.id.."`"
			end
		end
		else
				if matches[2] == "تشغيل" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "yes" then
				return "*>* _الترحيب 💌 تم تفعيلة ✅ مسبقاً في هذا المجموعة  🚻 !_"
			else
		data[tostring(chat)]['settings']['welcome'] = "yes"
	    save_data(_config.moderation.data, data)
				return "*>* _الترحيب 💌 تم تفعيلة ✅ في هذا المجموعة  🚻 !_"
			end
		end
		
		if matches[2] == "تعطيل" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "no" then
				return "*>* _الترحيب 💌 تم تعطيلة ❌ مسبقاً في هذا المجموعة  🚻 !_"
			else
		data[tostring(chat)]['settings']['welcome'] = "no"
	    save_data(_config.moderation.data, data)
				return "*>* _الترحيب 💌 تم تعطيلة ❌ في هذا المجموعة  🚻 !_"
			end
		end
		end
	end
	if (matches[1]:lower() == "setwelcome" or matches[1] == 'ضع ترحيب') and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
       if not lang then
		return "_Welcome Message Has Been Set To :_\n*"..matches[2].."*\n\n*You can use :*\n_{gpname} Group Name_\n_{rules} ➣ Show Group Rules_\n_{time} ➣ Show time english _\n_{date} ➣ Show date english _\n_{timefa} ➣ Show time persian _\n_{datefa} ➣ show date persian _\n_{name} ➣ New Member First Name_\n_{username} ➣ New Member Username_"
       else
		return "_پیام خوشآمد گویی تنظیم شد به :_\n*"..matches[2].."*\n\n*شما میتوانید از*\n_{gpname} نام گروه_\n_{rules} ➣ نمایش قوانین گروه_\n_{time} ➣ ساعت به زبان انگلیسی _\n_{date} ➣ تاریخ به زبان انگلیسی _\n_{timefa} ➣ ساعت به زبان فارسی _\n_{datefa} ➣ تاریخ به زبان فارسی _\n_{name} ➣ نام کاربر جدید_\n_{username} ➣ نام کاربری کاربر جدید_\n_استفاده کنید_"
        end
     end
	end
end
   if msg.to.type ~= 'pv' then
 if (matches[1]:lower() == "kick" or matches[1] == "طرد") and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="kick"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.to.id, userid) then
   if not lang then
     tdcli.sendMessage(msg.to.id, "", 0, "_You can't kick mods,owners or bot admins_", 0, "md")
   elseif lang then
     tdcli.sendMessage(msg.to.id, "", 0, "*>* _عذراً ⚠️ لايمكنك طرد 🚷  المشرفين - الادمنية - المدراء - في هذا المجموعة 🚻 !_", 0, "md")
         end
     else
kick_user(matches[2], msg.to.id)
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="kick"})
         end
      end
 if (matches[1]:lower() == "delall" or matches[1] == "حذف") and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="delall"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.to.id, userid) then
   if not lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "_You can't delete messages mods,owners or bot admins_", 0, "md")
     elseif lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "*>* _عذراً ⚠️ لايمكنك حذف رسائل 🚮  المشرفين - الادمنية - المدراء - في هذا المجموعة 🚻 !_", 0, "md")
   end
     else
tdcli.deleteMessagesFromUser(msg.to.id, matches[2], dl_cb, nil)
    if not lang then
  return tdcli.sendMessage(msg.to.id, "", 0, "_All_ *messages* _of_ *[ "..matches[2].." ]* _has been_ *deleted*", 0, "md")
   elseif lang then
  return tdcli.sendMessage(msg.to.id, "", 0, "*جميع رسائل 📨:-* *[ "..matches[2].." ]* *تم حذفها 🚮 بنجاح ✅ !*", 0, "md")
         end
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="delall"})
         end
      end
   end
 if (matches[1]:lower() == "banall" or matches[1] == "حظر عام") and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="banall"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_admin1(userid) then
   if not lang then
    return tdcli.sendMessage(msg.to.id, "", 0, "_You can't globally ban other admins_", 0, "md")
else
    return tdcli.sendMessage(msg.to.id, "", 0, "*>* _عذراً ⚠️ لايمكنك حظر  ⛔️  المشرفين - الادمنية - المدراء - في هذا المجموعة 🚻 !_", 0, "md")
        end
     end
   if is_gbanned(matches[2]) then
   if not lang then
  return tdcli.sendMessage(msg.to.id, "", 0, "*User "..matches[2].." is already globally banned*", 0, "md")
    else
  return tdcli.sendMessage(msg.to.id, "", 0, "*المستخدم "..matches[2].." تم حظره عام📛 من هذا المجموعة 🚻 مسبقاً ✅ !*", 0, "md")
        end
     end
  data['gban_users'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
kick_user(matches[2], msg.to.id)
   if not lang then
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "*User "..matches[2].." has been globally banned*", 0, "md")
    else
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "*المستخدم "..matches[2].." تم حظره عام📛 من هذا المجموعة 🚻 بنجاح ✅ !*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="banall"})
      end
   end
 if (matches[1]:lower() == "unbanall" or matches[1] == "الغاء العام") and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="unbanall"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_gbanned(matches[2]) then
     if not lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "*User "..matches[2].." is not globally banned*", 0, "md")
    else
   return tdcli.sendMessage(msg.to.id, "", 0, "*المستخدم "..matches[2].." لم يتم حظره عام 📛 من هذا المجموعة 🚻 !*", 0, "md")
        end
     end
  data['gban_users'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
   if not lang then
return tdcli.sendMessage(msg.to.id, msg.id, 0, "*User "..matches[2].." has been globally unbanned*", 0, "md")
   else
return tdcli.sendMessage(msg.to.id, msg.id, 0, "*المستخدم "..matches[2].." از تم الغاء الحظر عام📛 من هذا المجموعة 🚻 بنجاح ✅ !*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="unbanall"})
      end
   end
   if msg.to.type ~= 'pv' then
 if matches[1]:lower() == "ban" or matches[1] == "حظر" and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="ban"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.to.id, userid) then
     if not lang then
    return tdcli.sendMessage(msg.to.id, "", 0, "_You can't ban mods,owners or bot admins_", 0, "md")
    else
    return tdcli.sendMessage(msg.to.id, "", 0, "*>* _عذراً ⚠️ لايمكنك طرد 🚷  المشرفين - الادمنية - المدراء - في هذا المجموعة 🚻 !_", 0, "md")
        end
     end
   if is_banned(matches[2], msg.to.id) then
   if not lang then
  return tdcli.sendMessage(msg.to.id, "", 0, "_User "..matches[2].." is already banned_", 0, "md")
  else
  return tdcli.sendMessage(msg.to.id, "", 0, "*المستخدم "..matches[2].." تم حظره ⛔️ من هذا المجموعة 🚻 مسبقاً ✅ !*", 0, "md")
        end
     end
data[tostring(chat)]['banned'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
kick_user(matches[2], msg.to.id)
   if not lang then
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "_User "..matches[2].." has been banned_", 0, "md")
  else
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "*المستخدم "..matches[2].." از تم حظره ⛔️ من هذا المجموعة 🚻 بنجاح ✅ !*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
     tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="ban"})
      end
   end
 if (matches[1]:lower() == "unban" or matches[1] == "الغاء الحظر") and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="unban"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_banned(matches[2], msg.to.id) then
   if not lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "_User "..matches[2].." is not banned_", 0, "md")
  else
   return tdcli.sendMessage(msg.to.id, "", 0, "*المستخدم "..matches[2].." از لم يتم حظره ⛔️ من هذا المجموعة 🚻 !*", 0, "md")
        end
     end
data[tostring(chat)]['banned'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
   if not lang then
return tdcli.sendMessage(msg.to.id, msg.id, 0, "_User "..matches[2].." has been unbanned_", 0, "md")
   else
return tdcli.sendMessage(msg.to.id, msg.id, 0, "*المستخدم "..matches[2].." از تم الغاء الحظر ⛔️ عنه بنجاح ✅ !*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="unban"})
      end
   end
 if (matches[1]:lower() == "silent" or matches[1] == "كتم") and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="silent"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.to.id, userid) then
   if not lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "_You can't silent mods,leaders or bot admins_", 0, "md")
 else
   return tdcli.sendMessage(msg.to.id, "", 0, "*>* _عذراً ⚠️ لايمكنك كتم 🔕  المشرفين - الادمنية - المدراء - في هذا المجموعة 🚻 !_", 0, "md")
        end
     end
   if is_silent_user(matches[2], chat) then
   if not lang then
   return tdcli.sendMessage(msg.to.id, "", 0, "_User "..matches[2].." is already silent_", 0, "md")
   else
   return tdcli.sendMessage(msg.to.id, "", 0, "*المستخدم "..matches[2].." تم اضافة ➕ الى قائمة المكتومين 🔕 مسبقاً ✅ !*", 0, "md")
        end
     end
data[tostring(chat)]['is_silent_users'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
    if not lang then
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "_User "..matches[2].." added to silent users list_", 0, "md")
  else
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "*المستخدم "..matches[2].." تم اضافة ➕ الى قائمة المكتومين 🔕 بنجاح ✅ !*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="silent"})
      end
   end
 if (matches[1]:lower() == "unsilent" or matches[1] == "الغاء الكتم") and is_mod(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="unsilent"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_silent_user(matches[2], chat) then
     if not lang then
     return tdcli.sendMessage(msg.to.id, "", 0, "_User "..matches[2].." is not silent_", 0, "md")
   else
     return tdcli.sendMessage(msg.to.id, "", 0, "*المستخدم "..matches[2].." لم يتم كتمه 🤐 في هذا المجموعة 🚻 !*", 0, "md")
        end
     end
data[tostring(chat)]['is_silent_users'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
   if not lang then
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "_User "..matches[2].." removed from silent users list_", 0, "md")
  else
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "*المستخدم* "..matches[2].." تم ازالة 🚮 من قائمة المكتومين 🤐 بنجاح ✅*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="unsilent"})
      end
   end
		if (matches[1]:lower() == 'clean' or matches[1] == "تنظيف") and is_owner(msg) then
		if not lang then
			if matches[2]:lower() == 'bans' then
				if next(data[tostring(chat)]['banned']) == nil then

					return "_No_ *banned* _users in this group_"
				end
				for k,v in pairs(data[tostring(chat)]['banned']) do
					data[tostring(chat)]['banned'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "_All_ *banned* _users has been unbanned_"
			end
			if matches[2]:lower() == 'silentlist' then
				if next(data[tostring(chat)]['is_silent_users']) == nil then
					return "_No_ *silent* _users in this group_"
				end
				for k,v in pairs(data[tostring(chat)]['is_silent_users']) do
					data[tostring(chat)]['is_silent_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				    end
				return "*Silent list* _has been cleaned_"
			    end
				else
				
			if matches[2] == 'المحظورين' then
				if next(data[tostring(chat)]['banned']) == nil then
					return "*  قائمة المحظورين ⛔️ فارغة 📭 ياعزيزي !*"
				end
				for k,v in pairs(data[tostring(chat)]['banned']) do
					data[tostring(chat)]['banned'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "*تم تنظيف 🚮 قائمة المحظورين ⛔️ وتحرير جميع المستخدمين ✅ !*"
			end
			if matches[2] == 'المكتومين' then
				if next(data[tostring(chat)]['is_silent_users']) == nil then
					return "* قائمة المكتومين 🤐 فارغة 📭 ياعزيزي  !*"
				end
				for k,v in pairs(data[tostring(chat)]['is_silent_users']) do
					data[tostring(chat)]['is_silent_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				    end
				return "*تم تنظيف 🚮  قائمة المكتومين 🤐 بنجاح ✅  !*"
			    end
        end
		end
     end
		if (matches[1]:lower() == 'clean' or matches[1]:lower() == 'تنظيف') and is_sudo(msg) then
		if not lang then
			if matches[2]:lower() == 'gbans' then
				if next(data['gban_users']) == nil then
					return "_No_ *globally banned* _users available_"
				end
				for k,v in pairs(data['gban_users']) do
					data['gban_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "_All_ *globally banned* _users has been unbanned_"
			end
			else
		if matches[2] == 'المحظورين عام' then
				if next(data['gban_users']) == nil then
					return "*قائمة المحظورين عام 📛 فارغة 📭 ياعزيزي !*"
				end
				for k,v in pairs(data['gban_users']) do
					data['gban_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
				return "*تم تنظيف 🚮 قائمة المحظورين عام 📛 بنجاح ✅ !*"
			end
			end
     end
if matches[1]:lower() == "gbanlist" and is_admin(msg) or matches[1] == "المحظورين عام" and is_admin(msg) then
  return gbanned_list(msg)
 end
   if msg.to.type ~= 'pv' then
if matches[1]:lower() == "silentlist" and is_mod(msg) or matches[1] == "المكتومين" and is_mod(msg) then
  return silent_users_list(chat)
 end
if matches[1]:lower() == "banlist" and is_mod(msg) or matches[1] == "المحظورين" and is_mod(msg) then
  return banned_list(chat)
     end
  end
end
local checkmod = true
-----------------------------------------
local function pre_process(msg)
local chat = msg.to.id
local user = msg.from.id
local hash = "gp_lang:"..chat
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
 if checkmod and msg.text and msg.to.type == 'channel' then
	tdcli.getChannelMembers(msg.to.id, 0, 'Administrators', 200, function(a, b)
	local secchk = true
	checkmod = false
		for k,v in pairs(b.members_) do
			if v.user_id_ == tonumber(our_id) then
				secchk = false
			end
		end
		if secchk then
			checkmod = false
			if not lang then
				return tdcli.sendMessage(msg.to.id, 0, 1, '*>* _Robot isn\'t Administrator, Please promote to Admin!_\n@Star_Wars', 1, "md")
			else
				return tdcli.sendMessage(msg.to.id, 0, 1, '*>* _عزيزي 😃 يرجى  رفع البوت 🤖 ادمن 🚻 في مجموعتك لكي اقوم بلعمل 🔄 وشكراً !_, "md")
			end
		end
	end, nil)
 end
	local function welcome_cb(arg, data)
	local url , res = http.request('http://irapi.ir/time/')
          if res ~= 200 then return "No connection" end
      local jdat = json:decode(url)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
     if not lang then
     welcome = "*Welcome Dude*"
    elseif lang then
     welcome = "_Welcome Dude_"
        end
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
   if not lang then
     rules = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban.\n@Star_Wars"
    elseif lang then
       rules = "ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.\n@ProtectionTeam"
 end
end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
		local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name_..' '..(data.last_name_ or '')))
		local welcome = welcome:gsub("{username}", user_name)
		local welcome = welcome:gsub("{time}", jdat.ENtime)
		local welcome = welcome:gsub("{date}", jdat.ENdate)
		local welcome = welcome:gsub("{timeiq}", jdat.FAtime)
		local welcome = welcome:gsub("{datefa}", jdat.FAdate)
		local welcome = welcome:gsub("{gpname}", arg.gp_name)
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	if msg.adduser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli.getUser(msg.adduser, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
		else
			return false
		end
	end
	if msg.joinuser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli.getUser(msg.sender_user_id_, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title})
		else
			return false
        end
		end
	end
	   if msg.to.type ~= 'pv' then
chat = msg.to.id
user = msg.from.id
	local function check_newmember(arg, data)
		test = load_data(_config.moderation.data)
		lock_bots = test[arg.chat_id]['settings']['lock_bots']
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    if data.type_.ID == "UserTypeBot" then
      if not is_owner(arg.msg) and lock_bots == 'yes' then
kick_user(data.id_, arg.chat_id)
end
end
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if is_banned(data.id_, arg.chat_id) then
   if not lang then
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "_User_ "..user_name.." *[ "..data.id_.." ]* _is banned_", 0, "md")
   else
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "_المستخدم_ "..user_name.." *[ "..data.id.."]*_banned_", 0, "md")
end
kick_user(data.id_, arg.chat_id)
end
if is_gbanned(data.id_) then
     if not lang then
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "_User_ "..user_name.." *[ "..data.id_.." ]* _is globally banned_", 0, "md")
    else
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "_المستخدم_ "..user_name.." *[ "..data.id_.." ]* _تم حظره ⛔️ من هذا البوت بنجاح ✅ !_", 0, "md")
   end
kick_user(data.id_, arg.chat_id)
     end
	end
	if msg.adduser then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.adduser
    	}, check_newmember, {chat_id=chat,msg_id=msg.id,user_id=user,msg=msg})
	end
	if msg.joinuser then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.joinuser
    	}, check_newmember, {chat_id=chat,msg_id=msg.id,user_id=user,msg=msg})
	   end
 if is_silent_user(msg.from.id, msg.to.id) then
 del_msg(msg.to.id, msg.id)
    return false
 end
 if is_banned(msg.from.id, msg.to.id) then
 del_msg(msg.to.id, tonumber(msg.id))
     kick_user(msg.from.id, msg.to.id)
    return false
    end
 if is_gbanned(msg.from.id) then
 del_msg(msg.to.id, tonumber(msg.id))
     kick_user(msg.from.id, msg.to.id)
    return false
   end
 end
	return msg
 end
return {
  description = "Plugin to manage other plugins. Enable, disable or reload.", 
  usage = {
      moderator = {
          "!pl - [plugin] chat : disable plugin only this chat.",
          "!pl + [plugin] chat : enable plugin only this chat.",
          },
      sudo = {
          "!plist : list all plugins.",
          "!pl + [plugin] : enable plugin.",
          "!pl - [plugin] : disable plugin.",
          "!pl * : reloads all plugins." },
          },
patterns ={
command .. "([Ii]d)$",
command .. "([Aa]dd)$",
command .. "([Pp]lugin)$",
command .. "([Pp]l) (+) ([%w_%.%-]+)$",
command .. "([Pp]l) (-) ([%w_%.%-]+)$",
command .. "([Pp]l) (+) ([%w_%.%-]+) (chat)$",
command .. "([Pp]l) (-) ([%w_%.%-]+) (chat)$",
command .. "([Pp]l) (*)$",
command .. "([Rr]eload)$",
command .. "([Rr]em)$",
command .. "([Ii]d) (.*)$",
command .. "([Pp]in)$",
command .. "([Uu]npin)$",
command .. "([Gg]pinfo)$",
command .. "([Ss]etmanager)$",
command .. "([Ss]etmanager) (.*)$",
command .. "([Rr]emmanager)$",
command .. "([Rr]emmanager) (.*)$",
command .. "([Ww]hitelist) ([+-])$",
command .. "([Ww]hitelist) ([+-]) (.*)$",
command .. "([Ww]hitelist)$",
command .. "([Ss]etowner)$",
command .. "([Ss]etowner) (.*)$",
command .. "([Rr]emowner)$",
command .. "([Rr]emowner) (.*)$",
command .. "([Pp]romote)$",
command .. "([Pp]romote) (.*)$",
command .. "([Dd]emote)$",
command .. "([Dd]emote) (.*)$",
command .. "([Mm]odlist)$",
command .. "([Oo]wnerlist)$",
command .. "([Ll]ock) (.*)$",
command .. "([Uu]nlock) (.*)$",
command .. "([Mm]ute) (.*)$",
command .. "([Uu]nmute) (.*)$",
command .. "([Ll]ink)$",
command .. "([Ll]ink) (pv)$",
command .. "([Ss]etlink)$",
command .. "([Ss]etlink) ([https?://w]*.?telegram.me/joinchat/%S+)$",
command .. "([Ss]etlink) ([https?://w]*.?t.me/joinchat/%S+)$",
command .. "([Nn]ewlink)$",
command .. "([Nn]ewlink) (pv)$",  
command .. "([Rr]ules)$",
command .. "([Ss]ettings)$",
command .. "([Ss]etrules) (.*)$",
command .. "([Aa]bout)$",
command .. "([Ss]etabout) (.*)$",
command .. "([Ss]etname) (.*)$",
command .. "([Cc]lean) (.*)$",
command .. "([Ss]etflood) (%d+)$",
command .. "([Ss]etchar) (%d+)$",
command .. "([Ss]etfloodtime) (%d+)$",
command .. "([Rr]es) (.*)$",
command .. "([Cc]mds) (.*)$",
command .. "([Ww]hois) (%d+)$",
command .. "([Hh]elp)$",
command .. "([Ss]etlang) ([As][Rr])$",
command .. "([Ff]ilter) (.*)$",
command .. "([Uu]nfilter) (.*)$",
command .. "([Ff]ilterlist)$",
command .. "([Cc]onfig)$",
command .. "([Ss]etwelcome) (.*)",
command .. "([Ww]elcome) (.*)$",
command .. '([Mm]uteall) (status)$',
command .. '([Hh]elpmute)$',
command .. '([Mm]utetime) (%d+) (%d+) (%d+)$',
command .. '([Mm]utehours) (%d+)$',
command .. '([Mm]uteminutes) (%d+)$',
command .. '([Mm]uteseconds) (%d+)$',
command .. "([Hh]elplock)$",
command .. "([Hh]elpmanag)$",
command .. "([Hh]elpfun)$",
command .. "([Hh]elptools)$",
command .. "([Ii]nvite) @(.*)$",
command .. "([Ii]nvite) (.*)$",
command .. "([Ii]nvite)$",
command .. "([Ee]dit) (.*)$",
command .. "([Ee]dit) (.*)$",
command ..	"([Cc]lean) ([Bb]lacklist)$",
command ..	"([Aa]ddkick)$",
command ..	"([Cc]leanbot)$",
command ..  "([Pp]ing)$",
command ..  "([Ss]etnerkh) (.*)$",
command ..  "([Dd]elnerkh)$",
command ..  "([Nn]erkh)$",
command .. "([Ee]cho) (.*)$",
command .. "([Dd][Ee][Ll]) (%d+)$",
command .. "([Bb]anall)$",
command .. "([Bb]anall) (.*)$",
command .. "([Uu]nbanall)$",
command .. "([Uu]nbanall) (.*)$",
command .. "([Gg]banlist)$",
command .. "([Bb]an)$",
command .. "([Bb]an) (.*)$",
command .. "([Uu]nban)$",
command .. "([Uu]nban) (.*)$",
command .. "([Bb]anlist)$",
command .. "([Ss]ilent)$",
command .. "([Ss]ilent) (.*)$",
command .. "([Uu]nsilent)$",
command .. "([Uu]nsilent) (.*)$",
command .. "([Ss]ilentlist)$",
command .. "([Kk]ick)$",
command .. "([Kk]ick) (.*)$",
command .. "([Dd]elall)$",
command .. "([Dd]elall) (.*)$",
command .. "([Cc]lean) (.*)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^([Ii][Dd])$",
"^([Aa][Dd][Dd])$",
"^([Rr][Ee][Mm])$",
"^([Ii][Dd]) (.*)$",
"^([Pp][Ii][Nn])$",
"^([Uu][Nn][Pp][Ii][Nn])$",
"^([Gg][Pp][Ii][Nn][Ff][Oo])$",
"^([Ss][Ee][Tt][Mm][Aa][Nn][Aa][Gg][Ee][Rr])$",
"^([Ss][Ee][Tt][Mm][Aa][Nn][Aa][Gg][Ee][Rr]) (.*)$",
"^([Rr][Ee][Mm][Mm][Aa][Nn][Aa][Gg][Ee][Rr])$",
"^([Rr][Ee][Mm][Mm][Aa][Nn][Aa][Gg][Ee][Rr]) (.*)$",
"^([Ww][Hh][Ii][Tt][Ee][Ll][Ii][Ss][Tt]) ([+-])$",
"^([Ww][Hh][Ii][Tt][Ee][Ll][Ii][Ss][Tt]) ([+-]) (.*)$",
"^([Ww][Hh][Ii][Tt][Ee][Ll][Ii][Ss][Tt])$",
"^([Ss][Ee][Tt][Oo][Ww][Nn][Ee][Rr])$",
"^([Ss][Ee][Tt][Oo][Ww][Nn][Ee][Rr]) (.*)$",
"^([Rr][Ee][Mm][Oo][Ww][Nn][Ee][Rr])$",
"^([Rr][Ee][Mm][Oo][Ww][Nn][Ee][Rr]) (.*)$",
"^([Pp][Rr][Oo][Mm][Oo][Tt][Ee])$",
"^([Pp][Rr][Oo][Mm][Oo][Tt][Ee]) (.*)$",
"^([Dd][Ee][Mm][Oo][Tt][Ee])$",
"^([Dd][Ee][Mm][Oo][Tt][Ee]) (.*)$",
"^([Mm][Oo][Dd][Ll][Ii][Ss][Tt])$",
"^([Oo][Ww][Nn][Ee][Rr][Ll][Ii][Ss][Tt])$",
"^([Ll][Oo][Cc][Kk]) (.*)$",
"^([Uu][Nn][Ll][Oo][Cc][Kk]) (.*)$",
"^([Mm][Uu][Tt][Ee]) (.*)$",
"^([Uu][Nn][Mm][Uu][Tt][Ee]) (.*)$",
"^([Ll][Ii][Nn][Kk])$",
"^([Ll][Ii][Nn][Kk]) (pv)$",
"^([Ss][Ee][Tt][Ll][Ii][Nn][Kk])$",
"^([Ss][Ee][Tt][Ll][Ii][Nn][Kk]) ([https?://w]*.?telegram.me/joinchat/%S+)$",
"^([Ss][Ee][Tt][Ll][Ii][Nn][Kk]) ([https?://w]*.?[Tt].me/joinchat/%S+)$",
"^([Nn][Ee][Ww][Ll][Ii][Nn][Kk])$",
"^([Nn][Ee][Ww][Ll][Ii][Nn][Kk]) (pv)$",  
"^([Rr][Uu][Ll][Ee][Ss])$",
"^([Ss][Ee][Tt][Tt][Ii][Nn][Gg][Ss])$",
"^([Mm][Uu][Tt][Ee][Ll][Ii][Ss][Tt])$",
"^([Ss][Ee][Tt][Rr][Uu][Ll][Ee][Ss]) (.*)$",
"^([Bb][Oo][Uu][Tt])$",
"^([Ss][Ee][Tt][Aa][Bb][Oo][Uu][Tt]) (.*)$",
"^([Ss][Ee][Tt][Nn][Aa][Mm][Ee]) (.*)$",
"^([Cc][Ll][Ee][Aa][Nn]) (.*)$",
"^([Ss][Ee][Tt][Ff][Ll][Oo][Oo][Dd]) (%d+)$",
"^([Ss][Ee][Tt][Cc][Hh][Aa][Rr]) (%d+)$",
"^([Ss][Ee][Tt][Ff][Ll][Oo][Oo][Dd][Tt][Ii][Mm][Ee]) (%d+)$",
"^([Rr][Ee][Ss]) (.*)$",
"^([Cc][Mm][Dd][Ss]) (.*)$",
"^([Ww][Hh][Oo][Ii][Ss]) (%d+)$",
"^([Hh][Ee][Ll][Pp])$",
"^([Ss][Ee][Tt][Ll][Aa][Nn][Gg]) ([Aa][Rr])$",
"^([Ff][Ii][Ll][Tt][Ee][Rr]) (.*)$",
"^([Uu][Nn][Ff][Ii][Ll][Tt][Ee][Rr]) (.*)$",
"^([Ff][Ii][Ll][Tt][Ee][Rr][Ll][Ii][Ss][Tt])$",
"^([Cc][Oo][Nn][Ff][Ii][Gg])$",
"^([Ss][Ee][Tt][Ww][Ee][Ll][Cc][Oo][Mm][Ee]) (.*)",
"^([Ww][Ee][Ll][Cc][Oo][Mm][Ee]) (.*)",
'^([Mm][Uu][Tt][Ee][Aa][Ll][Ll]) ([Ss][Tt][Aa][Tt][Uu][Ss])$',
'^([Hh][Ee][Ll][Pp][Mm][Uu][Tt][Ee])$',
'^([Mm][Uu][Tt][Ee][Tt][Ii][Mm][Ee]) (%d+) (%d+) (%d+)$',
'^([Mm][Uu][Tt][Ee][Hh][Oo][Uu][Rr][Ss]) (%d+)$',
'^([Mm][Uu][Tt][Ee][Mm][Ii][Nn][Uu][Tt][Ee][Ss]) (%d+)$',
'^([Mm][Uu][Tt][Ee][Ss][Ee][Cc][Oo][Nn][Dd][Ss]) (%d+)$',
"^([Hh][Ee][Ll][Pp][Ll][Oo][Cc][Kk])$",
"^([Hh][Ee][Ll][Pp][Mm][Aa][Nn][Aa][Gg])$",
"^([Hh][Ee][Ll][Pp][Ff][Uu][Nn])$",
"^([Hh][Ee][Ll][Pp][Tt][Oo][Oo][Ll][Ss])$",
"^([Pp]lugin)$",
"^([Pp]l) (+) ([%w_%.%-]+)$",
"^([Pp]l) (-) ([%w_%.%-]+)$",
"^([Pp]l) (+) ([%w_%.%-]+) (chat)$",
"^([Pp]l) (-) ([%w_%.%-]+) (chat)$",
"^([Pp]l) (*)$",
"^([Rr]eload)$",
"^([Cc]lean) ([Bb]lacklist)$",
"^([Aa]ddkick)$",
"^([Pp]ing)$",
"^([Dd]elnerkh)$",
"^([Ss]etnerkh) (.*)$",
"^([Ee]dit) (.*)$",
"^([Ee]dit) (.*)$",
"^([Ee]cho) (.*)$",
"^([Nn]erkh)$",
"^([Cc]leanbot)$",
"^([Ii]nvite)$", 
"^([Ii]nvite) @(.*)$",
"^([Ii]nvite) (.*)$",
"^([Bb]anall)$",
"^([Bb]anall) (.*)$",
"^([Uu]nbanall)$",
"^([Uu]nbanall) (.*)$",
"^([Gg]banlist)$",
"^([Bb]an)$",
"^([Bb]an) (.*)$",
"^([Uu]nban)$",
"^([Uu]nban) (.*)$",
"^([Bb]anlist)$",
"^([Ss]ilent)$",
"^([Ss]ilent) (.*)$",
"^([Uu]nsilent)$",
"^([Uu]nsilent) (.*)$",
"^([Ss]ilentlist)$",
"^([Kk]ick)$",
"^([Kk]ick) (.*)$",
"^([Dd]elall)$",
"^([Dd]elall) (.*)$",
"^([Cc]lean) (.*)$",
"^([Mm][Ee])$"
},
patterns_fa = {
'^(ايدي)$',
'^(ايدي) (.*)$',
'^(الاعدادات)$',
'^(تقبيت)$',
'^(الغاء التثبيت)$',
'^(تفعيل)$',
'^(تعطيل)$',
'^(رفع مشرف)$',
'^(رفع مشرف) (.*)$',
'^(تنزيل مشرف) (.*)$',
'^(تنزيل مشرف)$',
'^(القائمه البيضاء) ([+-]) (.*)$',
'^(القائمه البيضاء) ([+-])$',
'^(القائمه البيضاء)$',
'^(رفع مدير)$',
'^(رفع مدير) (.*)$',
'^(تنزيل مدير) (.*)$',
'^(تنزيل مدير)$',
'^(رفع ادمن)$',
'^(رفع ادمن) (.*)$',
'^(تنزيل ادمن)$',
'^(تنزيل ادمن) (.*)$',
'^(قفل) (.*)$',
'^(فتح) (.*)$',
'^(قفل) (.*)$',
'^(فتح) (.*)$',
'^(رابط جديد)$',
'^(رابط جديد) (خاص)$',
'^(معلومات المجموعه)$',
'^(دستورات) (.*)$',
'^(القوانين)$',
'^(الرابط)$',
'^(ضع رابط)$',
'^(ضع رابط) ([https?://w]*.?telegram.me/joinchat/%S+)$',
'^(ضع رابط) ([https?://w]*.?t.me/joinchat/%S+)$',
'^(ضع قوانین) (.*)$',
'^(الرابط) (خاص)$',
'^(فحص) (.*)$',
'^(شناسه) (%d+)$',
'^(ضع تكرار) (%d+)$',
'^(ضع مدة التكرار) (%d+)$',
'^(حداکثر حروف مجاز) (%d+)$',
'^(تنظيف) (.*)$',
'^(الوصف)$',
'^(ضع اسم) (.*)$',
'^(ضع وصف) (.*)$',
'^(قائمه المنع)$',
'^(قائمه المدراء)$',
'^(قائمه الادمنيه)$',
'^(الاوامر)$',
'^(الحمايه)$',
'^(منع) (.*)$',
'^(الغاء المنع) (.*)$',
'^(الترحيب) (.*)$',
'^(ضع ترحيب) (.*)$',
'^(كتم لمدة ساعه) (%d+)$',
'^(كتم لمدة دقيقه) (%d+)$',
'^(كتم لمدة ثانيه) (%d+)$',
'^(موقعیت) (بیصدا)$',
'^(كتم لمدة) (%d+) (%d+) (%d+)$',
'^(تحويل لغه En)$',
'^([https?://w]*.?telegram.me/joinchat/%S+)$',
'^([https?://w]*.?t.me/joinchat/%S+)$',
"^(م1)$",
"^(م2)$",
"^(م3)$",
"^(م4)$",
"^(م5)$",
"^(اعادة التحميل)$",
"^(الملفات)$",
"^(ملف) (+) ([%w_%.%-]+)$",
"^(ملف) (-) ([%w_%.%-]+)$",
"^(ملف) (+) ([%w_%.%-]+) (گروه)$",
"^(ملف) (-) ([%w_%.%-]+) (گروه)$", 
"^(تنظيف) (قائمه البلوك)$",
"^(اونلاين)$",
"^(افزودن ریمو)$",
"^(نرخ)$",
 "^(تنظیم نرخ) (.*)$",
 "^(پاک کردن نرخ)$",
"^(موقعي)$",
"^(تنظيف البوتات) (.*)$",
"^(كرر) (.*)$",
"^( تعديل) (.*)$",
 "^(حظر عام)$",
 "^(حظر عام) (.*)$",
 "^(الغاء العام)$",
 "^(الغاء العام) (.*)$",
 "^(لیست سوپر بن)$",
 "^(حظر)$",
 "^(حظر) (.*)$",
 "^(الغاء الحظر)$",
 "^(الغاء الحظر) (.*)$",
 "^(المحظورين)$",
 "^(كتم)$",
 "^(كتم) (.*)$",
 "^(الغاء الكتم)$",
 "^(الغاء الكتم) (.*)$",
 "^(المكتومين)$",
 "^(طرد)$",
 "^(طرد) (.*)$",
 "^(حذف)$",
 "^(حذف) (.*)$",
 "^(پاک کردن) (.*)$",
"^(تعديل) (.*)$"
},
run=run,
pre_process = pre_process
}
--By Sudo :- @iiDii - And @xDrr Thanks To @Mk_Team
-- ## @Star_Wars
