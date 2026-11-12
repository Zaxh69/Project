local player = game.Players.LocalPlayer
local function getF3X()
    for _,v in ipairs(player.Backpack:GetChildren()) do if v:FindFirstChild("SyncAPI") then return v end end
    for _,v in ipairs(player.Character:GetChildren()) do if v:FindFirstChild("SyncAPI") then return v end end
end
local f3x = getF3X()
if not f3x then warn("F3X not found - equip btools") return end
local endpoint = f3x.SyncAPI.ServerEndpoint
local function syncAnchor(ep, part, a) ep:InvokeServer("SyncAnchor", {{Part = part, Anchored = a}}) end
local function bResize(ep,t) if #t>0 then ep:InvokeServer("SyncResize", t) end end
local function bMaterial(ep,t) if #t>0 then ep:InvokeServer("SyncMaterial", t) end end
local function bColor(ep,t) if #t>0 then ep:InvokeServer("SyncColor", t) end end
local function bCollision(ep,t) if #t>0 then ep:InvokeServer("SyncCollision", t) end end
local function createMesh(ep,p) ep:InvokeServer("CreateMeshes", {{Part = p}}) end
local function syncMesh(ep,p,mt,sc,of,mid,tid,vc)
    local a = {Part = p}
    if mt then a.MeshType = mt end
    if sc then a.Scale = sc end
    if of then a.Offset = of end
    if mid then a.MeshId = mid end
    if tid then a.TextureId = tid end
    if vc then a.VertexColor = vc end
    ep:InvokeServer("SyncMesh", {a})
end
local function createDecal(ep,p,f) ep:InvokeServer("CreateTextures", {{Part=p, Face=f, TextureType="Decal"}}) end
local function setDecalTex(ep,p,t,f) ep:InvokeServer("SyncTexture", {{Part=p, Face=f, TextureType="Decal", Texture=t}}) end
local function setDecalTr(ep,p,t,f) ep:InvokeServer("SyncTexture", {{Part=p, Face=f, TextureType="Decal", Transparency=t}}) end
local function createTexture(ep,p,f) ep:InvokeServer("CreateTextures", {{Part=p, Face=f, TextureType="Texture"}}) end
local function setTexId(ep,p,t,f) ep:InvokeServer("SyncTexture", {{Part=p, Face=f, TextureType="Texture", Texture=t}}) end
local function setTexTr(ep,p,t,f) ep:InvokeServer("SyncTexture", {{Part=p, Face=f, TextureType="Texture", Transparency=t}}) end
local function createLight(ep,p,lt) ep:InvokeServer("CreateLights", {{Part=p, LightType=lt}}) end
local function syncLight(ep,p,lt,br,rg,co,sh,fa,an)
    local a = {Part=p, LightType=lt}
    if br then a.Brightness = br end
    if rg then a.Range = rg end
    if co then a.Color = co end
    if sh then a.Shadows = sh end
    if fa and fa ~= "nil" then a.Face = fa end
    if an then a.Angle = an end
    ep:InvokeServer("SyncLighting", {a})
end
local function createGroup(ep,gt,pr,it) return ep:InvokeServer("CreateGroup", gt, pr, it) end
local function setName(ep,o,n) ep:InvokeServer("SetName", {o}, n) end
local function setLocked(ep,p,l) ep:InvokeServer("SetLocked", {p}, l) end

local P = {}

local partData = {
    [6] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [673] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [815] = {anchored=true, isMeshPart=false, size=Vector3.new(4.399798393249512,2.099970817565918,3.649892807006836)},
    [685] = {anchored=true, isMeshPart=false, size=Vector3.new(53.299827575683594,2.9499669075012207,0.8998931646347046)},
    [561] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [892] = {anchored=true, isMeshPart=false, size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)},
    [725] = {anchored=true, isMeshPart=false, size=Vector3.new(73.99982452392578,1.549999475479126,1.0499999523162842)},
    [41] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7390000224113464,0.25999999046325684,1.2899999618530273)},
    [675] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [357] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [871] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [124] = {anchored=true, isMeshPart=false, size=Vector3.new(1.8064450025558472,0.6355556845664978,3.153334140777588)},
    [1201] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [182] = {anchored=true, isMeshPart=false, size=Vector3.new(2.72048020362854,0.8687180876731873,2.0918993949890137)},
    [320] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [855] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [1188] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [762] = {anchored=true, isMeshPart=false, size=Vector3.new(40,2.4000000953674316,39)},
    [597] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [184] = {anchored=true, isMeshPart=false, size=Vector3.new(1.9000009298324585,1.2000000476837158,2)},
    [804] = {anchored=true, isMeshPart=false, size=Vector3.new(28.499805450439453,0.29996782541275024,0.44999998807907104)},
    [402] = {anchored=true, isMeshPart=false, size=Vector3.new(2,1,1)},
    [569] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [582] = {anchored=true, isMeshPart=false, size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)},
    [512] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,1.4845397472381592,1.4515492916107178)},
    [279] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7390000224113464,0.25999999046325684,1.2899999618530273)},
    [742] = {anchored=true, isMeshPart=false, size=Vector3.new(8.29978084564209,1.5999703407287598,2.799893856048584)},
    [748] = {anchored=true, isMeshPart=false, size=Vector3.new(0.44999998807907104,17.39996337890625,9.899884223937988)},
    [478] = {anchored=true, isMeshPart=false, size=Vector3.new(3.8925414085388184,3.4741146564483643,3.028538703918457)},
    [767] = {anchored=true, isMeshPart=false, size=Vector3.new(5.099806785583496,9.999967575073242,0.05000000074505806)},
    [607] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [979] = {anchored=true, isMeshPart=false, size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)},
    [788] = {anchored=true, isMeshPart=false, size=Vector3.new(12.649802207946777,1.4999711513519287,2.3998939990997314)},
    [1123] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,1.4845397472381592,1.4515492916107178)},
    [575] = {anchored=true, isMeshPart=false, size=Vector3.new(0.10000000149011612,3.100001096725464,15.100003242492676)},
    [782] = {anchored=true, isMeshPart=false, size=Vector3.new(0.44999998807907104,17.39996337890625,9.899884223937988)},
    [1081] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [1062] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [1017] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,1.4845397472381592,1.4515492916107178)},
    [868] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [1145] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [1263] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [94] = {anchored=true, isMeshPart=false, size=Vector3.new(2.4444451332092285,4.888890266418457,2.4444451332092285)},
    [1239] = {anchored=true, isMeshPart=false, size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)},
    [676] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [609] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [1001] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [1315] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,1.2000001668930054,3.9000000953674316)},
    [656] = {anchored=true, isMeshPart=false, size=Vector3.new(0.599822998046875,20.199966430664062,66.99989318847656)},
    [495] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [997] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,2.4999709129333496,1.3998939990997314)},
    [733] = {anchored=true, isMeshPart=false, size=Vector3.new(0.19978031516075134,1.5999703407287598,2.299894332885742)},
    [540] = {anchored=true, isMeshPart=false, size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)},
    [781] = {anchored=true, isMeshPart=false, size=Vector3.new(5.599987030029297,22.199996948242188,8)},
    [619] = {anchored=true, isMeshPart=false, size=Vector3.new(0.29999905824661255,9.000004768371582,35.20002746582031)},
    [264] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [441] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [922] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [1223] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,2,0.800000011920929)},
    [769] = {anchored=true, isMeshPart=false, size=Vector3.new(83.49983978271484,20.199968338012695,4.049999713897705)},
    [603] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [1312] = {anchored=true, isMeshPart=false, size=Vector3.new(3.4865970611572266,0.2845395505428314,0.25)},
    [789] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,0.15000000596046448,0.4500000476837158)},
    [745] = {anchored=true, isMeshPart=false, size=Vector3.new(7.899785041809082,1.4999691247940063,0.05000000074505806)},
    [812] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [898] = {anchored=true, isMeshPart=false, size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)},
    [732] = {anchored=true, isMeshPart=false, size=Vector3.new(0.19978031516075134,1.7499700784683228,0.4498937129974365)},
    [391] = {anchored=true, isMeshPart=false, size=Vector3.new(1,1,1)},
    [681] = {anchored=true, isMeshPart=false, size=Vector3.new(0.44999998807907104,17.39996337890625,9.899884223937988)},
    [309] = {anchored=true, isMeshPart=false, size=Vector3.new(1.9700002670288086,1.809999942779541,1.4099998474121094)},
    [88] = {anchored=true, isMeshPart=false, size=Vector3.new(1,1.0999999046325684,1)},
    [1297] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [213] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7390000224113464,0.25999999046325684,1.2899999618530273)},
    [212] = {anchored=true, isMeshPart=false, size=Vector3.new(1,0.800000011920929,1)},
    [775] = {anchored=true, isMeshPart=false, size=Vector3.new(5.099806785583496,9.999968528747559,0.05000000074505806)},
    [1295] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [728] = {anchored=true, isMeshPart=false, size=Vector3.new(7.899777412414551,0.05000000074505806,0.19989505410194397)},
    [1076] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,1.4845397472381592,1.4515492916107178)},
    [1109] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [1013] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [1280] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [42] = {anchored=true, isMeshPart=false, size=Vector3.new(1,1,1)},
    [313] = {anchored=true, isMeshPart=false, size=Vector3.new(2,1,1)},
    [1059] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [227] = {anchored=true, isMeshPart=false, size=Vector3.new(2,2,1)},
    [833] = {anchored=true, isMeshPart=false, size=Vector3.new(73.99982452392578,1.549999475479126,1.0499999523162842)},
    [730] = {anchored=true, isMeshPart=false, size=Vector3.new(0.19978031516075134,1.7499701976776123,0.4498937129974365)},
    [300] = {anchored=true, isMeshPart=false, size=Vector3.new(2,0.33236390352249146,2)},
    [190] = {anchored=true, isMeshPart=false, size=Vector3.new(0.2574584484100342,0.2579691708087921,2.2057864665985107)},
    [1040] = {anchored=true, isMeshPart=false, size=Vector3.new(3.8925414085388184,3.4741146564483643,3.028538703918457)},
    [338] = {anchored=true, isMeshPart=false, size=Vector3.new(1.9700002670288086,1.809999942779541,1.4099998474121094)},
    [977] = {anchored=true, isMeshPart=false, size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)},
    [1331] = {anchored=true, isMeshPart=false, size=Vector3.new(12,1,12)},
    [1329] = {anchored=true, isMeshPart=false, size=Vector3.new(2.364640951156616,5.493091106414795,5.104769706726074)},
    [865] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [248] = {anchored=true, isMeshPart=false, size=Vector3.new(2,1,1)},
    [1326] = {anchored=true, isMeshPart=false, size=Vector3.new(13,9,2)},
    [1077] = {anchored=true, isMeshPart=false, size=Vector3.new(3.4865970611572266,0.2845395505428314,0.25)},
    [1324] = {anchored=true, isMeshPart=false, size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)},
    [1317] = {anchored=true, isMeshPart=false, size=Vector3.new(11.100000381469727,3.8999996185302734,7.899999618530273)},
    [1203] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [245] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [852] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [1158] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [47] = {anchored=true, isMeshPart=false, size=Vector3.new(1,0.9999997615814209,1)},
    [869] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [740] = {anchored=true, isMeshPart=false, size=Vector3.new(7.899777412414551,0.05000000074505806,0.19989505410194397)},
    [968] = {anchored=true, isMeshPart=false, size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)},
    [678] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [34] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [1310] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [1308] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [1298] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [1206] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,1.4845397472381592,1.4515492916107178)},
    [722] = {anchored=true, isMeshPart=false, size=Vector3.new(24.249797821044922,0.15000000596046448,2.799894094467163)},
    [496] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [738] = {anchored=true, isMeshPart=false, size=Vector3.new(8.29978084564209,0.1999700963497162,0.15000000596046448)},
    [214] = {anchored=true, isMeshPart=false, size=Vector3.new(1,1,1)},
    [943] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [1293] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [992] = {anchored=true, isMeshPart=false, size=Vector3.new(24.199798583984375,0.05000000074505806,1.3998939990997314)},
    [1282] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [1283] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [724] = {anchored=true, isMeshPart=false, size=Vector3.new(2.400000810623169,1.549999475479126,1.899999737739563)},
    [687] = {anchored=true, isMeshPart=false, size=Vector3.new(40.100006103515625,0.30000004172325134,39.20000457763672)},
    [674] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [1265] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [971] = {anchored=true, isMeshPart=false, size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)},
    [1252] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [1248] = {anchored=true, isMeshPart=false, size=Vector3.new(3.8925414085388184,3.4741146564483643,3.028538703918457)},
    [1242] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [1237] = {anchored=true, isMeshPart=false, size=Vector3.new(1.6167373657226562,1.3195496797561646,1.6536812782287598)},
    [1236] = {anchored=true, isMeshPart=false, size=Vector3.new(0.44999998807907104,3.8000006675720215,8.300000190734863)},
    [1234] = {anchored=true, isMeshPart=false, size=Vector3.new(2.200038433074951,29.767112731933594,2.199962615966797)},
    [854] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [1232] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,9.149999618530273,4)},
    [660] = {anchored=true, isMeshPart=false, size=Vector3.new(0.599822998046875,20.199966430664062,66.99989318847656)},
    [1099] = {anchored=true, isMeshPart=false, size=Vector3.new(55.10002517700195,3.799999952316284,0.10000000149011612)},
    [679] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [1228] = {anchored=true, isMeshPart=false, size=Vector3.new(2.200038433074951,83.46710205078125,2.199962615966797)},
    [1227] = {anchored=true, isMeshPart=false, size=Vector3.new(34,21,2)},
    [764] = {anchored=true, isMeshPart=false, size=Vector3.new(9.199799537658691,11.149971961975098,0.9998931884765625)},
    [456] = {anchored=true, isMeshPart=false, size=Vector3.new(2.364640951156616,5.493091106414795,5.104769706726074)},
    [1220] = {anchored=true, isMeshPart=false, size=Vector3.new(0.29999905824661255,9.000004768371582,35.20002746582031)},
    [467] = {anchored=true, isMeshPart=false, size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)},
    [932] = {anchored=true, isMeshPart=false, size=Vector3.new(3.7999985218048096,3.100001096725464,0.10000000149011612)},
    [1219] = {anchored=true, isMeshPart=false, size=Vector3.new(2,2,2)},
    [1217] = {anchored=true, isMeshPart=false, size=Vector3.new(3.8925414085388184,3.4741146564483643,3.028538703918457)},
    [194] = {anchored=true, isMeshPart=false, size=Vector3.new(6.943293571472168,0.2579691708087921,3.323143482208252)},
    [744] = {anchored=true, isMeshPart=false, size=Vector3.new(0.19978094100952148,1.5999690294265747,1.4998950958251953)},
    [472] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [877] = {anchored=true, isMeshPart=false, size=Vector3.new(5.599987030029297,34.19999694824219,38)},
    [1208] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,9.149999618530273,4)},
    [50] = {anchored=true, isMeshPart=false, size=Vector3.new(2,1,1)},
    [773] = {anchored=true, isMeshPart=false, size=Vector3.new(23.149789810180664,0.49997109174728394,1.9998939037322998)},
    [1080] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [830] = {anchored=true, isMeshPart=false, size=Vector3.new(27.99998664855957,13.199996948242188,30.19999885559082)},
    [1108] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [1207] = {anchored=true, isMeshPart=false, size=Vector3.new(3.4865970611572266,0.2845395505428314,0.25)},
    [981] = {anchored=true, isMeshPart=false, size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)},
    [588] = {anchored=true, isMeshPart=false, size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)},
    [1205] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,3.88454008102417,3.8515496253967285)},
    [1314] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,3.88454008102417,3.8515496253967285)},
    [841] = {anchored=true, isMeshPart=false, size=Vector3.new(4.399798393249512,11.149971961975098,0.9998931884765625)},
    [715] = {anchored=true, isMeshPart=false, size=Vector3.new(0.599822998046875,10.999968528747559,4.299890518188477)},
    [802] = {anchored=true, isMeshPart=false, size=Vector3.new(40.400001525878906,0.30000004172325134,39.400001525878906)},
    [856] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [1057] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [433] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [1128] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [853] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [1146] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [202] = {anchored=true, isMeshPart=false, size=Vector3.new(0.40000224113464355,1,0.20000000298023224)},
    [122] = {anchored=true, isMeshPart=false, size=Vector3.new(2.4444451332092285,4.888890266418457,2.4444451332092285)},
    [1190] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [546] = {anchored=true, isMeshPart=false, size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)},
    [1186] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [698] = {anchored=true, isMeshPart=false, size=Vector3.new(5.599987030029297,13.199996948242188,38)},
    [640] = {anchored=true, isMeshPart=false, size=Vector3.new(5.100012302398682,3.799999952316284,0.10000000149011612)},
    [848] = {anchored=true, isMeshPart=false, size=Vector3.new(2.7997984886169434,2.349971055984497,0.10000000149011612)},
    [1176] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [556] = {anchored=true, isMeshPart=false, size=Vector3.new(0.09999983012676239,3.100001096725464,15.100003242492676)},
    [1175] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [791] = {anchored=true, isMeshPart=false, size=Vector3.new(84.59982299804688,20.199966430664062,0.9998931884765625)},
    [882] = {anchored=true, isMeshPart=false, size=Vector3.new(4.399798393249512,11.149971961975098,0.9998931884765625)},
    [836] = {anchored=true, isMeshPart=false, size=Vector3.new(0.599822998046875,20.199966430664062,22.999895095825195)},
    [1173] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [752] = {anchored=true, isMeshPart=false, size=Vector3.new(0.09980656951665878,3.599970817565918,0.10000000894069672)},
    [811] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [807] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [489] = {anchored=true, isMeshPart=false, size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)},
    [935] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [1160] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [527] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [1156] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [734] = {anchored=true, isMeshPart=false, size=Vector3.new(8.24978256225586,0.10000000149011612,2.299893856048584)},
    [506] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [995] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,2.4999709129333496,1.3998939990997314)},
    [104] = {anchored=true, isMeshPart=false, size=Vector3.new(4.888890266418457,4.888890266418457,2.4444451332092285)},
    [823] = {anchored=true, isMeshPart=false, size=Vector3.new(2.7997984886169434,2.349971055984497,0.10000000149011612)},
    [1138] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [1127] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [821] = {anchored=true, isMeshPart=false, size=Vector3.new(1.89979887008667,0.15000000596046448,0.05000000074505806)},
    [1125] = {anchored=true, isMeshPart=false, size=Vector3.new(3.4865970611572266,0.2845395505428314,0.25)},
    [1015] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,3.88454008102417,3.8515496253967285)},
    [799] = {anchored=true, isMeshPart=false, size=Vector3.new(17.599803924560547,11.099964141845703,0.05000000074505806)},
    [747] = {anchored=true, isMeshPart=false, size=Vector3.new(0.19978031516075134,1.7499700784683228,0.4498937129974365)},
    [1046] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [185] = {anchored=true, isMeshPart=false, size=Vector3.new(0.9293955564498901,0.4176662266254425,0.07585346698760986)},
    [1121] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [363] = {anchored=true, isMeshPart=false, size=Vector3.new(2,1,1)},
    [857] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [43] = {anchored=true, isMeshPart=false, size=Vector3.new(1.9700002670288086,1.809999942779541,1.4099998474121094)},
    [288] = {anchored=true, isMeshPart=false, size=Vector3.new(1,1,1)},
    [902] = {anchored=true, isMeshPart=false, size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)},
    [949] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [1230] = {anchored=true, isMeshPart=false, size=Vector3.new(12.399999618530273,0.05000000074505806,20.399999618530273)},
    [739] = {anchored=true, isMeshPart=false, size=Vector3.new(7.899779796600342,0.1999700963497162,0.05000000074505806)},
    [1097] = {anchored=true, isMeshPart=false, size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)},
    [834] = {anchored=true, isMeshPart=false, size=Vector3.new(53.3997802734375,5.849966526031494,0.9998931884765625)},
    [736] = {anchored=true, isMeshPart=false, size=Vector3.new(0.19978094100952148,1.649970293045044,2.299894332885742)},
    [766] = {anchored=true, isMeshPart=false, size=Vector3.new(3.399801731109619,20.199970245361328,3.3998937606811523)},
    [803] = {anchored=true, isMeshPart=false, size=Vector3.new(0.30000001192092896,11.199997901916504,0.25)},
    [726] = {anchored=true, isMeshPart=false, size=Vector3.new(13.099787712097168,1.099971055984497,3.8998942375183105)},
    [1091] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [795] = {anchored=true, isMeshPart=false, size=Vector3.new(0.44999998807907104,17.39996337890625,9.899884223937988)},
    [548] = {anchored=true, isMeshPart=false, size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)},
    [1078] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,3.88454008102417,3.8515496253967285)},
    [721] = {anchored=true, isMeshPart=false, size=Vector3.new(11.949799537658691,0.15000000596046448,2.799894094467163)},
    [119] = {anchored=true, isMeshPart=false, size=Vector3.new(2.4444451332092285,4.888890266418457,2.4444451332092285)},
    [611] = {anchored=true, isMeshPart=false, size=Vector3.new(9,5.600000381469727,3.799999952316284)},
    [530] = {anchored=true, isMeshPart=false, size=Vector3.new(12.399999618530273,0.05000000074505806,20.399999618530273)},
    [1278] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [756] = {anchored=true, isMeshPart=false, size=Vector3.new(25.99998664855957,0.7999961972236633,9.60000228881836)},
    [947] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [508] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [85] = {anchored=true, isMeshPart=false, size=Vector3.new(1,0.899999737739563,1)},
    [163] = {anchored=true, isMeshPart=false, size=Vector3.new(1.4410820007324219,1.4410820007324219,1.4410820007324219)},
    [746] = {anchored=true, isMeshPart=false, size=Vector3.new(7.899781227111816,1.5999703407287598,0.19989356398582458)},
    [1072] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [622] = {anchored=true, isMeshPart=false, size=Vector3.new(5.000012397766113,3.799999952316284,0.10000000149011612)},
    [175] = {anchored=true, isMeshPart=false, size=Vector3.new(1.4410820007324219,1.4410820007324219,1.4410820007324219)},
    [916] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [1061] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [1034] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [810] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [565] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [920] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [870] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [1124] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,3.88454008102417,3.8515496253967285)},
    [580] = {anchored=true, isMeshPart=false, size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)},
    [261] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [779] = {anchored=true, isMeshPart=false, size=Vector3.new(0.4498048424720764,4.699972152709961,3.9498939514160156)},
    [876] = {anchored=true, isMeshPart=false, size=Vector3.new(84.99982452392578,0.05000000074505806,65.59991455078125)},
    [1032] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [858] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [617] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,1.2000001668930054,3.9000000953674316)},
    [1020] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [266] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [1019] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [1016] = {anchored=true, isMeshPart=false, size=Vector3.new(3.4865970611572266,0.2845395505428314,0.25)},
    [158] = {anchored=true, isMeshPart=false, size=Vector3.new(2.4444451332092285,4.888890266418457,2.4444451332092285)},
    [845] = {anchored=true, isMeshPart=false, size=Vector3.new(2.7997984886169434,0.15000000596046448,0.10000000894069672)},
    [731] = {anchored=true, isMeshPart=false, size=Vector3.new(7.899777412414551,0.05000000074505806,0.19989505410194397)},
    [1011] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [1000] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [996] = {anchored=true, isMeshPart=false, size=Vector3.new(24.199798583984375,0.09997077286243439,1.3998939990997314)},
    [884] = {anchored=true, isMeshPart=false, size=Vector3.new(11.899798393249512,0.05000000074505806,4.249894618988037)},
    [1141] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,1.1999990940093994,1.2000004053115845)},
    [958] = {anchored=true, isMeshPart=false, size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)},
    [911] = {anchored=true, isMeshPart=false, size=Vector3.new(3.599998950958252,2.600001335144043,14.900002479553223)},
    [511] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,3.88454008102417,3.8515496253967285)},
    [994] = {anchored=true, isMeshPart=false, size=Vector3.new(24.199798583984375,0.05000000074505806,1.3998939990997314)},
    [993] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,2.4999709129333496,1.3998939990997314)},
    [1074] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [991] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,2.4999709129333496,1.3998939990997314)},
    [844] = {anchored=true, isMeshPart=false, size=Vector3.new(2.7997984886169434,0.15000000596046448,0.05000000074505806)},
    [990] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,2.4999709129333496,1.3998939990997314)},
    [987] = {anchored=true, isMeshPart=false, size=Vector3.new(20.39999771118164,0.05000000074505806,12.399998664855957)},
    [985] = {anchored=true, isMeshPart=false, size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)},
    [964] = {anchored=true, isMeshPart=false, size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)},
    [975] = {anchored=true, isMeshPart=false, size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)},
    [192] = {anchored=true, isMeshPart=false, size=Vector3.new(0.2574584484100342,0.2579691708087921,2.2051637172698975)},
    [973] = {anchored=true, isMeshPart=false, size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)},
    [1253] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [310] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [809] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [780] = {anchored=true, isMeshPart=false, size=Vector3.new(8.299806594848633,13.999968528747559,0.05000000074505806)},
    [595] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [200] = {anchored=true, isMeshPart=false, size=Vector3.new(1.2000024318695068,0.20000000298023224,0.20000000298023224)},
    [966] = {anchored=true, isMeshPart=false, size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)},
    [429] = {anchored=true, isMeshPart=false, size=Vector3.new(2,2,1)},
    [776] = {anchored=true, isMeshPart=false, size=Vector3.new(0.09980656951665878,3.599970817565918,0.10000000894069672)},
    [515] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [461] = {anchored=true, isMeshPart=false, size=Vector3.new(9,5.600000381469727,3.799999952316284)},
    [983] = {anchored=true, isMeshPart=false, size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)},
    [669] = {anchored=true, isMeshPart=false, size=Vector3.new(2.799802780151367,0.15000000596046448,2.799894094467163)},
    [786] = {anchored=true, isMeshPart=false, size=Vector3.new(2.8498008251190186,2.7499706745147705,2.3998937606811523)},
    [960] = {anchored=true, isMeshPart=false, size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)},
    [956] = {anchored=true, isMeshPart=false, size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)},
    [72] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [926] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [514] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [790] = {anchored=true, isMeshPart=false, size=Vector3.new(0.4998062551021576,13.999968528747559,0.44999998807907104)},
    [703] = {anchored=true, isMeshPart=false, size=Vector3.new(0.09980656951665878,3.599970817565918,0.10000000894069672)},
    [954] = {anchored=true, isMeshPart=false, size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)},
    [714] = {anchored=true, isMeshPart=false, size=Vector3.new(3.4998016357421875,20.199970245361328,0.15000000596046448)},
    [605] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [436] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [945] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [204] = {anchored=true, isMeshPart=false, size=Vector3.new(2,0.3323638439178467,2)},
    [941] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [525] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [939] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [414] = {anchored=true, isMeshPart=false, size=Vector3.new(2,2,1)},
    [77] = {anchored=true, isMeshPart=false, size=Vector3.new(1,1,1)},
    [664] = {anchored=true, isMeshPart=false, size=Vector3.new(39.44981002807617,0.30000001192092896,0.25)},
    [1161] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [930] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [670] = {anchored=true, isMeshPart=false, size=Vector3.new(11.899798393249512,0.15000000596046448,4.3998942375183105)},
    [928] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [573] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [924] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [1047] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [307] = {anchored=true, isMeshPart=false, size=Vector3.new(35,18.200000762939453,2)},
    [680] = {anchored=true, isMeshPart=false, size=Vector3.new(8.199806213378906,13.999968528747559,0.05000000074505806)},
    [913] = {anchored=true, isMeshPart=false, size=Vector3.new(0.09999983012676239,3.100001096725464,15.100003242492676)},
    [909] = {anchored=true, isMeshPart=false, size=Vector3.new(3.7999985218048096,3.100001096725464,0.10000000149011612)},
    [906] = {anchored=true, isMeshPart=false, size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)},
    [904] = {anchored=true, isMeshPart=false, size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)},
    [900] = {anchored=true, isMeshPart=false, size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)},
    [453] = {anchored=true, isMeshPart=false, size=Vector3.new(4,1,2)},
    [894] = {anchored=true, isMeshPart=false, size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)},
    [890] = {anchored=true, isMeshPart=false, size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)},
    [634] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [886] = {anchored=true, isMeshPart=false, size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)},
    [463] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,1.2000001668930054,3.9000000953674316)},
    [1042] = {anchored=true, isMeshPart=false, size=Vector3.new(2.200038433074951,29.767112731933594,2.199962615966797)},
    [196] = {anchored=true, isMeshPart=false, size=Vector3.new(2.4000024795532227,0.20000000298023224,1.399998664855957)},
    [847] = {anchored=true, isMeshPart=false, size=Vector3.new(1.89979887008667,0.15000000596046448,0.05000000074505806)},
    [567] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [554] = {anchored=true, isMeshPart=false, size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)},
    [487] = {anchored=true, isMeshPart=false, size=Vector3.new(3.8925414085388184,3.4741146564483643,3.028538703918457)},
    [697] = {anchored=true, isMeshPart=false, size=Vector3.new(3.74980092048645,0.05000000074505806,2.3998937606811523)},
    [187] = {anchored=true, isMeshPart=false, size=Vector3.new(3.503390073776245,3.606159210205078,3.151639461517334)},
    [937] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [872] = {anchored=true, isMeshPart=false, size=Vector3.new(0.599822998046875,20.199966430664062,13.499890327453613)},
    [867] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [720] = {anchored=true, isMeshPart=false, size=Vector3.new(0.09980656951665878,3.599970817565918,0.10000000894069672)},
    [592] = {anchored=true, isMeshPart=false, size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)},
    [813] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [355] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [828] = {anchored=true, isMeshPart=false, size=Vector3.new(23.199798583984375,1.099971055984497,2.3998937606811523)},
    [370] = {anchored=true, isMeshPart=false, size=Vector3.new(2,2,1)},
    [528] = {anchored=true, isMeshPart=false, size=Vector3.new(20.39999771118164,0.05000000074505806,12.399998664855957)},
    [481] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [677] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [1328] = {anchored=true, isMeshPart=false, size=Vector3.new(512,20,512)},
    [1313] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,1.4845397472381592,1.4515492916107178)},
    [859] = {anchored=true, isMeshPart=false, size=Vector3.new(3.0998222827911377,20.199966430664062,30.09990119934082)},
    [1030] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [1119] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [850] = {anchored=true, isMeshPart=false, size=Vector3.new(0.4498048424720764,4.699972152709961,3.9498939514160156)},
    [1095] = {anchored=true, isMeshPart=false, size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)},
    [57] = {anchored=true, isMeshPart=false, size=Vector3.new(2,2,1)},
    [40] = {anchored=true, isMeshPart=false, size=Vector3.new(1,0.800000011920929,1)},
    [1211] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [827] = {anchored=true, isMeshPart=false, size=Vector3.new(65.49999237060547,22.19999885559082,83.24991607666016)},
    [563] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [91] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [896] = {anchored=true, isMeshPart=false, size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)},
    [705] = {anchored=true, isMeshPart=false, size=Vector3.new(0.599822998046875,20.0999813079834,23.59990882873535)},
    [825] = {anchored=true, isMeshPart=false, size=Vector3.new(83.84977722167969,0.10000000149011612,65.59986114501953)},
    [1140] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [599] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [951] = {anchored=true, isMeshPart=false, size=Vector3.new(0.10000000149011612,3.100001096725464,15.100003242492676)},
    [465] = {anchored=true, isMeshPart=false, size=Vector3.new(1.6167373657226562,1.3195496797561646,1.6536812782287598)},
    [322] = {anchored=true, isMeshPart=false, size=Vector3.new(2,2,1)},
    [586] = {anchored=true, isMeshPart=false, size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)},
    [510] = {anchored=true, isMeshPart=false, size=Vector3.new(3.4865970611572266,0.2845395505428314,0.25)},
    [438] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [760] = {anchored=true, isMeshPart=false, size=Vector3.new(27.99998664855957,7.299996376037598,0.8999975323677063)},
    [171] = {anchored=true, isMeshPart=false, size=Vector3.new(1.4410820007324219,1.4410820007324219,1.4410820007324219)},
    [544] = {anchored=true, isMeshPart=false, size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)},
    [571] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [584] = {anchored=true, isMeshPart=false, size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)},
    [352] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [469] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,2,0.800000011920929)},
    [242] = {anchored=true, isMeshPart=false, size=Vector3.new(2,2,1)},
    [180] = {anchored=true, isMeshPart=false, size=Vector3.new(2.7130355834960938,4.265405178070068,1.8006649017333984)},
    [819] = {anchored=true, isMeshPart=false, size=Vector3.new(2.7997984886169434,0.15000000596046448,0.10000000894069672)},
    [97] = {anchored=true, isMeshPart=false, size=Vector3.new(4.888890266418457,2.4444451332092285,2.4444451332092285)},
    [459] = {anchored=true, isMeshPart=false, size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)},
    [348] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [875] = {anchored=true, isMeshPart=false, size=Vector3.new(0.4998062551021576,13.999968528747559,0.44999998807907104)},
    [735] = {anchored=true, isMeshPart=false, size=Vector3.new(0.19978094100952148,1.5999690294265747,1.4998950958251953)},
    [491] = {anchored=true, isMeshPart=false, size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)},
    [360] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [817] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,0.15000000596046448,0.4500000476837158)},
    [814] = {anchored=true, isMeshPart=false, size=Vector3.new(37.59980773925781,4.699972152709961,0.3998934030532837)},
    [590] = {anchored=true, isMeshPart=false, size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)},
    [753] = {anchored=true, isMeshPart=false, size=Vector3.new(17.599803924560547,11.099964141845703,0.05000000074505806)},
    [1171] = {anchored=true, isMeshPart=false, size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)},
    [615] = {anchored=true, isMeshPart=false, size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)},
    [32] = {anchored=true, isMeshPart=false, size=Vector3.new(1,1.899999976158142,1)},
    [808] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [647] = {anchored=true, isMeshPart=false, size=Vector3.new(5.000012397766113,3.799999952316284,0.10000000149011612)},
    [16] = {anchored=true, isMeshPart=false, size=Vector3.new(2,1.6999999284744263,1)},
    [729] = {anchored=true, isMeshPart=false, size=Vector3.new(7.899782180786133,1.7499700784683228,0.05000000074505806)},
    [445] = {anchored=true, isMeshPart=false, size=Vector3.new(1,1,1)},
    [632] = {anchored=true, isMeshPart=false, size=Vector3.new(3.8925414085388184,3.4741146564483643,3.028538703918457)},
    [741] = {anchored=true, isMeshPart=false, size=Vector3.new(7.899777412414551,0.10000000149011612,1.4998950958251953)},
    [385] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [655] = {anchored=true, isMeshPart=false, size=Vector3.new(0.30000001192092896,11.199997901916504,0.25)},
    [193] = {anchored=true, isMeshPart=false, size=Vector3.new(0.2574584484100342,0.2579691708087921,2.197343587875366)},
    [774] = {anchored=true, isMeshPart=false, size=Vector3.new(3.899998664855957,1.0999999046325684,1.350000262260437)},
    [629] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,9.149999618530273,4)},
    [688] = {anchored=true, isMeshPart=false, size=Vector3.new(47.79981994628906,6.899966239929199,1.9998958110809326)},
    [962] = {anchored=true, isMeshPart=false, size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)},
    [777] = {anchored=true, isMeshPart=false, size=Vector3.new(6.149801254272461,0.15000000596046448,4.3998942375183105)},
    [822] = {anchored=true, isMeshPart=false, size=Vector3.new(2.7997984886169434,0.15000000596046448,0.05000000074505806)},
    [829] = {anchored=true, isMeshPart=false, size=Vector3.new(3.399801731109619,20.39997100830078,3.3998937606811523)},
    [768] = {anchored=true, isMeshPart=false, size=Vector3.new(3.4998016357421875,20.199970245361328,0.15000000596046448)},
    [668] = {anchored=true, isMeshPart=false, size=Vector3.new(10.349809646606445,3.699967384338379,0.05000000074505806)},
    [866] = {anchored=true, isMeshPart=false, size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)},
    [778] = {anchored=true, isMeshPart=false, size=Vector3.new(10.599793434143066,2.099971294403076,2.3998939990997314)},
    [578] = {anchored=true, isMeshPart=false, size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)},
    [1093] = {anchored=true, isMeshPart=false, size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)},
    [1225] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,1.1999990940093994,1.2000004053115845)},
    [9] = {anchored=true, isMeshPart=false, size=Vector3.new(2,1,1)},
    [550] = {anchored=true, isMeshPart=false, size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)},
    [271] = {anchored=true, isMeshPart=false, size=Vector3.new(1,0.800000011920929,1)},
    [743] = {anchored=true, isMeshPart=false, size=Vector3.new(0.19978031516075134,1.7499700784683228,0.4498937129974365)},
    [787] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,0.15000000596046448,0.4500000476837158)},
    [737] = {anchored=true, isMeshPart=false, size=Vector3.new(7.899777412414551,0.10000000149011612,1.4998950958251953)},
    [888] = {anchored=true, isMeshPart=false, size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)},
    [296] = {anchored=true, isMeshPart=false, size=Vector3.new(4.888890266418457,4.888890266418457,2.4444451332092285)},
    [542] = {anchored=true, isMeshPart=false, size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)},
    [552] = {anchored=true, isMeshPart=false, size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)},
    [1267] = {anchored=true, isMeshPart=false, size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)},
    [559] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [1268] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [537] = {anchored=true, isMeshPart=false, size=Vector3.new(3.7999985218048096,3.100001096725464,0.10000000149011612)},
    [704] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,0.15000000596046448,0.4500000476837158)},
    [710] = {anchored=true, isMeshPart=false, size=Vector3.new(24.199798583984375,2.4999709129333496,2.3998939990997314)},
    [1191] = {anchored=true, isMeshPart=false, size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)},
    [712] = {anchored=true, isMeshPart=false, size=Vector3.new(53.39982604980469,3.249966621398926,0.9998931884765625)},
    [533] = {anchored=true, isMeshPart=false, size=Vector3.new(3.7999985218048096,3.100001096725464,0.10000000149011612)},
    [535] = {anchored=true, isMeshPart=false, size=Vector3.new(3.599998950958252,2.600001335144043,14.900002479553223)},
    [918] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [37] = {anchored=true, isMeshPart=false, size=Vector3.new(1,2,1)},
    [74] = {anchored=true, isMeshPart=false, size=Vector3.new(1,0.9999998807907104,1)},
    [666] = {anchored=true, isMeshPart=false, size=Vector3.new(86.19982147216797,2.399996280670166,65.59991455078125)},
    [601] = {anchored=true, isMeshPart=false, size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)},
    [613] = {anchored=true, isMeshPart=false, size=Vector3.new(0.05000000074505806,2,0.800000011920929)},
    [387] = {anchored=true, isMeshPart=false, size=Vector3.new(1,1,1)},
    [862] = {anchored=true, isMeshPart=false, size=Vector3.new(4.399798393249512,2.099970817565918,3.649892807006836)},
    [693] = {anchored=true, isMeshPart=false, size=Vector3.new(0.44999998807907104,17.39996337890625,9.899884223937988)},
    [167] = {anchored=true, isMeshPart=false, size=Vector3.new(1.4410820007324219,1.4410820007324219,1.4410820007324219)},
    [191] = {anchored=true, isMeshPart=false, size=Vector3.new(0.2574584484100342,0.2579691708087921,2.2013368606567383)},
}
local partDefs = {
    [6] = {shape="Normal", cframe=CFrame.new(14.632862091064453,23.58579444885254,-26.407386779785156,0.017408907413482666,-0.9992384314537048,-0.034920841455459595,0.000010967254638671875,0.03492629528045654,-0.9993898868560791,0.999848484992981,0.017397910356521606,0.0006189942359924316)},
    [673] = {shape="Normal", cframe=CFrame.new(12.016602516174316,38.524986267089844,-5.09592342376709,0,0,1,0,1,-0,-1,0,0)},
    [815] = {shape="Normal", cframe=CFrame.new(24.466463088989258,38.599971771240234,10.279043197631836,-1,0,0,0,1,0,0,0,-1)},
    [685] = {shape="Normal", cframe=CFrame.new(30.766536712646484,21.424962997436523,-23.845909118652344,-1,0,0,0,1,0,0,0,-1)},
    [561] = {shape="Normal", cframe=CFrame.new(-31.711977005004883,24.399677276611328,-2.824340343475342,0,0,-1,0,1,0,1,0,0)},
    [892] = {shape="Normal", cframe=CFrame.new(-15.420741081237793,36.7498893737793,20.33155632019043,0,0,1,0,1,-0,-1,0,0)},
    [725] = {shape="Normal", cframe=CFrame.new(20.016422271728516,39.32497024536133,6.004051208496094,-1,0,0,0,1,0,0,0,-1)},
    [41] = {shape="Normal", cframe=CFrame.new(9.573195457458496,24.810508728027344,9.680206298828125,0,0,-1,0,1,0,1,0,0)},
    [675] = {shape="Normal", cframe=CFrame.new(9.216584205627441,38.524986267089844,-5.095922470092773,-0.08713150024414062,0,0.9961968660354614,0,1,0,-0.9961968660354614,0,-0.08713150024414062)},
    [357] = {shape="Normal", cframe=CFrame.new(15.525481224060059,23.168270111083984,11.019268035888672,0.9997405409812927,-0.004577893763780594,0.02231261134147644,0.022580863907933235,0.07079213857650757,-0.9972354769706726,0.002985680475831032,0.997480571269989,0.07087713479995728)},
    [871] = {shape="Normal", cframe=CFrame.new(40.066314697265625,38.524986267089844,-5.0959272384643555,0.08713138103485107,0,0.9961968660354614,0,1,0,-0.9961968660354614,0,0.08713138103485107)},
    [124] = {shape="Normal", cframe=CFrame.new(-10.134142875671387,31.51456069946289,21.783977508544922,0,0,-1,0,1,0,1,0,0)},
    [1201] = {shape="Normal", cframe=CFrame.new(33.29180908203125,23.369945526123047,-13.532358169555664,0,0,1,0,1,-0,-1,0,0)},
    [182] = {shape="Normal", cframe=CFrame.new(51.09613037109375,22.019956588745117,28.548274993896484,0.01253443956375122,0,0.9999213814735413,0,1,0,-0.9999213814735413,0,0.01253443956375122)},
    [320] = {shape="Normal", cframe=CFrame.new(25.166006088256836,20.98749351501465,10.295793533325195,1,-0,0,0,0.999847948551178,0.01743638701736927,-0,-0.01743638701736927,0.999847948551178)},
    [855] = {shape="Normal", cframe=CFrame.new(-11.433432579040527,38.524986267089844,-5.095919609069824,0,0,1,0,1,-0,-1,0,0)},
    [1188] = {shape="Cylinder", cframe=CFrame.new(33.29217529296875,20.10289192199707,-7.088968276977539,0,0,-1,-1,0,0,0,1,0)},
    [762] = {shape="Normal", cframe=CFrame.new(-10.083824157714844,55.349971771240234,-12.996212005615234,-1,0,0,0,1,0,0,0,-1)},
    [597] = {shape="Normal", cframe=CFrame.new(-31.750673294067383,24.399688720703125,-10.430908203125,-0.7071342468261719,0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,-0.0001264711027033627,0.707079291343689,-0.00019253601203672588,-0.7071342468261719)},
    [184] = {shape="Seat", cframe=CFrame.new(51.216064453125,21.800004959106445,28.100032806396484,0,0,-1,0,1,0,1,0,0)},
    [804] = {shape="Normal", cframe=CFrame.new(-9.633424758911133,30.049976348876953,-23.696046829223633,-1,0,0,0,1,0,0,0,-1)},
    [402] = {shape="Normal", cframe=CFrame.new(21.5659122467041,25.33546257019043,-27.9097957611084,0,0,1,0,1,0,-1,0,0)},
    [569] = {shape="Normal", cframe=CFrame.new(-31.844118118286133,24.399696350097656,-2.6922144889831543,1,0,0,0,1,0,0,0,1)},
    [582] = {shape="Normal", cframe=CFrame.new(-31.914827346801758,23.949661254882812,-6.99505615234375,-0.7071342468261719,0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,-0.0001264711027033627,0.707079291343689,-0.00019253601203672588,-0.7071342468261719)},
    [512] = {shape="Cylinder", cframe=CFrame.new(-1.0911253690719604,20.093191146850586,-10.345340728759766,-7.152557373046875e-07,-0.004919648170471191,-0.9999878406524658,-1,7.152557373046875e-07,6.854534149169922e-07,6.854534149169922e-07,0.9999878406524658,-0.004919648170471191)},
    [279] = {shape="Normal", cframe=CFrame.new(9.573195457458496,24.810508728027344,9.680206298828125,0,0,-1,0,1,0,1,0,0)},
    [742] = {shape="Normal", cframe=CFrame.new(-17.20949935913086,20.84995460510254,11.64503288269043,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [748] = {shape="Normal", cframe=CFrame.new(57.541534423828125,30.049962997436523,24.303987503051758,-1,0,0,0,1,0,0,0,-1)},
    [478] = {shape="Normal", cframe=CFrame.new(13.926362991333008,21.826942443847656,1.6146936416625977,0.9999879002571106,-0,-0.004920339677482843,0,1,-0,0.004920339677482843,0,0.9999879002571106)},
    [767] = {shape="Normal", cframe=CFrame.new(-7.433473587036133,24.899965286254883,-23.696046829223633,-1,0,0,0,1,0,0,0,-1)},
    [607] = {shape="Normal", cframe=CFrame.new(-31.711977005004883,24.399677276611328,-10.524322509765625,0,0,-1,0,1,0,1,0,0)},
    [979] = {shape="Normal", cframe=CFrame.new(-31.773406982421875,23.949670791625977,-24.295059204101562,0.7071342468261719,-0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,0.0001264711027033627,0.707079291343689,-0.00019253601203672588,0.7071342468261719)},
    [788] = {shape="Normal", cframe=CFrame.new(-8.0734224319458,22.399965286254883,16.919981002807617,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [1123] = {shape="Cylinder", cframe=CFrame.new(47.64797592163086,19.99317741394043,-27.855876922607422,0.000005900859832763672,-0.9999881982803345,0.004883096553385258,-1.0000001192092896,-0.000006079673767089844,1.4668330550193787e-08,1.4668330550193787e-08,-0.004883096553385258,-0.999988317489624)},
    [575] = {shape="Normal", cframe=CFrame.new(-30.134035110473633,21.500015258789062,-4.863567352294922,1,0,0,0,1,0,0,0,1)},
    [782] = {shape="Normal", cframe=CFrame.new(57.541534423828125,30.049962997436523,10.303987503051758,-1,0,0,0,1,0,0,0,-1)},
    [1081] = {shape="Seat", cframe=CFrame.new(46.86492919921875,21.852237701416016,-19.472240447998047,0,0,1,0,1,-0,-1,0,0)},
    [1062] = {shape="Seat", cframe=CFrame.new(43.99941635131836,21.852237701416016,-16.515514373779297,1,0,0,0,1,0,0,0,1)},
    [1017] = {shape="Cylinder", cframe=CFrame.new(17.748287200927734,19.99319076538086,-28.000709533691406,0.000005900859832763672,-0.9999881982803345,0.004883096553385258,-1.0000001192092896,-0.000006079673767089844,1.4668330550193787e-08,1.4668330550193787e-08,-0.004883096553385258,-0.999988317489624)},
    [868] = {shape="Normal", cframe=CFrame.new(42.96630859375,38.524986267089844,-5.095928192138672,0,0,1,0,1,-0,-1,0,0)},
    [1145] = {shape="Cylinder", cframe=CFrame.new(30.154329299926758,20.10289192199707,-10.226144790649414,0,-1,-0,-1,0,-0,0,0,-1)},
    [1263] = {shape="Normal", cframe=CFrame.new(11.64208984375,23.369951248168945,-13.637275695800781,0,0,1,0,1,-0,-1,0,0)},
    [94] = {shape="Normal", cframe=CFrame.new(-6.4673261642456055,27.333330154418945,22.500032424926758,1,0,0,0,1,0,0,0,1)},
    [1239] = {shape="Normal", cframe=CFrame.new(25.378480911254883,40.07529830932617,-4.968541145324707,1,0,0,0,-1,0,0,0,-1)},
    [676] = {shape="Normal", cframe=CFrame.new(14.66644287109375,38.524986267089844,-5.09592342376709,0.08713138103485107,0,0.9961968660354614,0,1,0,-0.9961968660354614,0,0.08713138103485107)},
    [609] = {shape="Normal", cframe=CFrame.new(-31.844118118286133,24.399696350097656,-10.392196655273438,1,0,0,0,1,0,0,0,1)},
    [1001] = {shape="Seat", cframe=CFrame.new(14.883024215698242,21.752246856689453,-28.05152130126953,0,0,-1,0,1,0,1,0,0)},
    [1315] = {shape="Normal", cframe=CFrame.new(31.683385848999023,20.64988899230957,23.567068099975586,-0.0015864372253417969,0,-0.9999987483024597,0,1,0,0.9999987483024597,0,-0.0015864372253417969)},
    [656] = {shape="Normal", cframe=CFrame.new(57.01641845703125,30.049962997436523,9.303987503051758,-1,0,0,0,1,0,0,0,-1)},
    [495] = {shape="Cylinder", cframe=CFrame.new(-1.1875604391098022,21.157894134521484,-13.528018951416016,0,0,1,-1,0,0,0,-1,0)},
    [997] = {shape="Normal", cframe=CFrame.new(-2.508659839630127,26.049962997436523,37.0540771484375,-1,0,0,0,1,0,0,0,-1)},
    [733] = {shape="Normal", cframe=CFrame.new(-13.827266693115234,22.449962615966797,13.886533737182617,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [540] = {shape="Normal", cframe=CFrame.new(-31.944120407104492,23.94968032836914,0.4756474494934082,0,0,-1,0,1,0,1,0,0)},
    [781] = {shape="Normal", cframe=CFrame.new(6.716214656829834,31.049951553344727,-27.9963436126709,-1,0,0,0,1,0,0,0,-1)},
    [619] = {shape="Normal", cframe=CFrame.new(34.71640396118164,42.6999626159668,16.591909408569336,0,0,1,1,0,0,0,1,0)},
    [264] = {shape="Normal", cframe=CFrame.new(10.07325267791748,21.100006103515625,9.973136901855469,1,0,0,0,1,0,0,0,1)},
    [441] = {shape="Normal", cframe=CFrame.new(20.887496948242188,22.433670043945312,-27.363203048706055,-5.960464477539062e-07,1,5.662441253662109e-07,0.08718785643577576,5.960464477539062e-07,-0.9961918592453003,-0.9961918592453003,-5.662441253662109e-07,-0.0871877670288086)},
    [922] = {shape="Normal", cframe=CFrame.new(-31.8441162109375,24.399696350097656,-19.992218017578125,1,0,0,0,1,0,0,0,1)},
    [1223] = {shape="Normal", cframe=CFrame.new(30.13348960876465,23.549888610839844,23.596092224121094,-0.0015864372253417969,0,-0.9999987483024597,0,1,0,0.9999987483024597,0,-0.0015864372253417969)},
    [769] = {shape="Normal", cframe=CFrame.new(15.016548156738281,30.049962997436523,39.778987884521484,-1,0,0,0,1,0,0,0,-1)},
    [603] = {shape="Normal", cframe=CFrame.new(-31.937562942504883,24.399656295776367,-10.617766380310059,-0.7071342468261719,0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,-0.0001264711027033627,0.707079291343689,-0.00019253601203672588,-0.7071342468261719)},
    [1312] = {shape="Cylinder", cframe=CFrame.new(11.68829345703125,21.843191146850586,-10.427495002746582,-0.000006079673767089844,0.9999881982803345,-0.004883096553385258,-1.0000001192092896,-0.000006079673767089844,1.4668330550193787e-08,-1.4668330550193787e-08,0.004883096553385258,0.9999880790710449)},
    [789] = {shape="Normal", cframe=CFrame.new(-16.341585159301758,24.349964141845703,-28.565933227539062,0.2588643431663513,-0,-0.965913712978363,0,1,-0,0.965913712978363,0,0.2588643431663513)},
    [745] = {shape="Normal", cframe=CFrame.new(-17.8967227935791,24.049957275390625,12.835933685302734,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [812] = {shape="Normal", cframe=CFrame.new(29.316347122192383,38.524986267089844,-5.095926284790039,0,0,1,0,1,-0,-1,0,0)},
    [898] = {shape="Normal", cframe=CFrame.new(25.37925910949707,36.7498893737793,20.33147430419922,0,0,1,0,1,-0,-1,0,0)},
    [732] = {shape="Normal", cframe=CFrame.new(-13.632627487182617,23.989782333374023,13.55001449584961,-0.8660367727279663,-0.12942761182785034,0.48293784260749817,-0.00002991408109664917,0.9659268260002136,0.25881528854370117,-0.49998047947883606,0.2241290956735611,-0.8365319967269897)},
    [391] = {shape="Normal", cframe=CFrame.new(21.5712947845459,25.938457489013672,-27.9097957611084,1,0,0,0,1,0,0,0,1)},
    [681] = {shape="Normal", cframe=CFrame.new(-27.558469772338867,30.049970626831055,17.253997802734375,1,0,0,0,1,0,0,0,1)},
    [309] = {shape="Normal", cframe=CFrame.new(24.66600799560547,25.05243682861328,11.115180015563965,1,0,0,0,0.999847948551178,0.01743638701736927,0,-0.01743638701736927,0.999847948551178)},
    [88] = {shape="Normal", cframe=CFrame.new(-15.618242263793945,23.349994659423828,16.883390426635742,0.8191556930541992,-0,-0.5735712647438049,0,1,-0,0.5735712647438049,0,0.8191556930541992)},
    [1297] = {shape="Cylinder", cframe=CFrame.new(14.77960205078125,20.102893829345703,-10.331062316894531,0,1,-0,-1,0,0,0,0,1)},
    [213] = {shape="Normal", cframe=CFrame.new(9.573195457458496,24.810508728027344,9.680206298828125,0,0,-1,0,1,0,1,0,0)},
    [212] = {shape="Normal", cframe=CFrame.new(9.573256492614746,24.70000648498535,9.973410606384277,1,0,0,0,1,0,0,0,1)},
    [775] = {shape="Normal", cframe=CFrame.new(-15.781648635864258,24.899965286254883,-26.283082962036133,0.2588643431663513,-0,-0.965913712978363,0,1,-0,0.965913712978363,0,0.2588643431663513)},
    [1295] = {shape="Cylinder", cframe=CFrame.new(11.642457962036133,20.102893829345703,-7.193883895874023,0,0,-1,-1,0,0,0,1,0)},
    [728] = {shape="Normal", cframe=CFrame.new(-17.28463363647461,23.174951553344727,11.775005340576172,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [1076] = {shape="Cylinder", cframe=CFrame.new(43.99969482421875,20.093183517456055,-19.523052215576172,-0.000006079673767089844,0.9999881982803345,-0.004883096553385258,-1.0000001192092896,-0.000006079673767089844,1.4668330550193787e-08,-1.4668330550193787e-08,0.004883096553385258,0.9999880790710449)},
    [1109] = {shape="Seat", cframe=CFrame.new(44.782711029052734,21.752235412597656,-27.906688690185547,0,0,-1,0,1,0,1,0,0)},
    [1013] = {shape="Cylinder", cframe=CFrame.new(14.656950950622559,20.002891540527344,-28.097267150878906,0,-1,-0,-1,0,-0,0,0,-1)},
    [1280] = {shape="Cylinder", cframe=CFrame.new(8.504608154296875,20.102893829345703,-10.331060409545898,0,-1,-0,-1,0,-0,0,0,-1)},
    [42] = {shape="Normal", cframe=CFrame.new(9.598288536071777,23.61812973022461,9.80693244934082,1,0,0,0,1,0,0,0,1)},
    [313] = {shape="Normal", cframe=CFrame.new(24.66600799560547,24.504432678222656,11.234480857849121,1,-0,0,0,0.999847948551178,0.01743638701736927,-0,-0.01743638701736927,0.999847948551178)},
    [1059] = {shape="Cylinder", cframe=CFrame.new(40.8170166015625,21.157894134521484,-19.426616668701172,0,-1,-0,-1,0,-0,0,0,-1)},
    [227] = {shape="Normal", cframe=CFrame.new(9.573256492614746,23.100006103515625,9.973138809204102,1,0,0,0,1,0,0,0,1)},
    [833] = {shape="Normal", cframe=CFrame.new(20.01641845703125,39.32497024536133,-16.145973205566406,-1,0,0,0,1,0,0,0,-1)},
    [730] = {shape="Normal", cframe=CFrame.new(-20.252044677734375,22.390005111694336,8.815061569213867,-0.8660367727279663,-0.12942761182785034,0.48293784260749817,-0.00002991408109664917,0.9659268260002136,0.25881528854370117,-0.49998047947883606,0.2241290956735611,-0.8365319967269897)},
    [300] = {shape="Normal", cframe=CFrame.new(-8.351338386535645,23.51556396484375,17.25983238220215,-0.4958075284957886,0,-0.8684327602386475,0,1,0,0.8684327602386475,0,-0.4958075284957886)},
    [190] = {shape="Normal", cframe=CFrame.new(53.53785705566406,21.232677459716797,25.42621421813965,-0.02684164047241211,0.9996397495269775,-0.000002175569534301758,-0.000002175569534301758,-0.0000022649765014648438,-1,-0.9996397495269775,-0.02684161067008972,0.0000021457672119140625)},
    [1040] = {shape="Normal", cframe=CFrame.new(13.874881744384766,21.826942443847656,12.214563369750977,-0.9999878406524658,0,0.004920339677482843,0,1,0,-0.004920339677482843,0,-0.9999878406524658)},
    [338] = {shape="Normal", cframe=CFrame.new(24.66600799560547,25.05243682861328,11.115180015563965,1,0,0,0,0.999847948551178,0.01743638701736927,0,-0.01743638701736927,0.999847948551178)},
    [977] = {shape="Normal", cframe=CFrame.new(-31.773406982421875,23.949689865112305,-24.153640747070312,-0.7071342468261719,0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,-0.0001264711027033627,0.707079291343689,-0.00019253601203672588,-0.7071342468261719)},
    [1331] = {shape="Spawn", cframe=CFrame.new(-13.399999618530273,20.5,-60,1,0,0,0,1,0,0,0,1)},
    [1329] = {shape="Normal", cframe=CFrame.new(4.917679309844971,22.746545791625977,-34.55238342285156,-1,0,0,0,1,0,0,0,-1)},
    [865] = {shape="Normal", cframe=CFrame.new(45.566341400146484,38.524986267089844,-5.095928192138672,-0.08713150024414062,0,0.9961968660354614,0,1,0,-0.9961968660354614,0,-0.08713150024414062)},
    [248] = {shape="Normal", cframe=CFrame.new(9.573256492614746,24.600006103515625,9.973138809204102,1,0,0,0,1,0,0,0,1)},
    [1326] = {shape="Normal", cframe=CFrame.new(-39.900001525878906,24.5,-33,1,0,0,0,1,0,0,0,1)},
    [1077] = {shape="Cylinder", cframe=CFrame.new(43.99969482421875,21.843185424804688,-19.523052215576172,-0.000006079673767089844,0.9999881982803345,-0.004883096553385258,-1.0000001192092896,-0.000006079673767089844,1.4668330550193787e-08,-1.4668330550193787e-08,0.004883096553385258,0.9999880790710449)},
    [1324] = {shape="Normal", cframe=CFrame.new(-15.421748161315918,40.07529067993164,20.331510543823242,1,0,0,0,-1,0,0,0,-1)},
    [1317] = {shape="Normal", cframe=CFrame.new(-7.1841912269592285,44.70004653930664,25.754512786865234,0,0,-1,0,-1,-0,-1,0,-0)},
    [1203] = {shape="Cylinder", cframe=CFrame.new(33.292144775390625,21.157894134521484,-13.362977981567383,0,0,1,-1,0,0,0,-1,0)},
    [245] = {shape="Normal", cframe=CFrame.new(11.073243141174316,23.100006103515625,9.973133087158203,1,0,0,0,1,0,0,0,1)},
    [852] = {shape="Normal", cframe=CFrame.new(-6.033377647399902,38.524986267089844,-5.095920562744141,0,0,1,0,1,-0,-1,0,0)},
    [1158] = {shape="Cylinder", cframe=CFrame.new(30.155336380004883,21.157894134521484,-10.226144790649414,0,-1,-0,-1,0,-0,0,0,-1)},
    [47] = {shape="Normal", cframe=CFrame.new(-13.160791397094727,22.399995803833008,18.604135513305664,0.8191556930541992,-0,-0.5735712647438049,0,1,-0,0.5735712647438049,0,0.8191556930541992)},
    [869] = {shape="Normal", cframe=CFrame.new(51.01620101928711,38.524986267089844,-5.095929145812988,0.08713138103485107,0,0.9961968660354614,0,1,0,-0.9961968660354614,0,0.08713138103485107)},
    [740] = {shape="Normal", cframe=CFrame.new(-17.53460121154785,24.774938583374023,12.208019256591797,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [968] = {shape="Normal", cframe=CFrame.new(-31.944128036499023,23.94968032836914,-16.8243408203125,0,0,-1,0,1,0,1,0,0)},
    [678] = {shape="Normal", cframe=CFrame.new(1.0667132139205933,38.524986267089844,-5.095921516418457,0,0,1,0,1,-0,-1,0,0)},
    [34] = {shape="Normal", cframe=CFrame.new(14.673680305480957,23.591211318969727,-29.408559799194336,0.017462193965911865,-0.9996950626373291,-0.017460227012634277,-0.000040650367736816406,0.017462193965911865,-0.9998475313186646,0.9998475313186646,0.017460227012634277,0.00026428699493408203)},
    [1310] = {shape="Cylinder", cframe=CFrame.new(14.77960205078125,21.157894134521484,-10.331062316894531,0,1,-0,-1,0,0,0,0,1)},
    [1308] = {shape="Normal", cframe=CFrame.new(14.948607444763184,23.369895935058594,-10.331062316894531,1,0,0,0,1,0,0,0,1)},
    [1298] = {shape="Seat", cframe=CFrame.new(14.55352783203125,21.85224151611328,-10.37668514251709,0,0,1,0,1,-0,-1,0,0)},
    [1206] = {shape="Cylinder", cframe=CFrame.new(33.3380126953125,20.093183517456055,-10.322580337524414,-0.000006079673767089844,0.9999881982803345,-0.004883096553385258,-1.0000001192092896,-0.000006079673767089844,1.4668330550193787e-08,-1.4668330550193787e-08,0.004883096553385258,0.9999880790710449)},
    [722] = {shape="Normal", cframe=CFrame.new(-14.608757019042969,22.62494659423828,36.35406494140625,-1,0,0,0,1,0,0,0,-1)},
    [496] = {shape="Seat", cframe=CFrame.new(-1.1851810216903687,21.85224151611328,-13.30203628540039,-1,0,0,0,1,0,0,0,-1)},
    [738] = {shape="Normal", cframe=CFrame.new(-16.547054290771484,21.74995994567871,10.497600555419922,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [214] = {shape="Normal", cframe=CFrame.new(9.598288536071777,23.61812973022461,9.80693244934082,1,0,0,0,1,0,0,0,1)},
    [943] = {shape="Normal", cframe=CFrame.new(-31.937562942504883,24.399694442749023,-27.73089599609375,0.7071342468261719,-0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,0.0001264711027033627,0.707079291343689,-0.00019253601203672588,0.7071342468261719)},
    [1293] = {shape="Normal", cframe=CFrame.new(11.642457962036133,23.369895935058594,-7.024877548217773,0,0,-1,0,1,0,1,0,0)},
    [992] = {shape="Normal", cframe=CFrame.new(-14.583518981933594,27.27495765686035,37.0540771484375,-1,0,0,0,1,0,0,0,-1)},
    [1282] = {shape="Cylinder", cframe=CFrame.new(11.642457962036133,21.157894134521484,-7.193883895874023,0,0,-1,-1,0,0,0,1,0)},
    [1283] = {shape="Seat", cframe=CFrame.new(11.688019752502441,21.85224151611328,-7.419989585876465,1,0,0,0,1,0,0,0,1)},
    [724] = {shape="Wedge", cframe=CFrame.new(-3.4182071685791016,23.024948120117188,19.607540130615234,0.49995946884155273,0,0.8660488128662109,0,1,0,-0.8660488128662109,0,0.49995946884155273)},
    [687] = {shape="Normal", cframe=CFrame.new(-10.083824157714844,55.349971771240234,-12.996212005615234,-1,0,0,0,1,0,0,0,-1)},
    [674] = {shape="Normal", cframe=CFrame.new(16.86651611328125,38.524986267089844,-5.095924377441406,0.08713138103485107,0,0.9961968660354614,0,1,0,-0.9961968660354614,0,0.08713138103485107)},
    [1265] = {shape="Cylinder", cframe=CFrame.new(11.64239501953125,20.102893829345703,-13.4688720703125,0,0,1,-1,0,0,0,-1,0)},
    [971] = {shape="Normal", cframe=CFrame.new(-31.8441162109375,23.949661254882812,-24.3243408203125,1,0,0,0,1,0,0,0,1)},
    [1252] = {shape="Cylinder", cframe=CFrame.new(11.642425537109375,21.157894134521484,-13.467903137207031,0,0,1,-1,0,0,0,-1,0)},
    [1248] = {shape="Normal", cframe=CFrame.new(34.92633056640625,21.826942443847656,1.614689826965332,0.9999879002571106,-0,-0.004920339677482843,0,1,-0,0.004920339677482843,0,0.9999879002571106)},
    [1242] = {shape="Seat", cframe=CFrame.new(34.955047607421875,21.586963653564453,2.2350358963012695,-0.9999878406524658,0,0.004920339677482843,0,1,0,-0.004920339677482843,0,-0.9999878406524658)},
    [1237] = {shape="Normal", cframe=CFrame.new(-5.247340679168701,23.94972038269043,18.58904457092285,0.7660612463951111,-0,-0.642767608165741,0,1,-0,0.642767608165741,0,0.7660612463951111)},
    [1236] = {shape="Normal", cframe=CFrame.new(-16.64718246459961,23.518945693969727,10.77621078491211,0.4829992651939392,0.12941744923591614,-0.8660039901733398,0.2588149607181549,-0.9659268856048584,-4.0978193283081055e-07,-0.8364965915679932,-0.22413456439971924,-0.5000371932983398)},
    [1234] = {shape="Normal", cframe=CFrame.new(48.128604888916016,38.62496566772461,26.981555938720703,0,0,-1,-1,0,0,0,1,0)},
    [854] = {shape="Normal", cframe=CFrame.new(-8.833395957946777,38.524986267089844,-5.095920562744141,-0.08713150024414062,0,0.9961968660354614,0,1,0,-0.9961968660354614,0,-0.08713150024414062)},
    [1232] = {shape="Normal", cframe=CFrame.new(52.53297424316406,24.624897003173828,23.61703872680664,-0.0015864372253417969,0,-0.9999987483024597,0,1,0,0.9999987483024597,0,-0.0015864372253417969)},
    [660] = {shape="Normal", cframe=CFrame.new(-26.98370361328125,30.049976348876953,9.304075241088867,-1,0,0,0,1,0,0,0,-1)},
    [1099] = {shape="Normal", cframe=CFrame.new(29.84481430053711,21.84990882873535,-41.26578140258789,0.9999879002571106,-0,-0.004920339677482843,0,1,-0,0.004920339677482843,0,0.9999879002571106)},
    [679] = {shape="Normal", cframe=CFrame.new(6.616547584533691,38.524986267089844,-5.095922470092773,0,0,1,0,1,-0,-1,0,0)},
    [1228] = {shape="Normal", cframe=CFrame.new(14.928622245788574,38.62496566772461,12.281517028808594,0,-1,-0,-1,0,-0,0,0,-1)},
    [1227] = {shape="Normal", cframe=CFrame.new(-8.857720375061035,33.29995346069336,15.99764633178711,0.8660072684288025,-0,-0.5000314116477966,0,1,-0,0.5000314116477966,0,0.8660072684288025)},
    [764] = {shape="Normal", cframe=CFrame.new(8.516417503356934,28.774965286254883,-23.6959285736084,-1,0,0,0,1,0,0,0,-1)},
    [456] = {shape="Normal", cframe=CFrame.new(-25.082319259643555,22.746545791625977,-34.55238342285156,-1,0,0,0,1,0,0,0,-1)},
    [1220] = {shape="Normal", cframe=CFrame.new(34.716407775878906,42.6999626159668,31.59191131591797,0,0,1,1,0,0,0,1,0)},
    [467] = {shape="Normal", cframe=CFrame.new(-5.9217424392700195,40.07529067993164,20.33150863647461,1,0,0,0,-1,0,0,0,-1)},
    [932] = {shape="Normal", cframe=CFrame.new(-31.9842586517334,21.501222610473633,-14.663482666015625,1,0,0,0,1,0,0,0,1)},
    [1219] = {shape="Normal", cframe=CFrame.new(17.915773391723633,32.599945068359375,8.400934219360352,0,0,-1,0,1,0,1,0,0)},
    [1217] = {shape="Normal", cframe=CFrame.new(34.87485122680664,21.826942443847656,12.214559555053711,-0.9999878406524658,0,0.004920339677482843,0,1,0,-0.004920339677482843,0,-0.9999878406524658)},
    [194] = {shape="Normal", cframe=CFrame.new(54.97509765625,22.446500778198242,28.377399444580078,-0.02679729461669922,0,0.9996408820152283,0,1,0,-0.9996408820152283,0,-0.02679729461669922)},
    [744] = {shape="Normal", cframe=CFrame.new(-21.041961669921875,24.099964141845703,10.183012008666992,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [472] = {shape="Seat", cframe=CFrame.new(13.955080032348633,21.586971282958984,2.235039710998535,-0.9999878406524658,0,0.004920339677482843,0,1,0,-0.004920339677482843,0,-0.9999878406524658)},
    [877] = {shape="Normal", cframe=CFrame.new(-26.684175491333008,37.04997634887695,-12.99625015258789,-1,0,0,0,1,0,0,0,-1)},
    [1208] = {shape="Normal", cframe=CFrame.new(6.058112621307373,24.624897003173828,33.74209213256836,0.9999988079071045,-0,-0.0015537957660853863,0,1,-0,0.0015537957660853863,0,0.9999988079071045)},
    [50] = {shape="Normal", cframe=CFrame.new(-14.389516830444336,24.39999771118164,17.743762969970703,0.8191556930541992,-0,-0.5735712647438049,0,1,-0,0.5735712647438049,0,0.8191556930541992)},
    [773] = {shape="Normal", cframe=CFrame.new(-3.461451530456543,20.299951553344727,19.58254623413086,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [1080] = {shape="Cylinder", cframe=CFrame.new(47.090999603271484,21.157894134521484,-19.426616668701172,0,1,-0,-1,0,0,0,0,1)},
    [830] = {shape="Normal", cframe=CFrame.new(-10.083792686462402,47.55002212524414,-9.096378326416016,-1,0,0,0,1,0,0,0,-1)},
    [1108] = {shape="Cylinder", cframe=CFrame.new(44.556636810302734,20.002887725830078,-27.952434539794922,0,-1,-0,-1,0,-0,0,0,-1)},
    [1207] = {shape="Cylinder", cframe=CFrame.new(33.3380126953125,21.843191146850586,-10.322580337524414,-0.000006079673767089844,0.9999881982803345,-0.004883096553385258,-1.0000001192092896,-0.000006079673767089844,1.4668330550193787e-08,-1.4668330550193787e-08,0.004883096553385258,0.9999880790710449)},
    [981] = {shape="Normal", cframe=CFrame.new(-31.744110107421875,23.94968032836914,-24.224349975585938,0,0,-1,0,1,0,1,0,0)},
    [588] = {shape="Normal", cframe=CFrame.new(-31.773408889770508,23.949670791625977,-6.99505615234375,0.7071342468261719,-0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,0.0001264711027033627,0.707079291343689,-0.00019253601203672588,0.7071342468261719)},
    [1205] = {shape="Cylinder", cframe=CFrame.new(33.3380126953125,23.593185424804688,-10.322580337524414,-0.000006079673767089844,0.9999881982803345,-0.004883096553385258,-1.0000001192092896,-0.000006079673767089844,1.4668330550193787e-08,-1.4668330550193787e-08,0.004883096553385258,0.9999880790710449)},
    [1314] = {shape="Cylinder", cframe=CFrame.new(11.68829345703125,23.593191146850586,-10.427495002746582,-0.000006079673767089844,0.9999881982803345,-0.004883096553385258,-1.0000001192092896,-0.000006079673767089844,1.4668330550193787e-08,-1.4668330550193787e-08,0.004883096553385258,0.9999880790710449)},
    [841] = {shape="Normal", cframe=CFrame.new(54.916439056396484,28.774965286254883,-23.69607162475586,-1,0,0,0,1,0,0,0,-1)},
    [715] = {shape="Normal", cframe=CFrame.new(31.81626319885254,34.64995574951172,23.95400047302246,0,0,1,0,1,-0,-1,0,0)},
    [802] = {shape="Normal", cframe=CFrame.new(-10.083824157714844,55.349971771240234,-12.996212005615234,-1,0,0,0,1,0,0,0,-1)},
    [856] = {shape="Normal", cframe=CFrame.new(-14.333434104919434,38.524986267089844,-5.095919609069824,0.08713138103485107,0,0.9961968660354614,0,1,0,-0.9961968660354614,0,0.08713138103485107)},
    [1057] = {shape="Normal", cframe=CFrame.new(40.64764404296875,23.369945526123047,-19.426342010498047,-1,0,0,0,1,0,0,0,-1)},
    [433] = {shape="Normal", cframe=CFrame.new(20.865909576416016,24.235464096069336,-26.4097957611084,0,1,0,0,0,-1,-1,0,0)},
    [1128] = {shape="Seat", cframe=CFrame.new(50.604610443115234,21.752241134643555,-27.949962615966797,0,0,1,0,1,-0,-1,0,0)},
    [853] = {shape="Normal", cframe=CFrame.new(-3.3835363388061523,38.524986267089844,-5.095920562744141,0.08713138103485107,0,0.9961968660354614,0,1,0,-0.9961968660354614,0,0.08713138103485107)},
    [1146] = {shape="Seat", cframe=CFrame.new(30.381349563598633,21.85224151611328,-10.228524208068848,0,0,-1,0,1,0,1,0,0)},
    [202] = {shape="Normal", cframe=CFrame.new(54.89823913574219,23.138870239257812,28.17740249633789,-0.024562716484069824,-0.21339008212089539,0.9766582250595093,0.02048756182193756,0.9766404032707214,0.21390143036842346,-0.999488353729248,0.02526334673166275,-0.019617080688476562)},
    [122] = {shape="Normal", cframe=CFrame.new(-8.911771774291992,22.444438934326172,22.500032424926758,1,0,0,0,1,0,0,0,1)},
    [1190] = {shape="Cylinder", cframe=CFrame.new(33.2921142578125,20.10289192199707,-13.363962173461914,0,0,1,-1,0,0,0,-1,0)},
    [546] = {shape="Normal", cframe=CFrame.new(-31.773406982421875,23.949684143066406,0.546356201171875,-0.7071342468261719,0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,-0.0001264711027033627,0.707079291343689,-0.00019253601203672588,-0.7071342468261719)},
    [1186] = {shape="Normal", cframe=CFrame.new(33.29217529296875,23.369892120361328,-6.919961929321289,0,0,-1,0,1,0,1,0,0)},
    [698] = {shape="Normal", cframe=CFrame.new(6.716155529022217,47.549949645996094,-12.996282577514648,-1,0,0,0,1,0,0,0,-1)},
    [640] = {shape="Normal", cframe=CFrame.new(0.5571855902671814,21.84990882873535,-39.66668701171875,-0.710559606552124,0,-0.7036370635032654,0,1,0,0.7036370635032654,0,-0.710559606552124)},
    [848] = {shape="Normal", cframe=CFrame.new(-18.08348846435547,21.37495994567871,35.304107666015625,-1,0,0,0,1,0,0,0,-1)},
    [1176] = {shape="Seat", cframe=CFrame.new(33.337738037109375,21.85224151611328,-7.315072059631348,1,0,0,0,1,0,0,0,1)},
    [556] = {shape="Normal", cframe=CFrame.new(-33.833988189697266,21.500015258789062,-4.863567352294922,1,0,0,0,1,0,0,0,1)},
    [1175] = {shape="Cylinder", cframe=CFrame.new(33.29217529296875,21.157894134521484,-7.088968276977539,0,0,-1,-1,0,0,0,1,0)},
    [791] = {shape="Normal", cframe=CFrame.new(15.016397476196289,30.049962997436523,42.303951263427734,-1,0,0,0,1,0,0,0,-1)},
    [882] = {shape="Normal", cframe=CFrame.new(32.866512298583984,28.774965286254883,-23.69599723815918,-1,0,0,0,1,0,0,0,-1)},
    [836] = {shape="Normal", cframe=CFrame.new(45.26622772216797,30.049962997436523,23.95400047302246,0,0,1,0,1,-0,-1,0,0)},
    [1173] = {shape="Cylinder", cframe=CFrame.new(36.4293212890625,21.157894134521484,-10.22614574432373,0,1,-0,-1,0,0,0,0,1)},
    [752] = {shape="Normal", cframe=CFrame.new(-16.607149124145508,23.499961853027344,-28.494903564453125,0.2588643431663513,-0,-0.965913712978363,0,1,-0,0.965913712978363,0,0.2588643431663513)},
    [811] = {shape="Normal", cframe=CFrame.new(21.016298294067383,38.524986267089844,-5.095924377441406,0.08713138103485107,0,0.9961968660354614,0,1,0,-0.9961968660354614,0,0.08713138103485107)},
    [807] = {shape="Normal", cframe=CFrame.new(34.166259765625,38.524986267089844,-5.095926284790039,0.08713138103485107,0,0.9961968660354614,0,1,0,-0.9961968660354614,0,0.08713138103485107)},
    [489] = {shape="Normal", cframe=CFrame.new(-5.921741485595703,40.07529067993164,28.03152084350586,1,0,0,0,-1,0,0,0,-1)},
    [935] = {shape="Normal", cframe=CFrame.new(-31.844118118286133,24.39965057373047,-27.95648193359375,1,0,0,0,1,0,0,0,1)},
    [1160] = {shape="Cylinder", cframe=CFrame.new(36.4293212890625,20.10289192199707,-10.22614574432373,0,1,-0,-1,0,0,0,0,1)},
    [527] = {shape="Cylinder", cframe=CFrame.new(-1.1876128911972046,21.157894134521484,-7.254094123840332,0,0,-1,-1,0,0,0,1,0)},
    [1156] = {shape="Normal", cframe=CFrame.new(29.985963821411133,23.369945526123047,-10.22585391998291,-1,0,0,0,1,0,0,0,-1)},
    [734] = {shape="Normal", cframe=CFrame.new(-17.31270980834961,23.249977111816406,11.874065399169922,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [506] = {shape="Normal", cframe=CFrame.new(-1.1878350973129272,23.369951248168945,-13.697376251220703,0,0,1,0,1,-0,-1,0,0)},
    [995] = {shape="Normal", cframe=CFrame.new(-14.608634948730469,26.049962997436523,37.0540771484375,-1,0,0,0,1,0,0,0,-1)},
    [104] = {shape="Normal", cframe=CFrame.new(-10.133993148803711,27.333330154418945,22.500032424926758,1,0,0,0,1,0,0,0,1)},
    [823] = {shape="Normal", cframe=CFrame.new(-14.833488464355469,21.374961853027344,35.304107666015625,-1,0,0,0,1,0,0,0,-1)},
    [1138] = {shape="Normal", cframe=CFrame.new(50.99990463256836,23.26994514465332,-27.952617645263672,1,0,0,0,1,0,0,0,1)},
    [1127] = {shape="Cylinder", cframe=CFrame.new(50.83053207397461,21.057891845703125,-27.952342987060547,0,1,-0,-1,0,0,0,0,1)},
    [821] = {shape="Normal", cframe=CFrame.new(-14.833488464355469,21.97495460510254,35.269134521484375,-1,0,0,0,1,0,0,0,-1)},
    [1125] = {shape="Cylinder", cframe=CFrame.new(47.64797592163086,21.74319076538086,-27.855876922607422,0.000005900859832763672,-0.9999881982803345,0.004883096553385258,-1.0000001192092896,-0.000006079673767089844,1.4668330550193787e-08,1.4668330550193787e-08,-0.004883096553385258,-0.999988317489624)},
    [1015] = {shape="Cylinder", cframe=CFrame.new(17.748287200927734,23.49319076538086,-28.000709533691406,0.000005900859832763672,-0.9999881982803345,0.004883096553385258,-1.0000001192092896,-0.000006079673767089844,1.4668330550193787e-08,1.4668330550193787e-08,-0.004883096553385258,-0.999988317489624)},
    [799] = {shape="Normal", cframe=CFrame.new(21.916473388671875,28.74996566772461,-23.69605255126953,-1,0,0,0,1,0,0,0,-1)},
    [747] = {shape="Normal", cframe=CFrame.new(-13.23708724975586,22.389999389648438,12.864986419677734,-0.8660367727279663,-0.12942761182785034,0.48293784260749817,-0.00002991408109664917,0.9659268260002136,0.25881528854370117,-0.49998047947883606,0.2241290956735611,-0.8365319967269897)},
    [1046] = {shape="Cylinder", cframe=CFrame.new(40.816009521484375,20.10289192199707,-19.426616668701172,0,-1,-0,-1,0,-0,0,0,-1)},
    [185] = {shape="Normal", cframe=CFrame.new(49.068115234375,25.770280838012695,28.522796630859375,0.01253443956375122,0,0.9999213814735413,0,1,0,-0.9999213814735413,0,0.01253443956375122)},
    [1121] = {shape="Cylinder", cframe=CFrame.new(44.556636810302734,21.057889938354492,-27.952434539794922,0,-1,-0,-1,0,-0,0,0,-1)},
    [363] = {shape="Normal", cframe=CFrame.new(13.992005348205566,24.58332633972168,11.401535034179688,0.9997404217720032,-0.022636795416474342,-0.0025765651371330023,0.022591492161154747,0.9996097683906555,-0.0164308063685894,0.0029475002083927393,0.016368333250284195,0.9998616576194763)},
    [857] = {shape="Normal", cframe=CFrame.new(-1.1834622621536255,38.524986267089844,-5.095921516418457,0.08713138103485107,0,0.9961968660354614,0,1,0,-0.9961968660354614,0,0.08713138103485107)},
    [43] = {shape="Normal", cframe=CFrame.new(24.66600799560547,25.05243682861328,11.115180015563965,1,0,0,0,0.999847948551178,0.01743638701736927,0,-0.01743638701736927,0.999847948551178)},
    [288] = {shape="Normal", cframe=CFrame.new(9.598288536071777,23.61812973022461,9.80693244934082,1,0,0,0,1,0,0,0,1)},
    [902] = {shape="Normal", cframe=CFrame.new(9.429265022277832,36.7498893737793,20.3315486907959,0,0,1,0,1,-0,-1,0,0)},
    [949] = {shape="Normal", cframe=CFrame.new(-31.750673294067383,24.3996639251709,-27.917770385742188,0.7071342468261719,-0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,0.0001264711027033627,0.707079291343689,-0.00019253601203672588,0.7071342468261719)},
    [1230] = {shape="Normal", cframe=CFrame.new(-29.554109573364258,48.144893646240234,-12.9462890625,0,-1,-0,-1,0,-0,0,0,-1)},
    [739] = {shape="Normal", cframe=CFrame.new(-16.522029876708984,21.949962615966797,10.45429801940918,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [1097] = {shape="Normal", cframe=CFrame.new(9.378480911254883,40.07529830932617,-4.968496322631836,1,0,0,0,-1,0,0,0,-1)},
    [834] = {shape="Normal", cframe=CFrame.new(30.61663818359375,37.22496032714844,-23.69609832763672,-1,0,0,0,1,0,0,0,-1)},
    [736] = {shape="Normal", cframe=CFrame.new(-20.841766357421875,22.47495460510254,9.836578369140625,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [766] = {shape="Normal", cframe=CFrame.new(44.51641845703125,30.349964141845703,8.854083061218262,-1,0,0,0,1,0,0,0,-1)},
    [803] = {shape="Normal", cframe=CFrame.new(21.84149169921875,28.74994659423828,-23.69611358642578,-1,0,0,0,1,0,0,0,-1)},
    [726] = {shape="Normal", cframe=CFrame.new(0.890235185623169,21.09995460510254,22.095027923583984,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [1091] = {shape="Normal", cframe=CFrame.new(47.260009765625,23.369892120361328,-19.426616668701172,1,0,0,0,1,0,0,0,1)},
    [795] = {shape="Normal", cframe=CFrame.new(-27.558509826660156,30.049970626831055,31.25396728515625,1,0,0,0,1,0,0,0,1)},
    [548] = {shape="Normal", cframe=CFrame.new(-31.914823532104492,23.949689865112305,0.546356201171875,0.7071342468261719,-0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,0.0001264711027033627,0.707079291343689,-0.00019253601203672588,0.7071342468261719)},
    [1078] = {shape="Cylinder", cframe=CFrame.new(43.99969482421875,23.593185424804688,-19.523052215576172,-0.000006079673767089844,0.9999881982803345,-0.004883096553385258,-1.0000001192092896,-0.000006079673767089844,1.4668330550193787e-08,-1.4668330550193787e-08,0.004883096553385258,0.9999880790710449)},
    [721] = {shape="Normal", cframe=CFrame.new(-8.419245719909668,23.22494125366211,16.7200870513916,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [119] = {shape="Normal", cframe=CFrame.new(-13.800661087036133,27.333330154418945,22.500032424926758,1,0,0,0,1,0,0,0,1)},
    [611] = {shape="Normal", cframe=CFrame.new(-31.70350456237793,22.74989128112793,7.230524063110352,0.004877209663391113,0,0.9999881386756897,0,1,0,-0.9999881386756897,0,0.004877209663391113)},
    [530] = {shape="Normal", cframe=CFrame.new(-10.029169082641602,48.144893646240234,-24.371065139770508,0,0,1,-1,0,0,0,-1,0)},
    [1278] = {shape="Normal", cframe=CFrame.new(8.33624267578125,23.369951248168945,-10.330785751342773,-1,0,0,0,1,0,0,0,-1)},
    [756] = {shape="Normal", cframe=CFrame.new(-10.083427429199219,38.13508987426758,-26.296236038208008,1,-0,0,0,0.49995946884155273,0.8660488128662109,-0,-0.8660488128662109,0.49995946884155273)},
    [947] = {shape="Normal", cframe=CFrame.new(-31.844118118286133,24.399696350097656,-27.69219970703125,1,0,0,0,1,0,0,0,1)},
    [508] = {shape="Cylinder", cframe=CFrame.new(-1.1875909566879272,20.102893829345703,-13.52902603149414,0,0,1,-1,0,0,0,-1,0)},
    [85] = {shape="Normal", cframe=CFrame.new(-15.618242263793945,22.350006103515625,16.883390426635742,0.8191556930541992,-0,-0.5735712647438049,0,1,-0,0.5735712647438049,0,0.8191556930541992)},
    [163] = {shape="Ball", cframe=CFrame.new(47.90596008300781,20.788236618041992,26.910648345947266,-0.012777090072631836,0,-0.9999183416366577,0,1,0,0.9999183416366577,0,-0.012777090072631836)},
    [746] = {shape="Normal", cframe=CFrame.new(-17.859704971313477,22.449962615966797,12.770885467529297,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [1072] = {shape="Normal", cframe=CFrame.new(43.95379638671875,23.369892120361328,-16.120433807373047,0,0,-1,0,1,0,1,0,0)},
    [622] = {shape="Normal", cframe=CFrame.new(57.32418441772461,21.84990882873535,-26.74091911315918,-0.004877209663391113,0,-0.9999881386756897,0,1,0,0.9999881386756897,0,-0.004877209663391113)},
    [175] = {shape="Ball", cframe=CFrame.new(53.37580490112305,20.788236618041992,26.9793701171875,-0.012777090072631836,0,-0.9999183416366577,0,1,0,0.9999183416366577,0,-0.012777090072631836)},
    [916] = {shape="Normal", cframe=CFrame.new(-31.75067138671875,24.3996639251709,-20.217788696289062,0.7071342468261719,-0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,0.0001264711027033627,0.707079291343689,-0.00019253601203672588,0.7071342468261719)},
    [1061] = {shape="Cylinder", cframe=CFrame.new(43.95379638671875,21.157894134521484,-16.289440155029297,0,0,-1,-1,0,0,0,1,0)},
    [1034] = {shape="Seat", cframe=CFrame.new(13.84616470336914,21.586971282958984,11.594200134277344,0.9999879002571106,-0,-0.004920339677482843,0,1,-0,0.004920339677482843,0,0.9999879002571106)},
    [810] = {shape="Normal", cframe=CFrame.new(18.366455078125,38.524986267089844,-5.095924377441406,0,0,1,0,1,-0,-1,0,0)},
    [565] = {shape="Normal", cframe=CFrame.new(-31.976259231567383,24.399677276611328,-2.824340343475342,0,0,-1,0,1,0,1,0,0)},
    [920] = {shape="Normal", cframe=CFrame.new(-31.976255416870117,24.399677276611328,-20.124359130859375,0,0,-1,0,1,0,1,0,0)},
    [870] = {shape="Normal", cframe=CFrame.new(53.21627426147461,38.524986267089844,-5.095930099487305,0.08713138103485107,0,0.9961968660354614,0,1,0,-0.9961968660354614,0,0.08713138103485107)},
    [1124] = {shape="Cylinder", cframe=CFrame.new(47.64797592163086,23.493183135986328,-27.855876922607422,0.000005900859832763672,-0.9999881982803345,0.004883096553385258,-1.0000001192092896,-0.000006079673767089844,1.4668330550193787e-08,1.4668330550193787e-08,-0.004883096553385258,-0.999988317489624)},
    [580] = {shape="Normal", cframe=CFrame.new(-31.773408889770508,23.949684143066406,-6.853636741638184,-0.7071342468261719,0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,-0.0001264711027033627,0.707079291343689,-0.00019253601203672588,-0.7071342468261719)},
    [261] = {shape="Normal", cframe=CFrame.new(8.073260307312012,23.100006103515625,9.97313117980957,1,0,0,0,1,0,0,0,1)},
    [779] = {shape="Normal", cframe=CFrame.new(43.091312408447266,22.59995460510254,12.529041290283203,-1,0,0,0,1,0,0,0,-1)},
    [876] = {shape="Normal", cframe=CFrame.new(14.5164213180542,40.12496566772461,10.504051208496094,-1,0,0,0,1,0,0,0,-1)},
    [1032] = {shape="Cylinder", cframe=CFrame.new(20.930843353271484,21.057891845703125,-28.09717559814453,0,1,-0,-1,0,0,0,0,1)},
    [858] = {shape="Normal", cframe=CFrame.new(-16.983274459838867,38.524986267089844,-5.095918655395508,0,0,1,0,1,-0,-1,0,0)},
    [617] = {shape="Normal", cframe=CFrame.new(6.008185386657715,20.64988899230957,33.741695404052734,0.9999988079071045,-0,-0.0015537957660853863,0,1,-0,0.0015537957660853863,0,0.9999988079071045)},
    [1020] = {shape="Seat", cframe=CFrame.new(20.70492172241211,21.752246856689453,-28.09479522705078,0,0,1,0,1,-0,-1,0,0)},
    [266] = {shape="Normal", cframe=CFrame.new(9.073248863220215,21.100006103515625,9.973133087158203,1,0,0,0,1,0,0,0,1)},
    [1019] = {shape="Cylinder", cframe=CFrame.new(20.93191146850586,20.002891540527344,-28.09716033935547,0,1,-0,-1,0,0,0,0,1)},
    [1016] = {shape="Cylinder", cframe=CFrame.new(17.748287200927734,21.74319076538086,-28.000709533691406,0.000005900859832763672,-0.9999881982803345,0.004883096553385258,-1.0000001192092896,-0.000006079673767089844,1.4668330550193787e-08,1.4668330550193787e-08,-0.004883096553385258,-0.999988317489624)},
    [158] = {shape="Normal", cframe=CFrame.new(-11.356215476989746,22.444438934326172,22.500030517578125,1,0,0,0,1,0,0,0,1)},
    [845] = {shape="Normal", cframe=CFrame.new(-18.08348846435547,22.424957275390625,35.2041015625,-1,0,0,0,1,0,0,0,-1)},
    [731] = {shape="Normal", cframe=CFrame.new(-17.4891300201416,24.0166072845459,12.129283905029297,-0.8660660982131958,0.043545760214328766,0.4980293810367584,-0.00006207451224327087,0.9961898922920227,-0.08721092343330383,-0.4999295175075531,-0.07556134462356567,-0.862763524055481)},
    [1011] = {shape="Normal", cframe=CFrame.new(14.487974166870117,23.269895553588867,-28.09711456298828,-1,0,0,0,1,0,0,0,-1)},
    [1000] = {shape="Cylinder", cframe=CFrame.new(14.656950950622559,21.057891845703125,-28.097267150878906,0,-1,-0,-1,0,-0,0,0,-1)},
    [996] = {shape="Normal", cframe=CFrame.new(-14.583518981933594,24.849964141845703,37.0540771484375,-1,0,0,0,1,0,0,0,-1)},
    [884] = {shape="Normal", cframe=CFrame.new(2.470890522003174,23.72493553161621,23.00759506225586,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [1141] = {shape="Normal", cframe=CFrame.new(52.533050537109375,30.3998966217041,23.61703872680664,-0.0015864372253417969,0,-0.9999987483024597,0,1,0,0.9999987483024597,0,-0.0015864372253417969)},
    [958] = {shape="Normal", cframe=CFrame.new(-31.77341079711914,23.949674606323242,-16.895050048828125,0.7071342468261719,-0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,0.0001264711027033627,0.707079291343689,-0.00019253601203672588,0.7071342468261719)},
    [911] = {shape="Normal", cframe=CFrame.new(-31.983884811401367,21.250028610229492,-22.163543701171875,1,0,0,0,1,0,0,0,1)},
    [511] = {shape="Cylinder", cframe=CFrame.new(-1.0911253690719604,23.593191146850586,-10.345340728759766,-7.152557373046875e-07,-0.004919648170471191,-0.9999878406524658,-1,7.152557373046875e-07,6.854534149169922e-07,6.854534149169922e-07,0.9999878406524658,-0.004919648170471191)},
    [994] = {shape="Normal", cframe=CFrame.new(-14.583518981933594,26.02495765686035,37.0540771484375,-1,0,0,0,1,0,0,0,-1)},
    [993] = {shape="Normal", cframe=CFrame.new(-8.508659362792969,26.049962997436523,37.0540771484375,-1,0,0,0,1,0,0,0,-1)},
    [1074] = {shape="Cylinder", cframe=CFrame.new(43.95379638671875,20.10288429260254,-16.289440155029297,0,0,-1,-1,0,0,0,1,0)},
    [991] = {shape="Normal", cframe=CFrame.new(-26.65843963623047,26.049962997436523,37.0540771484375,-1,0,0,0,1,0,0,0,-1)},
    [844] = {shape="Normal", cframe=CFrame.new(-18.08348846435547,20.124971389770508,35.329132080078125,-1,0,0,0,1,0,0,0,-1)},
    [990] = {shape="Normal", cframe=CFrame.new(-20.50865936279297,26.049962997436523,37.0540771484375,-1,0,0,0,1,0,0,0,-1)},
    [987] = {shape="Normal", cframe=CFrame.new(-10.029413223266602,48.14534378051758,-24.321290969848633,1,0,-0,0,0,1,0,-1,0)},
    [985] = {shape="Normal", cframe=CFrame.new(-31.944120407104492,23.94968032836914,-24.224349975585938,0,0,-1,0,1,0,1,0,0)},
    [964] = {shape="Normal", cframe=CFrame.new(-31.74411392211914,23.94968032836914,-16.8243408203125,0,0,-1,0,1,0,1,0,0)},
    [975] = {shape="Normal", cframe=CFrame.new(-31.8441162109375,23.949689865112305,-24.124359130859375,1,0,0,0,1,0,0,0,1)},
    [192] = {shape="Normal", cframe=CFrame.new(56.3604736328125,21.23297882080078,25.350513458251953,-0.02684164047241211,0.9996397495269775,-0.000002175569534301758,-0.000002175569534301758,-0.0000022649765014648438,-1,-0.9996397495269775,-0.02684161067008972,0.0000021457672119140625)},
    [973] = {shape="Normal", cframe=CFrame.new(-31.914823532104492,23.949689865112305,-24.15362548828125,0.7071342468261719,-0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,0.0001264711027033627,0.707079291343689,-0.00019253601203672588,0.7071342468261719)},
    [1253] = {shape="Seat", cframe=CFrame.new(11.644775390625,21.85224151611328,-13.241920471191406,-1,0,0,0,1,0,0,0,-1)},
    [310] = {shape="Normal", cframe=CFrame.new(26.166006088256836,23.031513214111328,10.996882438659668,1,0,0,0,-0.017380952835083008,-0.9998490214347839,0,0.9998490214347839,-0.017380952835083008)},
    [809] = {shape="Normal", cframe=CFrame.new(23.916292190551758,38.524986267089844,-5.095925331115723,0,0,1,0,1,-0,-1,0,0)},
    [780] = {shape="Normal", cframe=CFrame.new(-0.2334003448486328,26.899965286254883,-23.696048736572266,-1,0,0,0,1,0,0,0,-1)},
    [595] = {shape="Normal", cframe=CFrame.new(-31.937562942504883,24.399694442749023,-10.430876731872559,0.7071342468261719,-0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,0.0001264711027033627,0.707079291343689,-0.00019253601203672588,0.7071342468261719)},
    [200] = {shape="Normal", cframe=CFrame.new(54.982032775878906,22.748197555541992,28.167675018310547,-0.024562716484069824,-0.21339008212089539,0.9766582250595093,0.02048756182193756,0.9766404032707214,0.21390143036842346,-0.999488353729248,0.02526334673166275,-0.019617080688476562)},
    [966] = {shape="Normal", cframe=CFrame.new(-31.914831161499023,23.949670791625977,-16.895050048828125,-0.7071342468261719,0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,-0.0001264711027033627,0.707079291343689,-0.00019253601203672588,-0.7071342468261719)},
    [429] = {shape="Normal", cframe=CFrame.new(21.5659122467041,23.83546257019043,-27.9097957611084,0,0,1,0,1,-0,-1,0,0)},
    [776] = {shape="Normal", cframe=CFrame.new(-16.075990676879883,23.499961853027344,-28.637130737304688,0.2588643431663513,-0,-0.965913712978363,0,1,-0,0.965913712978363,0,0.2588643431663513)},
    [515] = {shape="Seat", cframe=CFrame.new(-1.1419366598129272,21.85224151611328,-7.480106353759766,1,0,0,0,1,0,0,0,1)},
    [461] = {shape="Normal", cframe=CFrame.new(-31.933820724487305,22.74989128112793,16.178203582763672,0.004877209663391113,0,0.9999881386756897,0,1,0,-0.9999881386756897,0,0.004877209663391113)},
    [983] = {shape="Normal", cframe=CFrame.new(-31.914823532104492,23.949670791625977,-24.295059204101562,-0.7071342468261719,0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,-0.0001264711027033627,0.707079291343689,-0.00019253601203672588,-0.7071342468261719)},
    [669] = {shape="Normal", cframe=CFrame.new(-25.32861328125,22.824949264526367,6.957488059997559,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [786] = {shape="Normal", cframe=CFrame.new(-25.328887939453125,21.424957275390625,6.957502365112305,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [960] = {shape="Normal", cframe=CFrame.new(-31.844120025634766,23.949670791625977,-16.924346923828125,1,0,0,0,1,0,0,0,1)},
    [956] = {shape="Normal", cframe=CFrame.new(-31.844120025634766,23.949689865112305,-16.724349975585938,1,0,0,0,1,0,0,0,1)},
    [72] = {shape="Normal", cframe=CFrame.new(-13.979941368103027,20.89999771118164,18.030553817749023,0.8191556930541992,-0,-0.5735712647438049,0,1,-0,0.5735712647438049,0,0.8191556930541992)},
    [926] = {shape="Normal", cframe=CFrame.new(-31.8441162109375,24.399656295776367,-20.2564697265625,1,0,0,0,1,0,0,0,1)},
    [514] = {shape="Cylinder", cframe=CFrame.new(-1.1876128911972046,20.102893829345703,-7.254094123840332,0,0,-1,-1,0,0,0,1,0)},
    [790] = {shape="Normal", cframe=CFrame.new(-4.633424758911133,26.899965286254883,-23.696048736572266,-1,0,0,0,1,0,0,0,-1)},
    [703] = {shape="Normal", cframe=CFrame.new(-9.783632278442383,23.499961853027344,-23.921052932739258,-1,0,0,0,1,0,0,0,-1)},
    [954] = {shape="Normal", cframe=CFrame.new(-31.77341079711914,23.949689865112305,-16.753633499145508,-0.7071342468261719,0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,-0.0001264711027033627,0.707079291343689,-0.00019253601203672588,-0.7071342468261719)},
    [714] = {shape="Normal", cframe=CFrame.new(4.516177177429199,30.149965286254883,8.85408878326416,-1,0,0,0,1,0,0,0,-1)},
    [605] = {shape="Normal", cframe=CFrame.new(-31.976259231567383,24.399677276611328,-10.524322509765625,0,0,-1,0,1,0,1,0,0)},
    [436] = {shape="Normal", cframe=CFrame.new(20.893230438232422,22.378568649291992,-28.371179580688477,0,1,0,0,0,-1,-1,0,0)},
    [945] = {shape="Normal", cframe=CFrame.new(-31.750673294067383,24.399688720703125,-27.73089599609375,-0.7071342468261719,0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,-0.0001264711027033627,0.707079291343689,-0.00019253601203672588,-0.7071342468261719)},
    [204] = {shape="Normal", cframe=CFrame.new(-10.088199615478516,23.51556396484375,16.26822280883789,-0.4958075284957886,0,-0.8684327602386475,0,1,0,0.8684327602386475,0,-0.4958075284957886)},
    [941] = {shape="Normal", cframe=CFrame.new(-31.711977005004883,24.399677276611328,-27.8243408203125,0,0,-1,0,1,0,1,0,0)},
    [525] = {shape="Normal", cframe=CFrame.new(-1.1875604391098022,23.369895935058594,-7.085056304931641,0,0,-1,0,1,0,1,0,0)},
    [939] = {shape="Normal", cframe=CFrame.new(-31.937562942504883,24.399656295776367,-27.917770385742188,-0.7071342468261719,0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,-0.0001264711027033627,0.707079291343689,-0.00019253601203672588,-0.7071342468261719)},
    [414] = {shape="Normal", cframe=CFrame.new(21.5659122467041,23.83546257019043,-27.9097957611084,0,0,1,0,1,0,-1,0,0)},
    [77] = {shape="Normal", cframe=CFrame.new(-14.30925464630127,24.925020217895508,17.849159240722656,0.8191556930541992,-0,-0.5735712647438049,0,1,-0,0.5735712647438049,0,0.8191556930541992)},
    [664] = {shape="Normal", cframe=CFrame.new(32.99142074584961,30.199954986572266,-23.696115493774414,-1,0,0,0,1,0,0,0,-1)},
    [1161] = {shape="Seat", cframe=CFrame.new(36.2032470703125,21.85224151611328,-10.271769523620605,0,0,1,0,1,-0,-1,0,0)},
    [930] = {shape="Normal", cframe=CFrame.new(-31.75067138671875,24.399688720703125,-20.030914306640625,-0.7071342468261719,0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,-0.0001264711027033627,0.707079291343689,-0.00019253601203672588,-0.7071342468261719)},
    [670] = {shape="Normal", cframe=CFrame.new(2.470890522003174,23.82494354248047,23.00759506225586,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [928] = {shape="Normal", cframe=CFrame.new(-31.937559127807617,24.399660110473633,-20.217788696289062,-0.7071342468261719,0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,-0.0001264711027033627,0.707079291343689,-0.00019253601203672588,-0.7071342468261719)},
    [573] = {shape="Normal", cframe=CFrame.new(-31.937562942504883,24.399656295776367,-2.91778564453125,-0.7071342468261719,0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,-0.0001264711027033627,0.707079291343689,-0.00019253601203672588,-0.7071342468261719)},
    [924] = {shape="Normal", cframe=CFrame.new(-31.71197509765625,24.399677276611328,-20.124359130859375,0,0,-1,0,1,0,1,0,0)},
    [1047] = {shape="Seat", cframe=CFrame.new(41.04302978515625,21.85224151611328,-19.428997039794922,0,0,-1,0,1,0,1,0,0)},
    [307] = {shape="Normal", cframe=CFrame.new(-9.060774803161621,29.69994354248047,16.473217010498047,0.8660072684288025,-0,-0.5000314116477966,0,1,-0,0.5000314116477966,0,0.8660072684288025)},
    [680] = {shape="Normal", cframe=CFrame.new(-19.783477783203125,26.899965286254883,-23.696044921875,-1,0,0,0,1,0,0,0,-1)},
    [913] = {shape="Normal", cframe=CFrame.new(-33.833988189697266,21.500028610229492,-22.16357421875,1,0,0,0,1,0,0,0,1)},
    [909] = {shape="Normal", cframe=CFrame.new(-31.984254837036133,21.49880027770996,-29.663360595703125,1,0,0,0,1,0,0,0,1)},
    [906] = {shape="Normal", cframe=CFrame.new(9.429229736328125,36.74989318847656,-4.968496322631836,0,0,1,0,1,-0,-1,0,0)},
    [904] = {shape="Normal", cframe=CFrame.new(41.179290771484375,36.7498893737793,-4.968500137329102,0,0,1,0,1,-0,-1,0,0)},
    [900] = {shape="Normal", cframe=CFrame.new(-5.920767784118652,36.74989318847656,-4.968494415283203,0,0,1,0,1,-0,-1,0,0)},
    [453] = {shape="Normal", cframe=CFrame.new(-4.5,20,-13,1,0,0,0,1,0,0,0,1)},
    [894] = {shape="Normal", cframe=CFrame.new(25.379257202148438,36.7498893737793,-4.968541145324707,0,0,1,0,1,-0,-1,0,0)},
    [890] = {shape="Normal", cframe=CFrame.new(-5.920732498168945,36.7498893737793,28.031566619873047,0,0,1,0,1,-0,-1,0,0)},
    [634] = {shape="Seat", cframe=CFrame.new(24.75503921508789,21.586963653564453,2.2350378036499023,-0.9999878406524658,0,0.004920339677482843,0,1,0,-0.004920339677482843,0,-0.9999878406524658)},
    [886] = {shape="Normal", cframe=CFrame.new(-5.920733451843262,36.7498893737793,20.331554412841797,0,0,1,0,1,-0,-1,0,0)},
    [463] = {shape="Normal", cframe=CFrame.new(52.533355712890625,20.64988899230957,23.567066192626953,-0.0015864372253417969,0,-0.9999987483024597,0,1,0,0.9999987483024597,0,-0.0015864372253417969)},
    [1042] = {shape="Normal", cframe=CFrame.new(1.4285955429077148,38.62496566772461,26.981563568115234,0,0,-1,-1,0,0,0,1,0)},
    [196] = {shape="Normal", cframe=CFrame.new(54.745079040527344,23.70155906677246,28.19316864013672,-0.02455008029937744,-0.9986129999160767,0.046575188636779785,0.020523279905319214,0.04607599973678589,0.9987270832061768,-0.9994878768920898,0.02547469735145569,0.019363701343536377)},
    [847] = {shape="Normal", cframe=CFrame.new(-18.08348846435547,21.97495460510254,35.269134521484375,-1,0,0,0,1,0,0,0,-1)},
    [567] = {shape="Normal", cframe=CFrame.new(-31.750673294067383,24.3996639251709,-2.91778564453125,0.7071342468261719,-0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,0.0001264711027033627,0.707079291343689,-0.00019253601203672588,0.7071342468261719)},
    [554] = {shape="Normal", cframe=CFrame.new(-31.773406982421875,23.949670791625977,0.404937744140625,0.7071342468261719,-0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,0.0001264711027033627,0.707079291343689,-0.00019253601203672588,0.7071342468261719)},
    [487] = {shape="Normal", cframe=CFrame.new(24.67483901977539,21.82693099975586,12.214559555053711,-0.9999878406524658,0,0.004920339677482843,0,1,0,-0.004920339677482843,0,-0.9999878406524658)},
    [697] = {shape="Normal", cframe=CFrame.new(-23.866607666015625,24.573413848876953,7.801756858825684,-0.150407075881958,-0.8528389930725098,0.5000433921813965,-0.9848039150238037,0.17366987466812134,-0.000017970800399780273,-0.08682712912559509,-0.4924473464488983,-0.8660004138946533)},
    [187] = {shape="Normal", cframe=CFrame.new(50.980262756347656,21.860803604125977,28.5410099029541,-0.012534379959106445,0,-0.9999213814735413,0,1,0,0.9999213814735413,0,-0.012534379959106445)},
    [937] = {shape="Normal", cframe=CFrame.new(-31.976259231567383,24.399677276611328,-27.8243408203125,0,0,-1,0,1,0,1,0,0)},
    [872] = {shape="Normal", cframe=CFrame.new(6.366461277008057,30.049970626831055,31.05398178100586,-1,0,0,0,1,0,0,0,-1)},
    [867] = {shape="Normal", cframe=CFrame.new(48.366363525390625,38.524986267089844,-5.095929145812988,0,0,1,0,1,-0,-1,0,0)},
    [720] = {shape="Normal", cframe=CFrame.new(-9.783632278442383,23.499961853027344,-23.371049880981445,-1,0,0,0,1,0,0,0,-1)},
    [592] = {shape="Normal", cframe=CFrame.new(-31.914827346801758,23.949689865112305,-6.853636741638184,0.7071342468261719,-0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,0.0001264711027033627,0.707079291343689,-0.00019253601203672588,0.7071342468261719)},
    [813] = {shape="Normal", cframe=CFrame.new(31.966188430786133,38.524986267089844,-5.095926284790039,0.08713138103485107,0,0.9961968660354614,0,1,0,-0.9961968660354614,0,0.08713138103485107)},
    [355] = {shape="Normal", cframe=CFrame.new(14.570860862731934,21.213842391967773,10.500692367553711,0.9997402429580688,-0.022245053201913834,-0.004957656376063824,0.022595707327127457,0.9958490133285522,0.08817101269960403,0.002975708805024624,-0.08826013654470444,0.9960930347442627)},
    [828] = {shape="Normal", cframe=CFrame.new(-3.483363151550293,21.09995460510254,19.570011138916016,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [370] = {shape="Normal", cframe=CFrame.new(14.026268005371094,23.062999725341797,11.420907020568848,0.9997408986091614,-0.022293584421277046,-0.004590834490954876,0.02256276272237301,0.9972368478775024,0.07077864557504654,0.003000239608809352,-0.07086389511823654,0.9974814653396606)},
    [528] = {shape="Normal", cframe=CFrame.new(-29.504213333129883,48.14534378051758,-12.946102142333984,0,-1,0,0,0,1,-1,0,0)},
    [481] = {shape="Seat", cframe=CFrame.new(24.6461181640625,21.586963653564453,11.594200134277344,0.9999879002571106,-0,-0.004920339677482843,0,1,-0,0.004920339677482843,0,0.9999879002571106)},
    [677] = {shape="Normal", cframe=CFrame.new(3.7165536880493164,38.524986267089844,-5.095922470092773,0.08713138103485107,0,0.9961968660354614,0,1,0,-0.9961968660354614,0,0.08713138103485107)},
    [1328] = {shape="Normal", cframe=CFrame.new(-0.3999999761581421,10,-7,1,0,0,0,1,0,0,0,1)},
    [1313] = {shape="Cylinder", cframe=CFrame.new(11.68829345703125,20.093185424804688,-10.427495002746582,-0.000006079673767089844,0.9999881982803345,-0.004883096553385258,-1.0000001192092896,-0.000006079673767089844,1.4668330550193787e-08,-1.4668330550193787e-08,0.004883096553385258,0.9999880790710449)},
    [859] = {shape="Normal", cframe=CFrame.new(-25.333314895629883,30.049976348876953,-8.645904541015625,-1,0,0,0,1,0,0,0,-1)},
    [1030] = {shape="Normal", cframe=CFrame.new(21.100215911865234,23.26995086669922,-28.097450256347656,1,0,0,0,1,0,0,0,1)},
    [1119] = {shape="Normal", cframe=CFrame.new(44.38766098022461,23.269895553588867,-27.952281951904297,-1,0,0,0,1,0,0,0,-1)},
    [850] = {shape="Normal", cframe=CFrame.new(5.991366863250732,22.59995460510254,12.529047012329102,-1,0,0,0,1,0,0,0,-1)},
    [1095] = {shape="Normal", cframe=CFrame.new(40.87841796875,40.07529067993164,-4.968664169311523,1,0,0,0,-1,0,0,0,-1)},
    [57] = {shape="Normal", cframe=CFrame.new(-14.389516830444336,22.89999771118164,17.743762969970703,0.8191556930541992,-0,-0.5735712647438049,0,1,-0,0.5735712647438049,0,0.8191556930541992)},
    [40] = {shape="Normal", cframe=CFrame.new(9.573256492614746,24.70000648498535,9.973410606384277,1,0,0,0,1,0,0,0,1)},
    [1211] = {shape="Seat", cframe=CFrame.new(34.846134185791016,21.586963653564453,11.594196319580078,0.9999879002571106,-0,-0.004920339677482843,0,1,-0,0.004920339677482843,0,0.9999879002571106)},
    [827] = {shape="Normal", cframe=CFrame.new(14.29062271118164,30.550037384033203,9.554512023925781,0,0,-1,0,1,0,1,0,0)},
    [563] = {shape="Normal", cframe=CFrame.new(-31.937562942504883,24.399694442749023,-2.7309107780456543,0.7071342468261719,-0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,0.0001264711027033627,0.707079291343689,-0.00019253601203672588,0.7071342468261719)},
    [91] = {shape="Normal", cframe=CFrame.new(-14.799092292785645,20.89999771118164,17.456972122192383,0.8191556930541992,-0,-0.5735712647438049,0,1,-0,0.5735712647438049,0,0.8191556930541992)},
    [896] = {shape="Normal", cframe=CFrame.new(41.179325103759766,36.7498893737793,20.3315486907959,0,0,1,0,1,-0,-1,0,0)},
    [705] = {shape="Normal", cframe=CFrame.new(17.866287231445312,30.099964141845703,23.95400047302246,0,0,1,0,1,-0,-1,0,0)},
    [825] = {shape="Normal", cframe=CFrame.new(15.14163589477539,19.99997901916504,9.304023742675781,-1,0,0,0,1,0,0,0,-1)},
    [1140] = {shape="Cylinder", cframe=CFrame.new(50.831600189208984,20.002891540527344,-27.952327728271484,0,1,-0,-1,0,0,0,0,1)},
    [599] = {shape="Normal", cframe=CFrame.new(-31.750673294067383,24.3996639251709,-10.617766380310059,0.7071342468261719,-0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,0.0001264711027033627,0.707079291343689,-0.00019253601203672588,0.7071342468261719)},
    [951] = {shape="Normal", cframe=CFrame.new(-30.134033203125,21.500028610229492,-22.16357421875,1,0,0,0,1,0,0,0,1)},
    [465] = {shape="Normal", cframe=CFrame.new(-12.175533294677734,23.94972038269043,14.589046478271484,0.8660072684288025,-0,-0.5000314116477966,0,1,-0,0.5000314116477966,0,0.8660072684288025)},
    [322] = {shape="Normal", cframe=CFrame.new(24.666006088256836,23.00465965270996,11.26069450378418,1,-0,0,0,0.999847948551178,0.01743638701736927,-0,-0.01743638701736927,0.999847948551178)},
    [586] = {shape="Normal", cframe=CFrame.new(-31.944124221801758,23.94968032836914,-6.924346923828125,0,0,-1,0,1,0,1,0,0)},
    [510] = {shape="Cylinder", cframe=CFrame.new(-1.0911253690719604,21.84319496154785,-10.345340728759766,-7.152557373046875e-07,-0.004919648170471191,-0.9999878406524658,-1,7.152557373046875e-07,6.854534149169922e-07,6.854534149169922e-07,0.9999878406524658,-0.004919648170471191)},
    [438] = {shape="Normal", cframe=CFrame.new(21.067441940307617,24.235464096069336,-29.37493324279785,0,1,0,0,0,-1,-1,0,0)},
    [760] = {shape="Normal", cframe=CFrame.new(-10.083795547485352,37.550018310546875,-23.746370315551758,-1,0,0,0,1,0,0,0,-1)},
    [171] = {shape="Ball", cframe=CFrame.new(47.86592102050781,20.788236618041992,30.098857879638672,0.012777149677276611,0,0.9999183416366577,0,1,0,-0.9999183416366577,0,0.012777149677276611)},
    [544] = {shape="Normal", cframe=CFrame.new(-31.744110107421875,23.94968032836914,0.4756474494934082,0,0,-1,0,1,0,1,0,0)},
    [571] = {shape="Normal", cframe=CFrame.new(-31.844118118286133,24.39965057373047,-2.956481456756592,1,0,0,0,1,0,0,0,1)},
    [584] = {shape="Normal", cframe=CFrame.new(-31.744112014770508,23.94968032836914,-6.924346923828125,0,0,-1,0,1,0,1,0,0)},
    [352] = {shape="Normal", cframe=CFrame.new(24.166006088256836,20.987489700317383,10.295796394348145,1,-0,0,0,0.999847948551178,0.01743638701736927,-0,-0.01743638701736927,0.999847948551178)},
    [469] = {shape="Normal", cframe=CFrame.new(50.983463287353516,23.549888610839844,23.596088409423828,-0.0015864372253417969,0,-0.9999987483024597,0,1,0,0.9999987483024597,0,-0.0015864372253417969)},
    [242] = {shape="Normal", cframe=CFrame.new(9.573256492614746,23.100006103515625,9.973138809204102,1,0,0,0,1,0,0,0,1)},
    [180] = {shape="Normal", cframe=CFrame.new(49.59375,23.987607955932617,28.529407501220703,0.01253443956375122,0,0.9999213814735413,0,1,0,-0.9999213814735413,0,0.01253443956375122)},
    [819] = {shape="Normal", cframe=CFrame.new(-14.833488464355469,22.424957275390625,35.2041015625,-1,0,0,0,1,0,0,0,-1)},
    [97] = {shape="Normal", cframe=CFrame.new(-10.133993148803711,30.999998092651367,22.500032424926758,1,0,0,0,1,0,0,0,1)},
    [459] = {shape="Normal", cframe=CFrame.new(-5.921591758728027,40.07529830932617,-4.968539237976074,1,0,0,0,-1,0,0,0,-1)},
    [348] = {shape="Normal", cframe=CFrame.new(23.16600799560547,22.894813537597656,11.094120979309082,1,0,0,0,0.052398860454559326,-0.9986262917518616,0,0.9986262917518616,0.052398860454559326)},
    [875] = {shape="Normal", cframe=CFrame.new(-15.433504104614258,26.899965286254883,-23.696046829223633,-1,0,0,0,1,0,0,0,-1)},
    [735] = {shape="Normal", cframe=CFrame.new(-14.02718734741211,24.09995460510254,14.233028411865234,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [491] = {shape="Normal", cframe=CFrame.new(-15.421746253967285,40.07529067993164,28.031524658203125,1,0,0,0,-1,0,0,0,-1)},
    [360] = {shape="Normal", cframe=CFrame.new(12.526249885559082,23.1005802154541,11.010391235351562,0.9997398853302002,-0.004200705327093601,0.022417783737182617,0.022609949111938477,0.05329728126525879,-0.9983228445053101,0.0029988493770360947,0.9985699653625488,0.053378403186798096)},
    [817] = {shape="Normal", cframe=CFrame.new(-16.341585159301758,22.649965286254883,-28.565933227539062,0.2588643431663513,-0,-0.965913712978363,0,1,-0,0.965913712978363,0,0.2588643431663513)},
    [814] = {shape="Normal", cframe=CFrame.new(24.566320419311523,22.59995460510254,14.654073715209961,-1,0,0,0,1,0,0,0,-1)},
    [590] = {shape="Normal", cframe=CFrame.new(-31.844118118286133,23.949661254882812,-7.024336814880371,1,0,0,0,1,0,0,0,1)},
    [753] = {shape="Normal", cframe=CFrame.new(43.91646957397461,28.74996566772461,-23.696117401123047,-1,0,0,0,1,0,0,0,-1)},
    [1171] = {shape="Normal", cframe=CFrame.new(36.59832763671875,23.369892120361328,-10.22614574432373,1,0,0,0,1,0,0,0,1)},
    [615] = {shape="Normal", cframe=CFrame.new(25.378435134887695,40.07529067993164,20.33147430419922,1,0,0,0,-1,0,0,0,-1)},
    [32] = {shape="Normal", cframe=CFrame.new(14.539448738098145,21.94439697265625,-27.40591049194336,0.017462193965911865,-0.9996950626373291,-0.017460227012634277,-0.000040650367736816406,0.017462193965911865,-0.9998475313186646,0.9998475313186646,0.017460227012634277,0.00026428699493408203)},
    [808] = {shape="Normal", cframe=CFrame.new(26.516328811645508,38.524986267089844,-5.095925331115723,-0.08713150024414062,0,0.9961968660354614,0,1,0,-0.9961968660354614,0,-0.08713150024414062)},
    [647] = {shape="Normal", cframe=CFrame.new(57.32418441772461,21.84990882873535,-38.74092102050781,-0.004877209663391113,0,-0.9999881386756897,0,1,0,0.9999881386756897,0,-0.004877209663391113)},
    [16] = {shape="Normal", cframe=CFrame.new(14.193029403686523,23.34999656677246,-27.899940490722656,0.01750171184539795,-0,-0.9998469352722168,0,1,-0,0.9998469352722168,0,0.01750171184539795)},
    [729] = {shape="Normal", cframe=CFrame.new(-17.04323959350586,24.04153060913086,11.357845306396484,-0.8660367727279663,-0.12942761182785034,0.48293784260749817,-0.00002991408109664917,0.9659268260002136,0.25881528854370117,-0.49998047947883606,0.2241290956735611,-0.8365319967269897)},
    [445] = {shape="Normal", cframe=CFrame.new(21.5712947845459,25.938457489013672,-27.9097957611084,1,0,0,0,1,0,0,0,1)},
    [632] = {shape="Normal", cframe=CFrame.new(24.726320266723633,21.826942443847656,1.6146917343139648,0.9999879002571106,-0,-0.004920339677482843,0,1,-0,0.004920339677482843,0,0.9999879002571106)},
    [741] = {shape="Normal", cframe=CFrame.new(-17.53460121154785,24.84994125366211,12.208019256591797,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [385] = {shape="Normal", cframe=CFrame.new(13.571114540100098,21.1912784576416,10.497735023498535,0.9997402429580688,-0.022245053201913834,-0.004957656376063824,0.022595707327127457,0.9958490133285522,0.08817101269960403,0.002975708805024624,-0.08826013654470444,0.9960930347442627)},
    [655] = {shape="Normal", cframe=CFrame.new(43.84151840209961,28.74994659423828,-23.696117401123047,-1,0,0,0,1,0,0,0,-1)},
    [193] = {shape="Normal", cframe=CFrame.new(56.521514892578125,21.2369384765625,31.355995178222656,-0.02684164047241211,0.9996397495269775,-0.000002175569534301758,-0.000002175569534301758,-0.0000022649765014648438,-1,-0.9996397495269775,-0.02684161067008972,0.0000021457672119140625)},
    [774] = {shape="Wedge", cframe=CFrame.new(-5.366786479949951,21.099964141845703,18.482723236083984,0.49995946884155273,0,0.8660488128662109,0,1,0,-0.8660488128662109,0,0.49995946884155273)},
    [629] = {shape="Normal", cframe=CFrame.new(31.68302345275879,24.624897003173828,23.617046356201172,-0.0015864372253417969,0,-0.9999987483024597,0,1,0,0.9999987483024597,0,-0.0015864372253417969)},
    [688] = {shape="Normal", cframe=CFrame.new(33.416439056396484,43.59996032714844,-23.19599723815918,-1,0,0,0,1,0,0,0,-1)},
    [962] = {shape="Normal", cframe=CFrame.new(-31.914831161499023,23.949689865112305,-16.753633499145508,0.7071342468261719,-0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,0.0001264711027033627,0.707079291343689,-0.00019253601203672588,0.7071342468261719)},
    [777] = {shape="Normal", cframe=CFrame.new(-4.678096294403076,21.872146606445312,18.88015365600586,-0.663427472114563,-0.5566501021385193,0.5000044107437134,-0.6427698731422424,0.7660592794418335,-0.00000852346420288086,-0.3830282688140869,-0.3213934302330017,-0.8660228252410889)},
    [822] = {shape="Normal", cframe=CFrame.new(-14.833488464355469,20.12497901916504,35.329132080078125,-1,0,0,0,1,0,0,0,-1)},
    [829] = {shape="Normal", cframe=CFrame.new(4.516422271728516,30.249961853027344,8.85408878326416,-1,0,0,0,1,0,0,0,-1)},
    [768] = {shape="Normal", cframe=CFrame.new(44.51641845703125,30.349964141845703,8.854083061218262,-1,0,0,0,1,0,0,0,-1)},
    [668] = {shape="Normal", cframe=CFrame.new(-10.058351516723633,32.04997634887695,-23.696046829223633,-1,0,0,0,1,0,0,0,-1)},
    [866] = {shape="Normal", cframe=CFrame.new(37.416473388671875,38.524986267089844,-5.0959272384643555,0,0,1,0,1,-0,-1,0,0)},
    [778] = {shape="Normal", cframe=CFrame.new(1.9728444814682007,22.699954986572266,22.72005844116211,-0.8660074472427368,0,0.5000314116477966,0,1,0,-0.5000314116477966,0,-0.8660074472427368)},
    [578] = {shape="Normal", cframe=CFrame.new(-31.844118118286133,23.949689865112305,-6.8243408203125,1,0,0,0,1,0,0,0,1)},
    [1093] = {shape="Cylinder", cframe=CFrame.new(47.090999603271484,20.10288429260254,-19.426616668701172,0,1,-0,-1,0,0,0,0,1)},
    [1225] = {shape="Normal", cframe=CFrame.new(31.683080673217773,30.399900436401367,23.617040634155273,-0.0015864372253417969,0,-0.9999987483024597,0,1,0,0.9999987483024597,0,-0.0015864372253417969)},
    [9] = {shape="Normal", cframe=CFrame.new(14.193029403686523,24.69999885559082,-27.899940490722656,0.01750171184539795,-0,-0.9998469352722168,0,1,-0,0.9998469352722168,0,0.01750171184539795)},
    [550] = {shape="Normal", cframe=CFrame.new(-31.914823532104492,23.949670791625977,0.404937744140625,-0.7071342468261719,0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,-0.0001264711027033627,0.707079291343689,-0.00019253601203672588,-0.7071342468261719)},
    [271] = {shape="Normal", cframe=CFrame.new(9.573256492614746,24.70000648498535,9.973410606384277,1,0,0,0,1,0,0,0,1)},
    [743] = {shape="Normal", cframe=CFrame.new(-20.6475830078125,23.989782333374023,9.500091552734375,-0.8660367727279663,-0.12942761182785034,0.48293784260749817,-0.00002991408109664917,0.9659268260002136,0.25881528854370117,-0.49998047947883606,0.2241290956735611,-0.8365319967269897)},
    [787] = {shape="Normal", cframe=CFrame.new(-9.783632278442383,24.349964141845703,-23.646028518676758,-1,0,0,0,1,0,0,0,-1)},
    [737] = {shape="Normal", cframe=CFrame.new(-17.485864639282227,24.091318130493164,12.123624801635742,-0.8660660982131958,0.043545760214328766,0.4980293810367584,-0.00006207451224327087,0.9961898922920227,-0.08721092343330383,-0.4999295175075531,-0.07556134462356567,-0.862763524055481)},
    [888] = {shape="Normal", cframe=CFrame.new(-15.42073917388916,36.7498893737793,28.031570434570312,0,0,1,0,1,-0,-1,0,0)},
    [296] = {shape="Normal", cframe=CFrame.new(-10.133993148803711,27.333330154418945,22.500032424926758,1,0,0,0,1,0,0,0,1)},
    [542] = {shape="Normal", cframe=CFrame.new(-31.8441162109375,23.949689865112305,0.575653076171875,1,0,0,0,1,0,0,0,1)},
    [552] = {shape="Normal", cframe=CFrame.new(-31.8441162109375,23.949661254882812,0.3756561279296875,1,0,0,0,1,0,0,0,1)},
    [1267] = {shape="Cylinder", cframe=CFrame.new(8.505616188049316,21.157894134521484,-10.331060409545898,0,-1,-0,-1,0,-0,0,0,-1)},
    [559] = {shape="Normal", cframe=CFrame.new(-31.750673294067383,24.399688720703125,-2.7309107780456543,-0.7071342468261719,0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,-0.0001264711027033627,0.707079291343689,-0.00019253601203672588,-0.7071342468261719)},
    [1268] = {shape="Seat", cframe=CFrame.new(8.731629371643066,21.85224151611328,-10.333440780639648,0,0,-1,0,1,0,1,0,0)},
    [537] = {shape="Normal", cframe=CFrame.new(-31.984251022338867,21.501222610473633,2.6365203857421875,1,0,0,0,1,0,0,0,1)},
    [704] = {shape="Normal", cframe=CFrame.new(-9.783632278442383,22.649965286254883,-23.646028518676758,-1,0,0,0,1,0,0,0,-1)},
    [710] = {shape="Normal", cframe=CFrame.new(-14.583518981933594,21.299962997436523,36.5540771484375,-1,0,0,0,1,0,0,0,-1)},
    [1191] = {shape="Seat", cframe=CFrame.new(33.29449462890625,21.85224151611328,-13.137002944946289,-1,0,0,0,1,0,0,0,-1)},
    [712] = {shape="Normal", cframe=CFrame.new(30.6165771484375,21.574962615966797,-23.69591522216797,-1,0,0,0,1,0,0,0,-1)},
    [533] = {shape="Normal", cframe=CFrame.new(-31.984254837036133,21.49880027770996,-12.363372802734375,1,0,0,0,1,0,0,0,1)},
    [535] = {shape="Normal", cframe=CFrame.new(-31.983888626098633,21.250015258789062,-4.8635406494140625,1,0,0,0,1,0,0,0,1)},
    [918] = {shape="Normal", cframe=CFrame.new(-31.937559127807617,24.399694442749023,-20.030914306640625,0.7071342468261719,-0.00001368686935165897,-0.707079291343689,0.0001458166807424277,1,0.0001264711027033627,0.707079291343689,-0.00019253601203672588,0.7071342468261719)},
    [37] = {shape="Normal", cframe=CFrame.new(14.598143577575684,21.99289894104004,-28.407089233398438,0.017462193965911865,-0.9996950626373291,-0.017460227012634277,-0.000040650367736816406,0.017462193965911865,-0.9998475313186646,0.9998475313186646,0.017460227012634277,0.00026428699493408203)},
    [74] = {shape="Normal", cframe=CFrame.new(-13.160791397094727,23.39998435974121,18.604135513305664,0.8191556930541992,-0,-0.5735712647438049,0,1,-0,0.5735712647438049,0,0.8191556930541992)},
    [666] = {shape="Normal", cframe=CFrame.new(15.116427421569824,41.349971771240234,10.504053115844727,-1,0,0,0,1,0,0,0,-1)},
    [601] = {shape="Normal", cframe=CFrame.new(-31.844118118286133,24.39965057373047,-10.656462669372559,1,0,0,0,1,0,0,0,1)},
    [613] = {shape="Normal", cframe=CFrame.new(6.037177562713623,23.549888610839844,35.291595458984375,0.9999988079071045,-0,-0.0015537957660853863,0,1,-0,0.0015537957660853863,0,0.9999988079071045)},
    [387] = {shape="Normal", cframe=CFrame.new(0,14.999581336975098,-30,-1,0,0,0,1,0,0,0,-1)},
    [862] = {shape="Normal", cframe=CFrame.new(-14.98342514038086,38.599971771240234,10.279050827026367,-1,0,0,0,1,0,0,0,-1)},
    [693] = {shape="Normal", cframe=CFrame.new(57.54153060913086,30.049962997436523,-3.696012496948242,-1,0,0,0,1,0,0,0,-1)},
    [167] = {shape="Ball", cframe=CFrame.new(53.33576583862305,20.788236618041992,30.16757583618164,0.012777149677276611,0,0.9999183416366577,0,1,0,-0.9999183416366577,0,0.012777149677276611)},
    [191] = {shape="Normal", cframe=CFrame.new(53.66230010986328,21.23473358154297,31.410831451416016,-0.02684164047241211,0.9996397495269775,-0.000002175569534301758,-0.000002175569534301758,-0.0000022649765014648438,-1,-0.9996397495269775,-0.02684161067008972,0.0000021457672119140625)},
}
local pending = 0
for id, def in pairs(partDefs) do
    pending = pending + 1
    task.spawn(function()
        local ok, part = pcall(function() return endpoint:InvokeServer("CreatePart", def.shape, def.cframe, workspace) end)
        if ok and part then P[id] = part; syncAnchor(endpoint, part, true) end
        pending = pending - 1
    end)
end
while pending > 0 do task.wait() end

local resizeT = {}
if P[6] then resizeT[#resizeT+1] = {Part=P[6], CFrame=P[6].CFrame, Size=Vector3.new(1,2,1)} end
if P[673] then resizeT[#resizeT+1] = {Part=P[673], CFrame=P[673].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[815] then resizeT[#resizeT+1] = {Part=P[815], CFrame=P[815].CFrame, Size=Vector3.new(4.399798393249512,2.099970817565918,3.649892807006836)} end
if P[685] then resizeT[#resizeT+1] = {Part=P[685], CFrame=P[685].CFrame, Size=Vector3.new(53.299827575683594,2.9499669075012207,0.8998931646347046)} end
if P[561] then resizeT[#resizeT+1] = {Part=P[561], CFrame=P[561].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[892] then resizeT[#resizeT+1] = {Part=P[892], CFrame=P[892].CFrame, Size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)} end
if P[725] then resizeT[#resizeT+1] = {Part=P[725], CFrame=P[725].CFrame, Size=Vector3.new(73.99982452392578,1.549999475479126,1.0499999523162842)} end
if P[41] then resizeT[#resizeT+1] = {Part=P[41], CFrame=P[41].CFrame, Size=Vector3.new(0.7390000224113464,0.25999999046325684,1.2899999618530273)} end
if P[675] then resizeT[#resizeT+1] = {Part=P[675], CFrame=P[675].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[357] then resizeT[#resizeT+1] = {Part=P[357], CFrame=P[357].CFrame, Size=Vector3.new(1,2,1)} end
if P[871] then resizeT[#resizeT+1] = {Part=P[871], CFrame=P[871].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[124] then resizeT[#resizeT+1] = {Part=P[124], CFrame=P[124].CFrame, Size=Vector3.new(1.8064450025558472,0.6355556845664978,3.153334140777588)} end
if P[1201] then resizeT[#resizeT+1] = {Part=P[1201], CFrame=P[1201].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[182] then resizeT[#resizeT+1] = {Part=P[182], CFrame=P[182].CFrame, Size=Vector3.new(2.72048020362854,0.8687180876731873,2.0918993949890137)} end
if P[320] then resizeT[#resizeT+1] = {Part=P[320], CFrame=P[320].CFrame, Size=Vector3.new(1,2,1)} end
if P[855] then resizeT[#resizeT+1] = {Part=P[855], CFrame=P[855].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[1188] then resizeT[#resizeT+1] = {Part=P[1188], CFrame=P[1188].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[762] then resizeT[#resizeT+1] = {Part=P[762], CFrame=P[762].CFrame, Size=Vector3.new(40,2.4000000953674316,39)} end
if P[597] then resizeT[#resizeT+1] = {Part=P[597], CFrame=P[597].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[184] then resizeT[#resizeT+1] = {Part=P[184], CFrame=P[184].CFrame, Size=Vector3.new(1.9000009298324585,1.2000000476837158,2)} end
if P[804] then resizeT[#resizeT+1] = {Part=P[804], CFrame=P[804].CFrame, Size=Vector3.new(28.499805450439453,0.29996782541275024,0.44999998807907104)} end
if P[402] then resizeT[#resizeT+1] = {Part=P[402], CFrame=P[402].CFrame, Size=Vector3.new(2,1,1)} end
if P[569] then resizeT[#resizeT+1] = {Part=P[569], CFrame=P[569].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[582] then resizeT[#resizeT+1] = {Part=P[582], CFrame=P[582].CFrame, Size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)} end
if P[512] then resizeT[#resizeT+1] = {Part=P[512], CFrame=P[512].CFrame, Size=Vector3.new(0.08659809082746506,1.4845397472381592,1.4515492916107178)} end
if P[279] then resizeT[#resizeT+1] = {Part=P[279], CFrame=P[279].CFrame, Size=Vector3.new(0.7390000224113464,0.25999999046325684,1.2899999618530273)} end
if P[742] then resizeT[#resizeT+1] = {Part=P[742], CFrame=P[742].CFrame, Size=Vector3.new(8.29978084564209,1.5999703407287598,2.799893856048584)} end
if P[748] then resizeT[#resizeT+1] = {Part=P[748], CFrame=P[748].CFrame, Size=Vector3.new(0.44999998807907104,17.39996337890625,9.899884223937988)} end
if P[478] then resizeT[#resizeT+1] = {Part=P[478], CFrame=P[478].CFrame, Size=Vector3.new(3.8925414085388184,3.4741146564483643,3.028538703918457)} end
if P[767] then resizeT[#resizeT+1] = {Part=P[767], CFrame=P[767].CFrame, Size=Vector3.new(5.099806785583496,9.999967575073242,0.05000000074505806)} end
if P[607] then resizeT[#resizeT+1] = {Part=P[607], CFrame=P[607].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[979] then resizeT[#resizeT+1] = {Part=P[979], CFrame=P[979].CFrame, Size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)} end
if P[788] then resizeT[#resizeT+1] = {Part=P[788], CFrame=P[788].CFrame, Size=Vector3.new(12.649802207946777,1.4999711513519287,2.3998939990997314)} end
if P[1123] then resizeT[#resizeT+1] = {Part=P[1123], CFrame=P[1123].CFrame, Size=Vector3.new(0.08659809082746506,1.4845397472381592,1.4515492916107178)} end
if P[575] then resizeT[#resizeT+1] = {Part=P[575], CFrame=P[575].CFrame, Size=Vector3.new(0.10000000149011612,3.100001096725464,15.100003242492676)} end
if P[782] then resizeT[#resizeT+1] = {Part=P[782], CFrame=P[782].CFrame, Size=Vector3.new(0.44999998807907104,17.39996337890625,9.899884223937988)} end
if P[1081] then resizeT[#resizeT+1] = {Part=P[1081], CFrame=P[1081].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[1062] then resizeT[#resizeT+1] = {Part=P[1062], CFrame=P[1062].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[1017] then resizeT[#resizeT+1] = {Part=P[1017], CFrame=P[1017].CFrame, Size=Vector3.new(0.08659809082746506,1.4845397472381592,1.4515492916107178)} end
if P[868] then resizeT[#resizeT+1] = {Part=P[868], CFrame=P[868].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[1145] then resizeT[#resizeT+1] = {Part=P[1145], CFrame=P[1145].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[1263] then resizeT[#resizeT+1] = {Part=P[1263], CFrame=P[1263].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[94] then resizeT[#resizeT+1] = {Part=P[94], CFrame=P[94].CFrame, Size=Vector3.new(2.4444451332092285,4.888890266418457,2.4444451332092285)} end
if P[1239] then resizeT[#resizeT+1] = {Part=P[1239], CFrame=P[1239].CFrame, Size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)} end
if P[676] then resizeT[#resizeT+1] = {Part=P[676], CFrame=P[676].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[609] then resizeT[#resizeT+1] = {Part=P[609], CFrame=P[609].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[1001] then resizeT[#resizeT+1] = {Part=P[1001], CFrame=P[1001].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[1315] then resizeT[#resizeT+1] = {Part=P[1315], CFrame=P[1315].CFrame, Size=Vector3.new(0.05000000074505806,1.2000001668930054,3.9000000953674316)} end
if P[656] then resizeT[#resizeT+1] = {Part=P[656], CFrame=P[656].CFrame, Size=Vector3.new(0.599822998046875,20.199966430664062,66.99989318847656)} end
if P[495] then resizeT[#resizeT+1] = {Part=P[495], CFrame=P[495].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[997] then resizeT[#resizeT+1] = {Part=P[997], CFrame=P[997].CFrame, Size=Vector3.new(0.05000000074505806,2.4999709129333496,1.3998939990997314)} end
if P[733] then resizeT[#resizeT+1] = {Part=P[733], CFrame=P[733].CFrame, Size=Vector3.new(0.19978031516075134,1.5999703407287598,2.299894332885742)} end
if P[540] then resizeT[#resizeT+1] = {Part=P[540], CFrame=P[540].CFrame, Size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)} end
if P[781] then resizeT[#resizeT+1] = {Part=P[781], CFrame=P[781].CFrame, Size=Vector3.new(5.599987030029297,22.199996948242188,8)} end
if P[619] then resizeT[#resizeT+1] = {Part=P[619], CFrame=P[619].CFrame, Size=Vector3.new(0.29999905824661255,9.000004768371582,35.20002746582031)} end
if P[264] then resizeT[#resizeT+1] = {Part=P[264], CFrame=P[264].CFrame, Size=Vector3.new(1,2,1)} end
if P[441] then resizeT[#resizeT+1] = {Part=P[441], CFrame=P[441].CFrame, Size=Vector3.new(1,2,1)} end
if P[922] then resizeT[#resizeT+1] = {Part=P[922], CFrame=P[922].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[1223] then resizeT[#resizeT+1] = {Part=P[1223], CFrame=P[1223].CFrame, Size=Vector3.new(0.05000000074505806,2,0.800000011920929)} end
if P[769] then resizeT[#resizeT+1] = {Part=P[769], CFrame=P[769].CFrame, Size=Vector3.new(83.49983978271484,20.199968338012695,4.049999713897705)} end
if P[603] then resizeT[#resizeT+1] = {Part=P[603], CFrame=P[603].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[1312] then resizeT[#resizeT+1] = {Part=P[1312], CFrame=P[1312].CFrame, Size=Vector3.new(3.4865970611572266,0.2845395505428314,0.25)} end
if P[789] then resizeT[#resizeT+1] = {Part=P[789], CFrame=P[789].CFrame, Size=Vector3.new(0.05000000074505806,0.15000000596046448,0.4500000476837158)} end
if P[745] then resizeT[#resizeT+1] = {Part=P[745], CFrame=P[745].CFrame, Size=Vector3.new(7.899785041809082,1.4999691247940063,0.05000000074505806)} end
if P[812] then resizeT[#resizeT+1] = {Part=P[812], CFrame=P[812].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[898] then resizeT[#resizeT+1] = {Part=P[898], CFrame=P[898].CFrame, Size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)} end
if P[732] then resizeT[#resizeT+1] = {Part=P[732], CFrame=P[732].CFrame, Size=Vector3.new(0.19978031516075134,1.7499700784683228,0.4498937129974365)} end
if P[391] then resizeT[#resizeT+1] = {Part=P[391], CFrame=P[391].CFrame, Size=Vector3.new(1,1,1)} end
if P[681] then resizeT[#resizeT+1] = {Part=P[681], CFrame=P[681].CFrame, Size=Vector3.new(0.44999998807907104,17.39996337890625,9.899884223937988)} end
if P[309] then resizeT[#resizeT+1] = {Part=P[309], CFrame=P[309].CFrame, Size=Vector3.new(1.9700002670288086,1.809999942779541,1.4099998474121094)} end
if P[88] then resizeT[#resizeT+1] = {Part=P[88], CFrame=P[88].CFrame, Size=Vector3.new(1,1.0999999046325684,1)} end
if P[1297] then resizeT[#resizeT+1] = {Part=P[1297], CFrame=P[1297].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[213] then resizeT[#resizeT+1] = {Part=P[213], CFrame=P[213].CFrame, Size=Vector3.new(0.7390000224113464,0.25999999046325684,1.2899999618530273)} end
if P[212] then resizeT[#resizeT+1] = {Part=P[212], CFrame=P[212].CFrame, Size=Vector3.new(1,0.800000011920929,1)} end
if P[775] then resizeT[#resizeT+1] = {Part=P[775], CFrame=P[775].CFrame, Size=Vector3.new(5.099806785583496,9.999968528747559,0.05000000074505806)} end
if P[1295] then resizeT[#resizeT+1] = {Part=P[1295], CFrame=P[1295].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[728] then resizeT[#resizeT+1] = {Part=P[728], CFrame=P[728].CFrame, Size=Vector3.new(7.899777412414551,0.05000000074505806,0.19989505410194397)} end
if P[1076] then resizeT[#resizeT+1] = {Part=P[1076], CFrame=P[1076].CFrame, Size=Vector3.new(0.08659809082746506,1.4845397472381592,1.4515492916107178)} end
if P[1109] then resizeT[#resizeT+1] = {Part=P[1109], CFrame=P[1109].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[1013] then resizeT[#resizeT+1] = {Part=P[1013], CFrame=P[1013].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[1280] then resizeT[#resizeT+1] = {Part=P[1280], CFrame=P[1280].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[42] then resizeT[#resizeT+1] = {Part=P[42], CFrame=P[42].CFrame, Size=Vector3.new(1,1,1)} end
if P[313] then resizeT[#resizeT+1] = {Part=P[313], CFrame=P[313].CFrame, Size=Vector3.new(2,1,1)} end
if P[1059] then resizeT[#resizeT+1] = {Part=P[1059], CFrame=P[1059].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[227] then resizeT[#resizeT+1] = {Part=P[227], CFrame=P[227].CFrame, Size=Vector3.new(2,2,1)} end
if P[833] then resizeT[#resizeT+1] = {Part=P[833], CFrame=P[833].CFrame, Size=Vector3.new(73.99982452392578,1.549999475479126,1.0499999523162842)} end
if P[730] then resizeT[#resizeT+1] = {Part=P[730], CFrame=P[730].CFrame, Size=Vector3.new(0.19978031516075134,1.7499701976776123,0.4498937129974365)} end
if P[300] then resizeT[#resizeT+1] = {Part=P[300], CFrame=P[300].CFrame, Size=Vector3.new(2,0.33236390352249146,2)} end
if P[190] then resizeT[#resizeT+1] = {Part=P[190], CFrame=P[190].CFrame, Size=Vector3.new(0.2574584484100342,0.2579691708087921,2.2057864665985107)} end
if P[1040] then resizeT[#resizeT+1] = {Part=P[1040], CFrame=P[1040].CFrame, Size=Vector3.new(3.8925414085388184,3.4741146564483643,3.028538703918457)} end
if P[338] then resizeT[#resizeT+1] = {Part=P[338], CFrame=P[338].CFrame, Size=Vector3.new(1.9700002670288086,1.809999942779541,1.4099998474121094)} end
if P[977] then resizeT[#resizeT+1] = {Part=P[977], CFrame=P[977].CFrame, Size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)} end
if P[1331] then resizeT[#resizeT+1] = {Part=P[1331], CFrame=P[1331].CFrame, Size=Vector3.new(12,1,12)} end
if P[1329] then resizeT[#resizeT+1] = {Part=P[1329], CFrame=P[1329].CFrame, Size=Vector3.new(2.364640951156616,5.493091106414795,5.104769706726074)} end
if P[865] then resizeT[#resizeT+1] = {Part=P[865], CFrame=P[865].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[248] then resizeT[#resizeT+1] = {Part=P[248], CFrame=P[248].CFrame, Size=Vector3.new(2,1,1)} end
if P[1326] then resizeT[#resizeT+1] = {Part=P[1326], CFrame=P[1326].CFrame, Size=Vector3.new(13,9,2)} end
if P[1077] then resizeT[#resizeT+1] = {Part=P[1077], CFrame=P[1077].CFrame, Size=Vector3.new(3.4865970611572266,0.2845395505428314,0.25)} end
if P[1324] then resizeT[#resizeT+1] = {Part=P[1324], CFrame=P[1324].CFrame, Size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)} end
if P[1317] then resizeT[#resizeT+1] = {Part=P[1317], CFrame=P[1317].CFrame, Size=Vector3.new(11.100000381469727,3.8999996185302734,7.899999618530273)} end
if P[1203] then resizeT[#resizeT+1] = {Part=P[1203], CFrame=P[1203].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[245] then resizeT[#resizeT+1] = {Part=P[245], CFrame=P[245].CFrame, Size=Vector3.new(1,2,1)} end
if P[852] then resizeT[#resizeT+1] = {Part=P[852], CFrame=P[852].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[1158] then resizeT[#resizeT+1] = {Part=P[1158], CFrame=P[1158].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[47] then resizeT[#resizeT+1] = {Part=P[47], CFrame=P[47].CFrame, Size=Vector3.new(1,0.9999997615814209,1)} end
if P[869] then resizeT[#resizeT+1] = {Part=P[869], CFrame=P[869].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[740] then resizeT[#resizeT+1] = {Part=P[740], CFrame=P[740].CFrame, Size=Vector3.new(7.899777412414551,0.05000000074505806,0.19989505410194397)} end
if P[968] then resizeT[#resizeT+1] = {Part=P[968], CFrame=P[968].CFrame, Size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)} end
if P[678] then resizeT[#resizeT+1] = {Part=P[678], CFrame=P[678].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[34] then resizeT[#resizeT+1] = {Part=P[34], CFrame=P[34].CFrame, Size=Vector3.new(1,2,1)} end
if P[1310] then resizeT[#resizeT+1] = {Part=P[1310], CFrame=P[1310].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[1308] then resizeT[#resizeT+1] = {Part=P[1308], CFrame=P[1308].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[1298] then resizeT[#resizeT+1] = {Part=P[1298], CFrame=P[1298].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[1206] then resizeT[#resizeT+1] = {Part=P[1206], CFrame=P[1206].CFrame, Size=Vector3.new(0.08659809082746506,1.4845397472381592,1.4515492916107178)} end
if P[722] then resizeT[#resizeT+1] = {Part=P[722], CFrame=P[722].CFrame, Size=Vector3.new(24.249797821044922,0.15000000596046448,2.799894094467163)} end
if P[496] then resizeT[#resizeT+1] = {Part=P[496], CFrame=P[496].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[738] then resizeT[#resizeT+1] = {Part=P[738], CFrame=P[738].CFrame, Size=Vector3.new(8.29978084564209,0.1999700963497162,0.15000000596046448)} end
if P[214] then resizeT[#resizeT+1] = {Part=P[214], CFrame=P[214].CFrame, Size=Vector3.new(1,1,1)} end
if P[943] then resizeT[#resizeT+1] = {Part=P[943], CFrame=P[943].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[1293] then resizeT[#resizeT+1] = {Part=P[1293], CFrame=P[1293].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[992] then resizeT[#resizeT+1] = {Part=P[992], CFrame=P[992].CFrame, Size=Vector3.new(24.199798583984375,0.05000000074505806,1.3998939990997314)} end
if P[1282] then resizeT[#resizeT+1] = {Part=P[1282], CFrame=P[1282].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[1283] then resizeT[#resizeT+1] = {Part=P[1283], CFrame=P[1283].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[724] then resizeT[#resizeT+1] = {Part=P[724], CFrame=P[724].CFrame, Size=Vector3.new(2.400000810623169,1.549999475479126,1.899999737739563)} end
if P[687] then resizeT[#resizeT+1] = {Part=P[687], CFrame=P[687].CFrame, Size=Vector3.new(40.100006103515625,0.30000004172325134,39.20000457763672)} end
if P[674] then resizeT[#resizeT+1] = {Part=P[674], CFrame=P[674].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[1265] then resizeT[#resizeT+1] = {Part=P[1265], CFrame=P[1265].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[971] then resizeT[#resizeT+1] = {Part=P[971], CFrame=P[971].CFrame, Size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)} end
if P[1252] then resizeT[#resizeT+1] = {Part=P[1252], CFrame=P[1252].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[1248] then resizeT[#resizeT+1] = {Part=P[1248], CFrame=P[1248].CFrame, Size=Vector3.new(3.8925414085388184,3.4741146564483643,3.028538703918457)} end
if P[1242] then resizeT[#resizeT+1] = {Part=P[1242], CFrame=P[1242].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[1237] then resizeT[#resizeT+1] = {Part=P[1237], CFrame=P[1237].CFrame, Size=Vector3.new(1.6167373657226562,1.3195496797561646,1.6536812782287598)} end
if P[1236] then resizeT[#resizeT+1] = {Part=P[1236], CFrame=P[1236].CFrame, Size=Vector3.new(0.44999998807907104,3.8000006675720215,8.300000190734863)} end
if P[1234] then resizeT[#resizeT+1] = {Part=P[1234], CFrame=P[1234].CFrame, Size=Vector3.new(2.200038433074951,29.767112731933594,2.199962615966797)} end
if P[854] then resizeT[#resizeT+1] = {Part=P[854], CFrame=P[854].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[1232] then resizeT[#resizeT+1] = {Part=P[1232], CFrame=P[1232].CFrame, Size=Vector3.new(0.05000000074505806,9.149999618530273,4)} end
if P[660] then resizeT[#resizeT+1] = {Part=P[660], CFrame=P[660].CFrame, Size=Vector3.new(0.599822998046875,20.199966430664062,66.99989318847656)} end
if P[1099] then resizeT[#resizeT+1] = {Part=P[1099], CFrame=P[1099].CFrame, Size=Vector3.new(55.10002517700195,3.799999952316284,0.10000000149011612)} end
if P[679] then resizeT[#resizeT+1] = {Part=P[679], CFrame=P[679].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[1228] then resizeT[#resizeT+1] = {Part=P[1228], CFrame=P[1228].CFrame, Size=Vector3.new(2.200038433074951,83.46710205078125,2.199962615966797)} end
if P[1227] then resizeT[#resizeT+1] = {Part=P[1227], CFrame=P[1227].CFrame, Size=Vector3.new(34,21,2)} end
if P[764] then resizeT[#resizeT+1] = {Part=P[764], CFrame=P[764].CFrame, Size=Vector3.new(9.199799537658691,11.149971961975098,0.9998931884765625)} end
if P[456] then resizeT[#resizeT+1] = {Part=P[456], CFrame=P[456].CFrame, Size=Vector3.new(2.364640951156616,5.493091106414795,5.104769706726074)} end
if P[1220] then resizeT[#resizeT+1] = {Part=P[1220], CFrame=P[1220].CFrame, Size=Vector3.new(0.29999905824661255,9.000004768371582,35.20002746582031)} end
if P[467] then resizeT[#resizeT+1] = {Part=P[467], CFrame=P[467].CFrame, Size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)} end
if P[932] then resizeT[#resizeT+1] = {Part=P[932], CFrame=P[932].CFrame, Size=Vector3.new(3.7999985218048096,3.100001096725464,0.10000000149011612)} end
if P[1219] then resizeT[#resizeT+1] = {Part=P[1219], CFrame=P[1219].CFrame, Size=Vector3.new(2,2,2)} end
if P[1217] then resizeT[#resizeT+1] = {Part=P[1217], CFrame=P[1217].CFrame, Size=Vector3.new(3.8925414085388184,3.4741146564483643,3.028538703918457)} end
if P[194] then resizeT[#resizeT+1] = {Part=P[194], CFrame=P[194].CFrame, Size=Vector3.new(6.943293571472168,0.2579691708087921,3.323143482208252)} end
if P[744] then resizeT[#resizeT+1] = {Part=P[744], CFrame=P[744].CFrame, Size=Vector3.new(0.19978094100952148,1.5999690294265747,1.4998950958251953)} end
if P[472] then resizeT[#resizeT+1] = {Part=P[472], CFrame=P[472].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[877] then resizeT[#resizeT+1] = {Part=P[877], CFrame=P[877].CFrame, Size=Vector3.new(5.599987030029297,34.19999694824219,38)} end
if P[1208] then resizeT[#resizeT+1] = {Part=P[1208], CFrame=P[1208].CFrame, Size=Vector3.new(0.05000000074505806,9.149999618530273,4)} end
if P[50] then resizeT[#resizeT+1] = {Part=P[50], CFrame=P[50].CFrame, Size=Vector3.new(2,1,1)} end
if P[773] then resizeT[#resizeT+1] = {Part=P[773], CFrame=P[773].CFrame, Size=Vector3.new(23.149789810180664,0.49997109174728394,1.9998939037322998)} end
if P[1080] then resizeT[#resizeT+1] = {Part=P[1080], CFrame=P[1080].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[830] then resizeT[#resizeT+1] = {Part=P[830], CFrame=P[830].CFrame, Size=Vector3.new(27.99998664855957,13.199996948242188,30.19999885559082)} end
if P[1108] then resizeT[#resizeT+1] = {Part=P[1108], CFrame=P[1108].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[1207] then resizeT[#resizeT+1] = {Part=P[1207], CFrame=P[1207].CFrame, Size=Vector3.new(3.4865970611572266,0.2845395505428314,0.25)} end
if P[981] then resizeT[#resizeT+1] = {Part=P[981], CFrame=P[981].CFrame, Size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)} end
if P[588] then resizeT[#resizeT+1] = {Part=P[588], CFrame=P[588].CFrame, Size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)} end
if P[1205] then resizeT[#resizeT+1] = {Part=P[1205], CFrame=P[1205].CFrame, Size=Vector3.new(0.08659809082746506,3.88454008102417,3.8515496253967285)} end
if P[1314] then resizeT[#resizeT+1] = {Part=P[1314], CFrame=P[1314].CFrame, Size=Vector3.new(0.08659809082746506,3.88454008102417,3.8515496253967285)} end
if P[841] then resizeT[#resizeT+1] = {Part=P[841], CFrame=P[841].CFrame, Size=Vector3.new(4.399798393249512,11.149971961975098,0.9998931884765625)} end
if P[715] then resizeT[#resizeT+1] = {Part=P[715], CFrame=P[715].CFrame, Size=Vector3.new(0.599822998046875,10.999968528747559,4.299890518188477)} end
if P[802] then resizeT[#resizeT+1] = {Part=P[802], CFrame=P[802].CFrame, Size=Vector3.new(40.400001525878906,0.30000004172325134,39.400001525878906)} end
if P[856] then resizeT[#resizeT+1] = {Part=P[856], CFrame=P[856].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[1057] then resizeT[#resizeT+1] = {Part=P[1057], CFrame=P[1057].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[433] then resizeT[#resizeT+1] = {Part=P[433], CFrame=P[433].CFrame, Size=Vector3.new(1,2,1)} end
if P[1128] then resizeT[#resizeT+1] = {Part=P[1128], CFrame=P[1128].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[853] then resizeT[#resizeT+1] = {Part=P[853], CFrame=P[853].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[1146] then resizeT[#resizeT+1] = {Part=P[1146], CFrame=P[1146].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[202] then resizeT[#resizeT+1] = {Part=P[202], CFrame=P[202].CFrame, Size=Vector3.new(0.40000224113464355,1,0.20000000298023224)} end
if P[122] then resizeT[#resizeT+1] = {Part=P[122], CFrame=P[122].CFrame, Size=Vector3.new(2.4444451332092285,4.888890266418457,2.4444451332092285)} end
if P[1190] then resizeT[#resizeT+1] = {Part=P[1190], CFrame=P[1190].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[546] then resizeT[#resizeT+1] = {Part=P[546], CFrame=P[546].CFrame, Size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)} end
if P[1186] then resizeT[#resizeT+1] = {Part=P[1186], CFrame=P[1186].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[698] then resizeT[#resizeT+1] = {Part=P[698], CFrame=P[698].CFrame, Size=Vector3.new(5.599987030029297,13.199996948242188,38)} end
if P[640] then resizeT[#resizeT+1] = {Part=P[640], CFrame=P[640].CFrame, Size=Vector3.new(5.100012302398682,3.799999952316284,0.10000000149011612)} end
if P[848] then resizeT[#resizeT+1] = {Part=P[848], CFrame=P[848].CFrame, Size=Vector3.new(2.7997984886169434,2.349971055984497,0.10000000149011612)} end
if P[1176] then resizeT[#resizeT+1] = {Part=P[1176], CFrame=P[1176].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[556] then resizeT[#resizeT+1] = {Part=P[556], CFrame=P[556].CFrame, Size=Vector3.new(0.09999983012676239,3.100001096725464,15.100003242492676)} end
if P[1175] then resizeT[#resizeT+1] = {Part=P[1175], CFrame=P[1175].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[791] then resizeT[#resizeT+1] = {Part=P[791], CFrame=P[791].CFrame, Size=Vector3.new(84.59982299804688,20.199966430664062,0.9998931884765625)} end
if P[882] then resizeT[#resizeT+1] = {Part=P[882], CFrame=P[882].CFrame, Size=Vector3.new(4.399798393249512,11.149971961975098,0.9998931884765625)} end
if P[836] then resizeT[#resizeT+1] = {Part=P[836], CFrame=P[836].CFrame, Size=Vector3.new(0.599822998046875,20.199966430664062,22.999895095825195)} end
if P[1173] then resizeT[#resizeT+1] = {Part=P[1173], CFrame=P[1173].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[752] then resizeT[#resizeT+1] = {Part=P[752], CFrame=P[752].CFrame, Size=Vector3.new(0.09980656951665878,3.599970817565918,0.10000000894069672)} end
if P[811] then resizeT[#resizeT+1] = {Part=P[811], CFrame=P[811].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[807] then resizeT[#resizeT+1] = {Part=P[807], CFrame=P[807].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[489] then resizeT[#resizeT+1] = {Part=P[489], CFrame=P[489].CFrame, Size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)} end
if P[935] then resizeT[#resizeT+1] = {Part=P[935], CFrame=P[935].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[1160] then resizeT[#resizeT+1] = {Part=P[1160], CFrame=P[1160].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[527] then resizeT[#resizeT+1] = {Part=P[527], CFrame=P[527].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[1156] then resizeT[#resizeT+1] = {Part=P[1156], CFrame=P[1156].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[734] then resizeT[#resizeT+1] = {Part=P[734], CFrame=P[734].CFrame, Size=Vector3.new(8.24978256225586,0.10000000149011612,2.299893856048584)} end
if P[506] then resizeT[#resizeT+1] = {Part=P[506], CFrame=P[506].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[995] then resizeT[#resizeT+1] = {Part=P[995], CFrame=P[995].CFrame, Size=Vector3.new(0.05000000074505806,2.4999709129333496,1.3998939990997314)} end
if P[104] then resizeT[#resizeT+1] = {Part=P[104], CFrame=P[104].CFrame, Size=Vector3.new(4.888890266418457,4.888890266418457,2.4444451332092285)} end
if P[823] then resizeT[#resizeT+1] = {Part=P[823], CFrame=P[823].CFrame, Size=Vector3.new(2.7997984886169434,2.349971055984497,0.10000000149011612)} end
if P[1138] then resizeT[#resizeT+1] = {Part=P[1138], CFrame=P[1138].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[1127] then resizeT[#resizeT+1] = {Part=P[1127], CFrame=P[1127].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[821] then resizeT[#resizeT+1] = {Part=P[821], CFrame=P[821].CFrame, Size=Vector3.new(1.89979887008667,0.15000000596046448,0.05000000074505806)} end
if P[1125] then resizeT[#resizeT+1] = {Part=P[1125], CFrame=P[1125].CFrame, Size=Vector3.new(3.4865970611572266,0.2845395505428314,0.25)} end
if P[1015] then resizeT[#resizeT+1] = {Part=P[1015], CFrame=P[1015].CFrame, Size=Vector3.new(0.08659809082746506,3.88454008102417,3.8515496253967285)} end
if P[799] then resizeT[#resizeT+1] = {Part=P[799], CFrame=P[799].CFrame, Size=Vector3.new(17.599803924560547,11.099964141845703,0.05000000074505806)} end
if P[747] then resizeT[#resizeT+1] = {Part=P[747], CFrame=P[747].CFrame, Size=Vector3.new(0.19978031516075134,1.7499700784683228,0.4498937129974365)} end
if P[1046] then resizeT[#resizeT+1] = {Part=P[1046], CFrame=P[1046].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[185] then resizeT[#resizeT+1] = {Part=P[185], CFrame=P[185].CFrame, Size=Vector3.new(0.9293955564498901,0.4176662266254425,0.07585346698760986)} end
if P[1121] then resizeT[#resizeT+1] = {Part=P[1121], CFrame=P[1121].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[363] then resizeT[#resizeT+1] = {Part=P[363], CFrame=P[363].CFrame, Size=Vector3.new(2,1,1)} end
if P[857] then resizeT[#resizeT+1] = {Part=P[857], CFrame=P[857].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[43] then resizeT[#resizeT+1] = {Part=P[43], CFrame=P[43].CFrame, Size=Vector3.new(1.9700002670288086,1.809999942779541,1.4099998474121094)} end
if P[288] then resizeT[#resizeT+1] = {Part=P[288], CFrame=P[288].CFrame, Size=Vector3.new(1,1,1)} end
if P[902] then resizeT[#resizeT+1] = {Part=P[902], CFrame=P[902].CFrame, Size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)} end
if P[949] then resizeT[#resizeT+1] = {Part=P[949], CFrame=P[949].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[1230] then resizeT[#resizeT+1] = {Part=P[1230], CFrame=P[1230].CFrame, Size=Vector3.new(12.399999618530273,0.05000000074505806,20.399999618530273)} end
if P[739] then resizeT[#resizeT+1] = {Part=P[739], CFrame=P[739].CFrame, Size=Vector3.new(7.899779796600342,0.1999700963497162,0.05000000074505806)} end
if P[1097] then resizeT[#resizeT+1] = {Part=P[1097], CFrame=P[1097].CFrame, Size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)} end
if P[834] then resizeT[#resizeT+1] = {Part=P[834], CFrame=P[834].CFrame, Size=Vector3.new(53.3997802734375,5.849966526031494,0.9998931884765625)} end
if P[736] then resizeT[#resizeT+1] = {Part=P[736], CFrame=P[736].CFrame, Size=Vector3.new(0.19978094100952148,1.649970293045044,2.299894332885742)} end
if P[766] then resizeT[#resizeT+1] = {Part=P[766], CFrame=P[766].CFrame, Size=Vector3.new(3.399801731109619,20.199970245361328,3.3998937606811523)} end
if P[803] then resizeT[#resizeT+1] = {Part=P[803], CFrame=P[803].CFrame, Size=Vector3.new(0.30000001192092896,11.199997901916504,0.25)} end
if P[726] then resizeT[#resizeT+1] = {Part=P[726], CFrame=P[726].CFrame, Size=Vector3.new(13.099787712097168,1.099971055984497,3.8998942375183105)} end
if P[1091] then resizeT[#resizeT+1] = {Part=P[1091], CFrame=P[1091].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[795] then resizeT[#resizeT+1] = {Part=P[795], CFrame=P[795].CFrame, Size=Vector3.new(0.44999998807907104,17.39996337890625,9.899884223937988)} end
if P[548] then resizeT[#resizeT+1] = {Part=P[548], CFrame=P[548].CFrame, Size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)} end
if P[1078] then resizeT[#resizeT+1] = {Part=P[1078], CFrame=P[1078].CFrame, Size=Vector3.new(0.08659809082746506,3.88454008102417,3.8515496253967285)} end
if P[721] then resizeT[#resizeT+1] = {Part=P[721], CFrame=P[721].CFrame, Size=Vector3.new(11.949799537658691,0.15000000596046448,2.799894094467163)} end
if P[119] then resizeT[#resizeT+1] = {Part=P[119], CFrame=P[119].CFrame, Size=Vector3.new(2.4444451332092285,4.888890266418457,2.4444451332092285)} end
if P[611] then resizeT[#resizeT+1] = {Part=P[611], CFrame=P[611].CFrame, Size=Vector3.new(9,5.600000381469727,3.799999952316284)} end
if P[530] then resizeT[#resizeT+1] = {Part=P[530], CFrame=P[530].CFrame, Size=Vector3.new(12.399999618530273,0.05000000074505806,20.399999618530273)} end
if P[1278] then resizeT[#resizeT+1] = {Part=P[1278], CFrame=P[1278].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[756] then resizeT[#resizeT+1] = {Part=P[756], CFrame=P[756].CFrame, Size=Vector3.new(25.99998664855957,0.7999961972236633,9.60000228881836)} end
if P[947] then resizeT[#resizeT+1] = {Part=P[947], CFrame=P[947].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[508] then resizeT[#resizeT+1] = {Part=P[508], CFrame=P[508].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[85] then resizeT[#resizeT+1] = {Part=P[85], CFrame=P[85].CFrame, Size=Vector3.new(1,0.899999737739563,1)} end
if P[163] then resizeT[#resizeT+1] = {Part=P[163], CFrame=P[163].CFrame, Size=Vector3.new(1.4410820007324219,1.4410820007324219,1.4410820007324219)} end
if P[746] then resizeT[#resizeT+1] = {Part=P[746], CFrame=P[746].CFrame, Size=Vector3.new(7.899781227111816,1.5999703407287598,0.19989356398582458)} end
if P[1072] then resizeT[#resizeT+1] = {Part=P[1072], CFrame=P[1072].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[622] then resizeT[#resizeT+1] = {Part=P[622], CFrame=P[622].CFrame, Size=Vector3.new(5.000012397766113,3.799999952316284,0.10000000149011612)} end
if P[175] then resizeT[#resizeT+1] = {Part=P[175], CFrame=P[175].CFrame, Size=Vector3.new(1.4410820007324219,1.4410820007324219,1.4410820007324219)} end
if P[916] then resizeT[#resizeT+1] = {Part=P[916], CFrame=P[916].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[1061] then resizeT[#resizeT+1] = {Part=P[1061], CFrame=P[1061].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[1034] then resizeT[#resizeT+1] = {Part=P[1034], CFrame=P[1034].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[810] then resizeT[#resizeT+1] = {Part=P[810], CFrame=P[810].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[565] then resizeT[#resizeT+1] = {Part=P[565], CFrame=P[565].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[920] then resizeT[#resizeT+1] = {Part=P[920], CFrame=P[920].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[870] then resizeT[#resizeT+1] = {Part=P[870], CFrame=P[870].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[1124] then resizeT[#resizeT+1] = {Part=P[1124], CFrame=P[1124].CFrame, Size=Vector3.new(0.08659809082746506,3.88454008102417,3.8515496253967285)} end
if P[580] then resizeT[#resizeT+1] = {Part=P[580], CFrame=P[580].CFrame, Size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)} end
if P[261] then resizeT[#resizeT+1] = {Part=P[261], CFrame=P[261].CFrame, Size=Vector3.new(1,2,1)} end
if P[779] then resizeT[#resizeT+1] = {Part=P[779], CFrame=P[779].CFrame, Size=Vector3.new(0.4498048424720764,4.699972152709961,3.9498939514160156)} end
if P[876] then resizeT[#resizeT+1] = {Part=P[876], CFrame=P[876].CFrame, Size=Vector3.new(84.99982452392578,0.05000000074505806,65.59991455078125)} end
if P[1032] then resizeT[#resizeT+1] = {Part=P[1032], CFrame=P[1032].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[858] then resizeT[#resizeT+1] = {Part=P[858], CFrame=P[858].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[617] then resizeT[#resizeT+1] = {Part=P[617], CFrame=P[617].CFrame, Size=Vector3.new(0.05000000074505806,1.2000001668930054,3.9000000953674316)} end
if P[1020] then resizeT[#resizeT+1] = {Part=P[1020], CFrame=P[1020].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[266] then resizeT[#resizeT+1] = {Part=P[266], CFrame=P[266].CFrame, Size=Vector3.new(1,2,1)} end
if P[1019] then resizeT[#resizeT+1] = {Part=P[1019], CFrame=P[1019].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[1016] then resizeT[#resizeT+1] = {Part=P[1016], CFrame=P[1016].CFrame, Size=Vector3.new(3.4865970611572266,0.2845395505428314,0.25)} end
if P[158] then resizeT[#resizeT+1] = {Part=P[158], CFrame=P[158].CFrame, Size=Vector3.new(2.4444451332092285,4.888890266418457,2.4444451332092285)} end
if P[845] then resizeT[#resizeT+1] = {Part=P[845], CFrame=P[845].CFrame, Size=Vector3.new(2.7997984886169434,0.15000000596046448,0.10000000894069672)} end
if P[731] then resizeT[#resizeT+1] = {Part=P[731], CFrame=P[731].CFrame, Size=Vector3.new(7.899777412414551,0.05000000074505806,0.19989505410194397)} end
if P[1011] then resizeT[#resizeT+1] = {Part=P[1011], CFrame=P[1011].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[1000] then resizeT[#resizeT+1] = {Part=P[1000], CFrame=P[1000].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[996] then resizeT[#resizeT+1] = {Part=P[996], CFrame=P[996].CFrame, Size=Vector3.new(24.199798583984375,0.09997077286243439,1.3998939990997314)} end
if P[884] then resizeT[#resizeT+1] = {Part=P[884], CFrame=P[884].CFrame, Size=Vector3.new(11.899798393249512,0.05000000074505806,4.249894618988037)} end
if P[1141] then resizeT[#resizeT+1] = {Part=P[1141], CFrame=P[1141].CFrame, Size=Vector3.new(0.05000000074505806,1.1999990940093994,1.2000004053115845)} end
if P[958] then resizeT[#resizeT+1] = {Part=P[958], CFrame=P[958].CFrame, Size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)} end
if P[911] then resizeT[#resizeT+1] = {Part=P[911], CFrame=P[911].CFrame, Size=Vector3.new(3.599998950958252,2.600001335144043,14.900002479553223)} end
if P[511] then resizeT[#resizeT+1] = {Part=P[511], CFrame=P[511].CFrame, Size=Vector3.new(0.08659809082746506,3.88454008102417,3.8515496253967285)} end
if P[994] then resizeT[#resizeT+1] = {Part=P[994], CFrame=P[994].CFrame, Size=Vector3.new(24.199798583984375,0.05000000074505806,1.3998939990997314)} end
if P[993] then resizeT[#resizeT+1] = {Part=P[993], CFrame=P[993].CFrame, Size=Vector3.new(0.05000000074505806,2.4999709129333496,1.3998939990997314)} end
if P[1074] then resizeT[#resizeT+1] = {Part=P[1074], CFrame=P[1074].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[991] then resizeT[#resizeT+1] = {Part=P[991], CFrame=P[991].CFrame, Size=Vector3.new(0.05000000074505806,2.4999709129333496,1.3998939990997314)} end
if P[844] then resizeT[#resizeT+1] = {Part=P[844], CFrame=P[844].CFrame, Size=Vector3.new(2.7997984886169434,0.15000000596046448,0.05000000074505806)} end
if P[990] then resizeT[#resizeT+1] = {Part=P[990], CFrame=P[990].CFrame, Size=Vector3.new(0.05000000074505806,2.4999709129333496,1.3998939990997314)} end
if P[987] then resizeT[#resizeT+1] = {Part=P[987], CFrame=P[987].CFrame, Size=Vector3.new(20.39999771118164,0.05000000074505806,12.399998664855957)} end
if P[985] then resizeT[#resizeT+1] = {Part=P[985], CFrame=P[985].CFrame, Size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)} end
if P[964] then resizeT[#resizeT+1] = {Part=P[964], CFrame=P[964].CFrame, Size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)} end
if P[975] then resizeT[#resizeT+1] = {Part=P[975], CFrame=P[975].CFrame, Size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)} end
if P[192] then resizeT[#resizeT+1] = {Part=P[192], CFrame=P[192].CFrame, Size=Vector3.new(0.2574584484100342,0.2579691708087921,2.2051637172698975)} end
if P[973] then resizeT[#resizeT+1] = {Part=P[973], CFrame=P[973].CFrame, Size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)} end
if P[1253] then resizeT[#resizeT+1] = {Part=P[1253], CFrame=P[1253].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[310] then resizeT[#resizeT+1] = {Part=P[310], CFrame=P[310].CFrame, Size=Vector3.new(1,2,1)} end
if P[809] then resizeT[#resizeT+1] = {Part=P[809], CFrame=P[809].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[780] then resizeT[#resizeT+1] = {Part=P[780], CFrame=P[780].CFrame, Size=Vector3.new(8.299806594848633,13.999968528747559,0.05000000074505806)} end
if P[595] then resizeT[#resizeT+1] = {Part=P[595], CFrame=P[595].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[200] then resizeT[#resizeT+1] = {Part=P[200], CFrame=P[200].CFrame, Size=Vector3.new(1.2000024318695068,0.20000000298023224,0.20000000298023224)} end
if P[966] then resizeT[#resizeT+1] = {Part=P[966], CFrame=P[966].CFrame, Size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)} end
if P[429] then resizeT[#resizeT+1] = {Part=P[429], CFrame=P[429].CFrame, Size=Vector3.new(2,2,1)} end
if P[776] then resizeT[#resizeT+1] = {Part=P[776], CFrame=P[776].CFrame, Size=Vector3.new(0.09980656951665878,3.599970817565918,0.10000000894069672)} end
if P[515] then resizeT[#resizeT+1] = {Part=P[515], CFrame=P[515].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[461] then resizeT[#resizeT+1] = {Part=P[461], CFrame=P[461].CFrame, Size=Vector3.new(9,5.600000381469727,3.799999952316284)} end
if P[983] then resizeT[#resizeT+1] = {Part=P[983], CFrame=P[983].CFrame, Size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)} end
if P[669] then resizeT[#resizeT+1] = {Part=P[669], CFrame=P[669].CFrame, Size=Vector3.new(2.799802780151367,0.15000000596046448,2.799894094467163)} end
if P[786] then resizeT[#resizeT+1] = {Part=P[786], CFrame=P[786].CFrame, Size=Vector3.new(2.8498008251190186,2.7499706745147705,2.3998937606811523)} end
if P[960] then resizeT[#resizeT+1] = {Part=P[960], CFrame=P[960].CFrame, Size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)} end
if P[956] then resizeT[#resizeT+1] = {Part=P[956], CFrame=P[956].CFrame, Size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)} end
if P[72] then resizeT[#resizeT+1] = {Part=P[72], CFrame=P[72].CFrame, Size=Vector3.new(1,2,1)} end
if P[926] then resizeT[#resizeT+1] = {Part=P[926], CFrame=P[926].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[514] then resizeT[#resizeT+1] = {Part=P[514], CFrame=P[514].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[790] then resizeT[#resizeT+1] = {Part=P[790], CFrame=P[790].CFrame, Size=Vector3.new(0.4998062551021576,13.999968528747559,0.44999998807907104)} end
if P[703] then resizeT[#resizeT+1] = {Part=P[703], CFrame=P[703].CFrame, Size=Vector3.new(0.09980656951665878,3.599970817565918,0.10000000894069672)} end
if P[954] then resizeT[#resizeT+1] = {Part=P[954], CFrame=P[954].CFrame, Size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)} end
if P[714] then resizeT[#resizeT+1] = {Part=P[714], CFrame=P[714].CFrame, Size=Vector3.new(3.4998016357421875,20.199970245361328,0.15000000596046448)} end
if P[605] then resizeT[#resizeT+1] = {Part=P[605], CFrame=P[605].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[436] then resizeT[#resizeT+1] = {Part=P[436], CFrame=P[436].CFrame, Size=Vector3.new(1,2,1)} end
if P[945] then resizeT[#resizeT+1] = {Part=P[945], CFrame=P[945].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[204] then resizeT[#resizeT+1] = {Part=P[204], CFrame=P[204].CFrame, Size=Vector3.new(2,0.3323638439178467,2)} end
if P[941] then resizeT[#resizeT+1] = {Part=P[941], CFrame=P[941].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[525] then resizeT[#resizeT+1] = {Part=P[525], CFrame=P[525].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[939] then resizeT[#resizeT+1] = {Part=P[939], CFrame=P[939].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[414] then resizeT[#resizeT+1] = {Part=P[414], CFrame=P[414].CFrame, Size=Vector3.new(2,2,1)} end
if P[77] then resizeT[#resizeT+1] = {Part=P[77], CFrame=P[77].CFrame, Size=Vector3.new(1,1,1)} end
if P[664] then resizeT[#resizeT+1] = {Part=P[664], CFrame=P[664].CFrame, Size=Vector3.new(39.44981002807617,0.30000001192092896,0.25)} end
if P[1161] then resizeT[#resizeT+1] = {Part=P[1161], CFrame=P[1161].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[930] then resizeT[#resizeT+1] = {Part=P[930], CFrame=P[930].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[670] then resizeT[#resizeT+1] = {Part=P[670], CFrame=P[670].CFrame, Size=Vector3.new(11.899798393249512,0.15000000596046448,4.3998942375183105)} end
if P[928] then resizeT[#resizeT+1] = {Part=P[928], CFrame=P[928].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[573] then resizeT[#resizeT+1] = {Part=P[573], CFrame=P[573].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[924] then resizeT[#resizeT+1] = {Part=P[924], CFrame=P[924].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[1047] then resizeT[#resizeT+1] = {Part=P[1047], CFrame=P[1047].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[307] then resizeT[#resizeT+1] = {Part=P[307], CFrame=P[307].CFrame, Size=Vector3.new(35,18.200000762939453,2)} end
if P[680] then resizeT[#resizeT+1] = {Part=P[680], CFrame=P[680].CFrame, Size=Vector3.new(8.199806213378906,13.999968528747559,0.05000000074505806)} end
if P[913] then resizeT[#resizeT+1] = {Part=P[913], CFrame=P[913].CFrame, Size=Vector3.new(0.09999983012676239,3.100001096725464,15.100003242492676)} end
if P[909] then resizeT[#resizeT+1] = {Part=P[909], CFrame=P[909].CFrame, Size=Vector3.new(3.7999985218048096,3.100001096725464,0.10000000149011612)} end
if P[906] then resizeT[#resizeT+1] = {Part=P[906], CFrame=P[906].CFrame, Size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)} end
if P[904] then resizeT[#resizeT+1] = {Part=P[904], CFrame=P[904].CFrame, Size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)} end
if P[900] then resizeT[#resizeT+1] = {Part=P[900], CFrame=P[900].CFrame, Size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)} end
if P[453] then resizeT[#resizeT+1] = {Part=P[453], CFrame=P[453].CFrame, Size=Vector3.new(4,1,2)} end
if P[894] then resizeT[#resizeT+1] = {Part=P[894], CFrame=P[894].CFrame, Size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)} end
if P[890] then resizeT[#resizeT+1] = {Part=P[890], CFrame=P[890].CFrame, Size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)} end
if P[634] then resizeT[#resizeT+1] = {Part=P[634], CFrame=P[634].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[886] then resizeT[#resizeT+1] = {Part=P[886], CFrame=P[886].CFrame, Size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)} end
if P[463] then resizeT[#resizeT+1] = {Part=P[463], CFrame=P[463].CFrame, Size=Vector3.new(0.05000000074505806,1.2000001668930054,3.9000000953674316)} end
if P[1042] then resizeT[#resizeT+1] = {Part=P[1042], CFrame=P[1042].CFrame, Size=Vector3.new(2.200038433074951,29.767112731933594,2.199962615966797)} end
if P[196] then resizeT[#resizeT+1] = {Part=P[196], CFrame=P[196].CFrame, Size=Vector3.new(2.4000024795532227,0.20000000298023224,1.399998664855957)} end
if P[847] then resizeT[#resizeT+1] = {Part=P[847], CFrame=P[847].CFrame, Size=Vector3.new(1.89979887008667,0.15000000596046448,0.05000000074505806)} end
if P[567] then resizeT[#resizeT+1] = {Part=P[567], CFrame=P[567].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[554] then resizeT[#resizeT+1] = {Part=P[554], CFrame=P[554].CFrame, Size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)} end
if P[487] then resizeT[#resizeT+1] = {Part=P[487], CFrame=P[487].CFrame, Size=Vector3.new(3.8925414085388184,3.4741146564483643,3.028538703918457)} end
if P[697] then resizeT[#resizeT+1] = {Part=P[697], CFrame=P[697].CFrame, Size=Vector3.new(3.74980092048645,0.05000000074505806,2.3998937606811523)} end
if P[187] then resizeT[#resizeT+1] = {Part=P[187], CFrame=P[187].CFrame, Size=Vector3.new(3.503390073776245,3.606159210205078,3.151639461517334)} end
if P[937] then resizeT[#resizeT+1] = {Part=P[937], CFrame=P[937].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[872] then resizeT[#resizeT+1] = {Part=P[872], CFrame=P[872].CFrame, Size=Vector3.new(0.599822998046875,20.199966430664062,13.499890327453613)} end
if P[867] then resizeT[#resizeT+1] = {Part=P[867], CFrame=P[867].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[720] then resizeT[#resizeT+1] = {Part=P[720], CFrame=P[720].CFrame, Size=Vector3.new(0.09980656951665878,3.599970817565918,0.10000000894069672)} end
if P[592] then resizeT[#resizeT+1] = {Part=P[592], CFrame=P[592].CFrame, Size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)} end
if P[813] then resizeT[#resizeT+1] = {Part=P[813], CFrame=P[813].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[355] then resizeT[#resizeT+1] = {Part=P[355], CFrame=P[355].CFrame, Size=Vector3.new(1,2,1)} end
if P[828] then resizeT[#resizeT+1] = {Part=P[828], CFrame=P[828].CFrame, Size=Vector3.new(23.199798583984375,1.099971055984497,2.3998937606811523)} end
if P[370] then resizeT[#resizeT+1] = {Part=P[370], CFrame=P[370].CFrame, Size=Vector3.new(2,2,1)} end
if P[528] then resizeT[#resizeT+1] = {Part=P[528], CFrame=P[528].CFrame, Size=Vector3.new(20.39999771118164,0.05000000074505806,12.399998664855957)} end
if P[481] then resizeT[#resizeT+1] = {Part=P[481], CFrame=P[481].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[677] then resizeT[#resizeT+1] = {Part=P[677], CFrame=P[677].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[1328] then resizeT[#resizeT+1] = {Part=P[1328], CFrame=P[1328].CFrame, Size=Vector3.new(512,20,512)} end
if P[1313] then resizeT[#resizeT+1] = {Part=P[1313], CFrame=P[1313].CFrame, Size=Vector3.new(0.08659809082746506,1.4845397472381592,1.4515492916107178)} end
if P[859] then resizeT[#resizeT+1] = {Part=P[859], CFrame=P[859].CFrame, Size=Vector3.new(3.0998222827911377,20.199966430664062,30.09990119934082)} end
if P[1030] then resizeT[#resizeT+1] = {Part=P[1030], CFrame=P[1030].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[1119] then resizeT[#resizeT+1] = {Part=P[1119], CFrame=P[1119].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[850] then resizeT[#resizeT+1] = {Part=P[850], CFrame=P[850].CFrame, Size=Vector3.new(0.4498048424720764,4.699972152709961,3.9498939514160156)} end
if P[1095] then resizeT[#resizeT+1] = {Part=P[1095], CFrame=P[1095].CFrame, Size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)} end
if P[57] then resizeT[#resizeT+1] = {Part=P[57], CFrame=P[57].CFrame, Size=Vector3.new(2,2,1)} end
if P[40] then resizeT[#resizeT+1] = {Part=P[40], CFrame=P[40].CFrame, Size=Vector3.new(1,0.800000011920929,1)} end
if P[1211] then resizeT[#resizeT+1] = {Part=P[1211], CFrame=P[1211].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[827] then resizeT[#resizeT+1] = {Part=P[827], CFrame=P[827].CFrame, Size=Vector3.new(65.49999237060547,22.19999885559082,83.24991607666016)} end
if P[563] then resizeT[#resizeT+1] = {Part=P[563], CFrame=P[563].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[91] then resizeT[#resizeT+1] = {Part=P[91], CFrame=P[91].CFrame, Size=Vector3.new(1,2,1)} end
if P[896] then resizeT[#resizeT+1] = {Part=P[896], CFrame=P[896].CFrame, Size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)} end
if P[705] then resizeT[#resizeT+1] = {Part=P[705], CFrame=P[705].CFrame, Size=Vector3.new(0.599822998046875,20.0999813079834,23.59990882873535)} end
if P[825] then resizeT[#resizeT+1] = {Part=P[825], CFrame=P[825].CFrame, Size=Vector3.new(83.84977722167969,0.10000000149011612,65.59986114501953)} end
if P[1140] then resizeT[#resizeT+1] = {Part=P[1140], CFrame=P[1140].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[599] then resizeT[#resizeT+1] = {Part=P[599], CFrame=P[599].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[951] then resizeT[#resizeT+1] = {Part=P[951], CFrame=P[951].CFrame, Size=Vector3.new(0.10000000149011612,3.100001096725464,15.100003242492676)} end
if P[465] then resizeT[#resizeT+1] = {Part=P[465], CFrame=P[465].CFrame, Size=Vector3.new(1.6167373657226562,1.3195496797561646,1.6536812782287598)} end
if P[322] then resizeT[#resizeT+1] = {Part=P[322], CFrame=P[322].CFrame, Size=Vector3.new(2,2,1)} end
if P[586] then resizeT[#resizeT+1] = {Part=P[586], CFrame=P[586].CFrame, Size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)} end
if P[510] then resizeT[#resizeT+1] = {Part=P[510], CFrame=P[510].CFrame, Size=Vector3.new(3.4865970611572266,0.2845395505428314,0.25)} end
if P[438] then resizeT[#resizeT+1] = {Part=P[438], CFrame=P[438].CFrame, Size=Vector3.new(1,2,1)} end
if P[760] then resizeT[#resizeT+1] = {Part=P[760], CFrame=P[760].CFrame, Size=Vector3.new(27.99998664855957,7.299996376037598,0.8999975323677063)} end
if P[171] then resizeT[#resizeT+1] = {Part=P[171], CFrame=P[171].CFrame, Size=Vector3.new(1.4410820007324219,1.4410820007324219,1.4410820007324219)} end
if P[544] then resizeT[#resizeT+1] = {Part=P[544], CFrame=P[544].CFrame, Size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)} end
if P[571] then resizeT[#resizeT+1] = {Part=P[571], CFrame=P[571].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[584] then resizeT[#resizeT+1] = {Part=P[584], CFrame=P[584].CFrame, Size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)} end
if P[352] then resizeT[#resizeT+1] = {Part=P[352], CFrame=P[352].CFrame, Size=Vector3.new(1,2,1)} end
if P[469] then resizeT[#resizeT+1] = {Part=P[469], CFrame=P[469].CFrame, Size=Vector3.new(0.05000000074505806,2,0.800000011920929)} end
if P[242] then resizeT[#resizeT+1] = {Part=P[242], CFrame=P[242].CFrame, Size=Vector3.new(2,2,1)} end
if P[180] then resizeT[#resizeT+1] = {Part=P[180], CFrame=P[180].CFrame, Size=Vector3.new(2.7130355834960938,4.265405178070068,1.8006649017333984)} end
if P[819] then resizeT[#resizeT+1] = {Part=P[819], CFrame=P[819].CFrame, Size=Vector3.new(2.7997984886169434,0.15000000596046448,0.10000000894069672)} end
if P[97] then resizeT[#resizeT+1] = {Part=P[97], CFrame=P[97].CFrame, Size=Vector3.new(4.888890266418457,2.4444451332092285,2.4444451332092285)} end
if P[459] then resizeT[#resizeT+1] = {Part=P[459], CFrame=P[459].CFrame, Size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)} end
if P[348] then resizeT[#resizeT+1] = {Part=P[348], CFrame=P[348].CFrame, Size=Vector3.new(1,2,1)} end
if P[875] then resizeT[#resizeT+1] = {Part=P[875], CFrame=P[875].CFrame, Size=Vector3.new(0.4998062551021576,13.999968528747559,0.44999998807907104)} end
if P[735] then resizeT[#resizeT+1] = {Part=P[735], CFrame=P[735].CFrame, Size=Vector3.new(0.19978094100952148,1.5999690294265747,1.4998950958251953)} end
if P[491] then resizeT[#resizeT+1] = {Part=P[491], CFrame=P[491].CFrame, Size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)} end
if P[360] then resizeT[#resizeT+1] = {Part=P[360], CFrame=P[360].CFrame, Size=Vector3.new(1,2,1)} end
if P[817] then resizeT[#resizeT+1] = {Part=P[817], CFrame=P[817].CFrame, Size=Vector3.new(0.05000000074505806,0.15000000596046448,0.4500000476837158)} end
if P[814] then resizeT[#resizeT+1] = {Part=P[814], CFrame=P[814].CFrame, Size=Vector3.new(37.59980773925781,4.699972152709961,0.3998934030532837)} end
if P[590] then resizeT[#resizeT+1] = {Part=P[590], CFrame=P[590].CFrame, Size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)} end
if P[753] then resizeT[#resizeT+1] = {Part=P[753], CFrame=P[753].CFrame, Size=Vector3.new(17.599803924560547,11.099964141845703,0.05000000074505806)} end
if P[1171] then resizeT[#resizeT+1] = {Part=P[1171], CFrame=P[1171].CFrame, Size=Vector3.new(2.496410846710205,2.333836078643799,1.7497196197509766)} end
if P[615] then resizeT[#resizeT+1] = {Part=P[615], CFrame=P[615].CFrame, Size=Vector3.new(1.1000374555587769,0.05000000074505806,1.100000023841858)} end
if P[32] then resizeT[#resizeT+1] = {Part=P[32], CFrame=P[32].CFrame, Size=Vector3.new(1,1.899999976158142,1)} end
if P[808] then resizeT[#resizeT+1] = {Part=P[808], CFrame=P[808].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[647] then resizeT[#resizeT+1] = {Part=P[647], CFrame=P[647].CFrame, Size=Vector3.new(5.000012397766113,3.799999952316284,0.10000000149011612)} end
if P[16] then resizeT[#resizeT+1] = {Part=P[16], CFrame=P[16].CFrame, Size=Vector3.new(2,1.6999999284744263,1)} end
if P[729] then resizeT[#resizeT+1] = {Part=P[729], CFrame=P[729].CFrame, Size=Vector3.new(7.899782180786133,1.7499700784683228,0.05000000074505806)} end
if P[445] then resizeT[#resizeT+1] = {Part=P[445], CFrame=P[445].CFrame, Size=Vector3.new(1,1,1)} end
if P[632] then resizeT[#resizeT+1] = {Part=P[632], CFrame=P[632].CFrame, Size=Vector3.new(3.8925414085388184,3.4741146564483643,3.028538703918457)} end
if P[741] then resizeT[#resizeT+1] = {Part=P[741], CFrame=P[741].CFrame, Size=Vector3.new(7.899777412414551,0.10000000149011612,1.4998950958251953)} end
if P[385] then resizeT[#resizeT+1] = {Part=P[385], CFrame=P[385].CFrame, Size=Vector3.new(1,2,1)} end
if P[655] then resizeT[#resizeT+1] = {Part=P[655], CFrame=P[655].CFrame, Size=Vector3.new(0.30000001192092896,11.199997901916504,0.25)} end
if P[193] then resizeT[#resizeT+1] = {Part=P[193], CFrame=P[193].CFrame, Size=Vector3.new(0.2574584484100342,0.2579691708087921,2.197343587875366)} end
if P[774] then resizeT[#resizeT+1] = {Part=P[774], CFrame=P[774].CFrame, Size=Vector3.new(3.899998664855957,1.0999999046325684,1.350000262260437)} end
if P[629] then resizeT[#resizeT+1] = {Part=P[629], CFrame=P[629].CFrame, Size=Vector3.new(0.05000000074505806,9.149999618530273,4)} end
if P[688] then resizeT[#resizeT+1] = {Part=P[688], CFrame=P[688].CFrame, Size=Vector3.new(47.79981994628906,6.899966239929199,1.9998958110809326)} end
if P[962] then resizeT[#resizeT+1] = {Part=P[962], CFrame=P[962].CFrame, Size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)} end
if P[777] then resizeT[#resizeT+1] = {Part=P[777], CFrame=P[777].CFrame, Size=Vector3.new(6.149801254272461,0.15000000596046448,4.3998942375183105)} end
if P[822] then resizeT[#resizeT+1] = {Part=P[822], CFrame=P[822].CFrame, Size=Vector3.new(2.7997984886169434,0.15000000596046448,0.05000000074505806)} end
if P[829] then resizeT[#resizeT+1] = {Part=P[829], CFrame=P[829].CFrame, Size=Vector3.new(3.399801731109619,20.39997100830078,3.3998937606811523)} end
if P[768] then resizeT[#resizeT+1] = {Part=P[768], CFrame=P[768].CFrame, Size=Vector3.new(3.4998016357421875,20.199970245361328,0.15000000596046448)} end
if P[668] then resizeT[#resizeT+1] = {Part=P[668], CFrame=P[668].CFrame, Size=Vector3.new(10.349809646606445,3.699967384338379,0.05000000074505806)} end
if P[866] then resizeT[#resizeT+1] = {Part=P[866], CFrame=P[866].CFrame, Size=Vector3.new(23.699804306030273,0.05000000074505806,0.9998931884765625)} end
if P[778] then resizeT[#resizeT+1] = {Part=P[778], CFrame=P[778].CFrame, Size=Vector3.new(10.599793434143066,2.099971294403076,2.3998939990997314)} end
if P[578] then resizeT[#resizeT+1] = {Part=P[578], CFrame=P[578].CFrame, Size=Vector3.new(3.640012264251709,2.800008535385132,0.05000000074505806)} end
if P[1093] then resizeT[#resizeT+1] = {Part=P[1093], CFrame=P[1093].CFrame, Size=Vector3.new(0.08659809082746506,2.684540271759033,2.2515499591827393)} end
if P[1225] then resizeT[#resizeT+1] = {Part=P[1225], CFrame=P[1225].CFrame, Size=Vector3.new(0.05000000074505806,1.1999990940093994,1.2000004053115845)} end
if P[9] then resizeT[#resizeT+1] = {Part=P[9], CFrame=P[9].CFrame, Size=Vector3.new(2,1,1)} end
if P[550] then resizeT[#resizeT+1] = {Part=P[550], CFrame=P[550].CFrame, Size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)} end
if P[271] then resizeT[#resizeT+1] = {Part=P[271], CFrame=P[271].CFrame, Size=Vector3.new(1,0.800000011920929,1)} end
if P[743] then resizeT[#resizeT+1] = {Part=P[743], CFrame=P[743].CFrame, Size=Vector3.new(0.19978031516075134,1.7499700784683228,0.4498937129974365)} end
if P[787] then resizeT[#resizeT+1] = {Part=P[787], CFrame=P[787].CFrame, Size=Vector3.new(0.05000000074505806,0.15000000596046448,0.4500000476837158)} end
if P[737] then resizeT[#resizeT+1] = {Part=P[737], CFrame=P[737].CFrame, Size=Vector3.new(7.899777412414551,0.10000000149011612,1.4998950958251953)} end
if P[888] then resizeT[#resizeT+1] = {Part=P[888], CFrame=P[888].CFrame, Size=Vector3.new(1.600000023841858,6.500000476837158,1.600000023841858)} end
if P[296] then resizeT[#resizeT+1] = {Part=P[296], CFrame=P[296].CFrame, Size=Vector3.new(4.888890266418457,4.888890266418457,2.4444451332092285)} end
if P[542] then resizeT[#resizeT+1] = {Part=P[542], CFrame=P[542].CFrame, Size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)} end
if P[552] then resizeT[#resizeT+1] = {Part=P[552], CFrame=P[552].CFrame, Size=Vector3.new(3.6400115489959717,2.8000082969665527,0.05000000074505806)} end
if P[1267] then resizeT[#resizeT+1] = {Part=P[1267], CFrame=P[1267].CFrame, Size=Vector3.new(2.1953647136688232,0.2597942054271698,0.2597942054271698)} end
if P[559] then resizeT[#resizeT+1] = {Part=P[559], CFrame=P[559].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[1268] then resizeT[#resizeT+1] = {Part=P[1268], CFrame=P[1268].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[537] then resizeT[#resizeT+1] = {Part=P[537], CFrame=P[537].CFrame, Size=Vector3.new(3.7999985218048096,3.100001096725464,0.10000000149011612)} end
if P[704] then resizeT[#resizeT+1] = {Part=P[704], CFrame=P[704].CFrame, Size=Vector3.new(0.05000000074505806,0.15000000596046448,0.4500000476837158)} end
if P[710] then resizeT[#resizeT+1] = {Part=P[710], CFrame=P[710].CFrame, Size=Vector3.new(24.199798583984375,2.4999709129333496,2.3998939990997314)} end
if P[1191] then resizeT[#resizeT+1] = {Part=P[1191], CFrame=P[1191].CFrame, Size=Vector3.new(0.7360836267471313,0.8659809231758118,1.7319618463516235)} end
if P[712] then resizeT[#resizeT+1] = {Part=P[712], CFrame=P[712].CFrame, Size=Vector3.new(53.39982604980469,3.249966621398926,0.9998931884765625)} end
if P[533] then resizeT[#resizeT+1] = {Part=P[533], CFrame=P[533].CFrame, Size=Vector3.new(3.7999985218048096,3.100001096725464,0.10000000149011612)} end
if P[535] then resizeT[#resizeT+1] = {Part=P[535], CFrame=P[535].CFrame, Size=Vector3.new(3.599998950958252,2.600001335144043,14.900002479553223)} end
if P[918] then resizeT[#resizeT+1] = {Part=P[918], CFrame=P[918].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[37] then resizeT[#resizeT+1] = {Part=P[37], CFrame=P[37].CFrame, Size=Vector3.new(1,2,1)} end
if P[74] then resizeT[#resizeT+1] = {Part=P[74], CFrame=P[74].CFrame, Size=Vector3.new(1,0.9999998807907104,1)} end
if P[666] then resizeT[#resizeT+1] = {Part=P[666], CFrame=P[666].CFrame, Size=Vector3.new(86.19982147216797,2.399996280670166,65.59991455078125)} end
if P[601] then resizeT[#resizeT+1] = {Part=P[601], CFrame=P[601].CFrame, Size=Vector3.new(4.809786796569824,3.6998350620269775,0.06606828421354294)} end
if P[613] then resizeT[#resizeT+1] = {Part=P[613], CFrame=P[613].CFrame, Size=Vector3.new(0.05000000074505806,2,0.800000011920929)} end
if P[387] then resizeT[#resizeT+1] = {Part=P[387], CFrame=P[387].CFrame, Size=Vector3.new(1,1,1)} end
if P[862] then resizeT[#resizeT+1] = {Part=P[862], CFrame=P[862].CFrame, Size=Vector3.new(4.399798393249512,2.099970817565918,3.649892807006836)} end
if P[693] then resizeT[#resizeT+1] = {Part=P[693], CFrame=P[693].CFrame, Size=Vector3.new(0.44999998807907104,17.39996337890625,9.899884223937988)} end
if P[167] then resizeT[#resizeT+1] = {Part=P[167], CFrame=P[167].CFrame, Size=Vector3.new(1.4410820007324219,1.4410820007324219,1.4410820007324219)} end
if P[191] then resizeT[#resizeT+1] = {Part=P[191], CFrame=P[191].CFrame, Size=Vector3.new(0.2574584484100342,0.2579691708087921,2.2013368606567383)} end
bResize(endpoint, resizeT)
local matT = {}
if P[6] then matT[#matT+1] = {Part=P[6], Material=Enum.Material.Plastic} end
if P[673] then matT[#matT+1] = {Part=P[673], Material=Enum.Material.Wood} end
if P[815] then matT[#matT+1] = {Part=P[815], Material=Enum.Material.Metal} end
if P[685] then matT[#matT+1] = {Part=P[685], Material=Enum.Material.Brick} end
if P[561] then matT[#matT+1] = {Part=P[561], Material=Enum.Material.Fabric} end
if P[892] then matT[#matT+1] = {Part=P[892], Material=Enum.Material.Plastic} end
if P[725] then matT[#matT+1] = {Part=P[725], Material=Enum.Material.Glass} end
if P[41] then matT[#matT+1] = {Part=P[41], Material=Enum.Material.Plastic} end
if P[675] then matT[#matT+1] = {Part=P[675], Material=Enum.Material.Wood} end
if P[357] then matT[#matT+1] = {Part=P[357], Material=Enum.Material.Plastic} end
if P[871] then matT[#matT+1] = {Part=P[871], Material=Enum.Material.Wood} end
if P[124] then matT[#matT+1] = {Part=P[124], Material=Enum.Material.Plastic} end
if P[1201] then matT[#matT+1] = {Part=P[1201], Material=Enum.Material.Glass} end
if P[182] then matT[#matT+1] = {Part=P[182], Material=Enum.Material.Fabric} end
if P[320] then matT[#matT+1] = {Part=P[320], Material=Enum.Material.Plastic} end
if P[855] then matT[#matT+1] = {Part=P[855], Material=Enum.Material.Wood} end
if P[1188] then matT[#matT+1] = {Part=P[1188], Material=Enum.Material.Metal} end
if P[762] then matT[#matT+1] = {Part=P[762], Material=Enum.Material.Concrete} end
if P[597] then matT[#matT+1] = {Part=P[597], Material=Enum.Material.Fabric} end
if P[184] then matT[#matT+1] = {Part=P[184], Material=Enum.Material.Plastic} end
if P[804] then matT[#matT+1] = {Part=P[804], Material=Enum.Material.Metal} end
if P[402] then matT[#matT+1] = {Part=P[402], Material=Enum.Material.Plastic} end
if P[569] then matT[#matT+1] = {Part=P[569], Material=Enum.Material.Fabric} end
if P[582] then matT[#matT+1] = {Part=P[582], Material=Enum.Material.Fabric} end
if P[512] then matT[#matT+1] = {Part=P[512], Material=Enum.Material.Metal} end
if P[279] then matT[#matT+1] = {Part=P[279], Material=Enum.Material.Plastic} end
if P[742] then matT[#matT+1] = {Part=P[742], Material=Enum.Material.Glass} end
if P[748] then matT[#matT+1] = {Part=P[748], Material=Enum.Material.Concrete} end
if P[478] then matT[#matT+1] = {Part=P[478], Material=Enum.Material.Plastic} end
if P[767] then matT[#matT+1] = {Part=P[767], Material=Enum.Material.SmoothPlastic} end
if P[607] then matT[#matT+1] = {Part=P[607], Material=Enum.Material.Fabric} end
if P[979] then matT[#matT+1] = {Part=P[979], Material=Enum.Material.Fabric} end
if P[788] then matT[#matT+1] = {Part=P[788], Material=Enum.Material.Wood} end
if P[1123] then matT[#matT+1] = {Part=P[1123], Material=Enum.Material.Metal} end
if P[575] then matT[#matT+1] = {Part=P[575], Material=Enum.Material.WoodPlanks} end
if P[782] then matT[#matT+1] = {Part=P[782], Material=Enum.Material.Concrete} end
if P[1081] then matT[#matT+1] = {Part=P[1081], Material=Enum.Material.Plastic} end
if P[1062] then matT[#matT+1] = {Part=P[1062], Material=Enum.Material.Plastic} end
if P[1017] then matT[#matT+1] = {Part=P[1017], Material=Enum.Material.Metal} end
if P[868] then matT[#matT+1] = {Part=P[868], Material=Enum.Material.Wood} end
if P[1145] then matT[#matT+1] = {Part=P[1145], Material=Enum.Material.Metal} end
if P[1263] then matT[#matT+1] = {Part=P[1263], Material=Enum.Material.Glass} end
if P[94] then matT[#matT+1] = {Part=P[94], Material=Enum.Material.Plastic} end
if P[1239] then matT[#matT+1] = {Part=P[1239], Material=Enum.Material.Neon} end
if P[676] then matT[#matT+1] = {Part=P[676], Material=Enum.Material.Wood} end
if P[609] then matT[#matT+1] = {Part=P[609], Material=Enum.Material.Fabric} end
if P[1001] then matT[#matT+1] = {Part=P[1001], Material=Enum.Material.Plastic} end
if P[1315] then matT[#matT+1] = {Part=P[1315], Material=Enum.Material.Metal} end
if P[656] then matT[#matT+1] = {Part=P[656], Material=Enum.Material.Concrete} end
if P[495] then matT[#matT+1] = {Part=P[495], Material=Enum.Material.Metal} end
if P[997] then matT[#matT+1] = {Part=P[997], Material=Enum.Material.Wood} end
if P[733] then matT[#matT+1] = {Part=P[733], Material=Enum.Material.Glass} end
if P[540] then matT[#matT+1] = {Part=P[540], Material=Enum.Material.Fabric} end
if P[781] then matT[#matT+1] = {Part=P[781], Material=Enum.Material.Concrete} end
if P[619] then matT[#matT+1] = {Part=P[619], Material=Enum.Material.Metal} end
if P[264] then matT[#matT+1] = {Part=P[264], Material=Enum.Material.Plastic} end
if P[441] then matT[#matT+1] = {Part=P[441], Material=Enum.Material.Plastic} end
if P[922] then matT[#matT+1] = {Part=P[922], Material=Enum.Material.Fabric} end
if P[1223] then matT[#matT+1] = {Part=P[1223], Material=Enum.Material.Metal} end
if P[769] then matT[#matT+1] = {Part=P[769], Material=Enum.Material.Concrete} end
if P[603] then matT[#matT+1] = {Part=P[603], Material=Enum.Material.Fabric} end
if P[1312] then matT[#matT+1] = {Part=P[1312], Material=Enum.Material.Metal} end
if P[789] then matT[#matT+1] = {Part=P[789], Material=Enum.Material.Glass} end
if P[745] then matT[#matT+1] = {Part=P[745], Material=Enum.Material.Glass} end
if P[812] then matT[#matT+1] = {Part=P[812], Material=Enum.Material.Wood} end
if P[898] then matT[#matT+1] = {Part=P[898], Material=Enum.Material.Plastic} end
if P[732] then matT[#matT+1] = {Part=P[732], Material=Enum.Material.Glass} end
if P[391] then matT[#matT+1] = {Part=P[391], Material=Enum.Material.Plastic} end
if P[681] then matT[#matT+1] = {Part=P[681], Material=Enum.Material.Concrete} end
if P[309] then matT[#matT+1] = {Part=P[309], Material=Enum.Material.Plastic} end
if P[88] then matT[#matT+1] = {Part=P[88], Material=Enum.Material.Plastic} end
if P[1297] then matT[#matT+1] = {Part=P[1297], Material=Enum.Material.Metal} end
if P[213] then matT[#matT+1] = {Part=P[213], Material=Enum.Material.Plastic} end
if P[212] then matT[#matT+1] = {Part=P[212], Material=Enum.Material.Plastic} end
if P[775] then matT[#matT+1] = {Part=P[775], Material=Enum.Material.SmoothPlastic} end
if P[1295] then matT[#matT+1] = {Part=P[1295], Material=Enum.Material.Metal} end
if P[728] then matT[#matT+1] = {Part=P[728], Material=Enum.Material.Neon} end
if P[1076] then matT[#matT+1] = {Part=P[1076], Material=Enum.Material.Metal} end
if P[1109] then matT[#matT+1] = {Part=P[1109], Material=Enum.Material.Plastic} end
if P[1013] then matT[#matT+1] = {Part=P[1013], Material=Enum.Material.Metal} end
if P[1280] then matT[#matT+1] = {Part=P[1280], Material=Enum.Material.Metal} end
if P[42] then matT[#matT+1] = {Part=P[42], Material=Enum.Material.Plastic} end
if P[313] then matT[#matT+1] = {Part=P[313], Material=Enum.Material.Plastic} end
if P[1059] then matT[#matT+1] = {Part=P[1059], Material=Enum.Material.Metal} end
if P[227] then matT[#matT+1] = {Part=P[227], Material=Enum.Material.Plastic} end
if P[833] then matT[#matT+1] = {Part=P[833], Material=Enum.Material.Glass} end
if P[730] then matT[#matT+1] = {Part=P[730], Material=Enum.Material.Glass} end
if P[300] then matT[#matT+1] = {Part=P[300], Material=Enum.Material.Concrete} end
if P[190] then matT[#matT+1] = {Part=P[190], Material=Enum.Material.SmoothPlastic} end
if P[1040] then matT[#matT+1] = {Part=P[1040], Material=Enum.Material.Plastic} end
if P[338] then matT[#matT+1] = {Part=P[338], Material=Enum.Material.Plastic} end
if P[977] then matT[#matT+1] = {Part=P[977], Material=Enum.Material.Fabric} end
if P[1331] then matT[#matT+1] = {Part=P[1331], Material=Enum.Material.Plastic} end
if P[1329] then matT[#matT+1] = {Part=P[1329], Material=Enum.Material.Plastic} end
if P[865] then matT[#matT+1] = {Part=P[865], Material=Enum.Material.Wood} end
if P[248] then matT[#matT+1] = {Part=P[248], Material=Enum.Material.Plastic} end
if P[1326] then matT[#matT+1] = {Part=P[1326], Material=Enum.Material.Neon} end
if P[1077] then matT[#matT+1] = {Part=P[1077], Material=Enum.Material.Metal} end
if P[1324] then matT[#matT+1] = {Part=P[1324], Material=Enum.Material.Neon} end
if P[1317] then matT[#matT+1] = {Part=P[1317], Material=Enum.Material.Glass} end
if P[1203] then matT[#matT+1] = {Part=P[1203], Material=Enum.Material.Metal} end
if P[245] then matT[#matT+1] = {Part=P[245], Material=Enum.Material.Plastic} end
if P[852] then matT[#matT+1] = {Part=P[852], Material=Enum.Material.Wood} end
if P[1158] then matT[#matT+1] = {Part=P[1158], Material=Enum.Material.Metal} end
if P[47] then matT[#matT+1] = {Part=P[47], Material=Enum.Material.Plastic} end
if P[869] then matT[#matT+1] = {Part=P[869], Material=Enum.Material.Wood} end
if P[740] then matT[#matT+1] = {Part=P[740], Material=Enum.Material.Neon} end
if P[968] then matT[#matT+1] = {Part=P[968], Material=Enum.Material.Fabric} end
if P[678] then matT[#matT+1] = {Part=P[678], Material=Enum.Material.Wood} end
if P[34] then matT[#matT+1] = {Part=P[34], Material=Enum.Material.Plastic} end
if P[1310] then matT[#matT+1] = {Part=P[1310], Material=Enum.Material.Metal} end
if P[1308] then matT[#matT+1] = {Part=P[1308], Material=Enum.Material.Glass} end
if P[1298] then matT[#matT+1] = {Part=P[1298], Material=Enum.Material.Plastic} end
if P[1206] then matT[#matT+1] = {Part=P[1206], Material=Enum.Material.Metal} end
if P[722] then matT[#matT+1] = {Part=P[722], Material=Enum.Material.Glass} end
if P[496] then matT[#matT+1] = {Part=P[496], Material=Enum.Material.Plastic} end
if P[738] then matT[#matT+1] = {Part=P[738], Material=Enum.Material.Glass} end
if P[214] then matT[#matT+1] = {Part=P[214], Material=Enum.Material.Plastic} end
if P[943] then matT[#matT+1] = {Part=P[943], Material=Enum.Material.Fabric} end
if P[1293] then matT[#matT+1] = {Part=P[1293], Material=Enum.Material.Glass} end
if P[992] then matT[#matT+1] = {Part=P[992], Material=Enum.Material.Wood} end
if P[1282] then matT[#matT+1] = {Part=P[1282], Material=Enum.Material.Metal} end
if P[1283] then matT[#matT+1] = {Part=P[1283], Material=Enum.Material.Plastic} end
if P[724] then matT[#matT+1] = {Part=P[724], Material=Enum.Material.Wood} end
if P[687] then matT[#matT+1] = {Part=P[687], Material=Enum.Material.Metal} end
if P[674] then matT[#matT+1] = {Part=P[674], Material=Enum.Material.Wood} end
if P[1265] then matT[#matT+1] = {Part=P[1265], Material=Enum.Material.Metal} end
if P[971] then matT[#matT+1] = {Part=P[971], Material=Enum.Material.Fabric} end
if P[1252] then matT[#matT+1] = {Part=P[1252], Material=Enum.Material.Metal} end
if P[1248] then matT[#matT+1] = {Part=P[1248], Material=Enum.Material.Plastic} end
if P[1242] then matT[#matT+1] = {Part=P[1242], Material=Enum.Material.Plastic} end
if P[1237] then matT[#matT+1] = {Part=P[1237], Material=Enum.Material.Plastic} end
if P[1236] then matT[#matT+1] = {Part=P[1236], Material=Enum.Material.SmoothPlastic} end
if P[1234] then matT[#matT+1] = {Part=P[1234], Material=Enum.Material.Metal} end
if P[854] then matT[#matT+1] = {Part=P[854], Material=Enum.Material.Wood} end
if P[1232] then matT[#matT+1] = {Part=P[1232], Material=Enum.Material.Metal} end
if P[660] then matT[#matT+1] = {Part=P[660], Material=Enum.Material.Concrete} end
if P[1099] then matT[#matT+1] = {Part=P[1099], Material=Enum.Material.SmoothPlastic} end
if P[679] then matT[#matT+1] = {Part=P[679], Material=Enum.Material.Wood} end
if P[1228] then matT[#matT+1] = {Part=P[1228], Material=Enum.Material.Metal} end
if P[1227] then matT[#matT+1] = {Part=P[1227], Material=Enum.Material.Plastic} end
if P[764] then matT[#matT+1] = {Part=P[764], Material=Enum.Material.Concrete} end
if P[456] then matT[#matT+1] = {Part=P[456], Material=Enum.Material.Plastic} end
if P[1220] then matT[#matT+1] = {Part=P[1220], Material=Enum.Material.Metal} end
if P[467] then matT[#matT+1] = {Part=P[467], Material=Enum.Material.Neon} end
if P[932] then matT[#matT+1] = {Part=P[932], Material=Enum.Material.WoodPlanks} end
if P[1219] then matT[#matT+1] = {Part=P[1219], Material=Enum.Material.Brick} end
if P[1217] then matT[#matT+1] = {Part=P[1217], Material=Enum.Material.Plastic} end
if P[194] then matT[#matT+1] = {Part=P[194], Material=Enum.Material.SmoothPlastic} end
if P[744] then matT[#matT+1] = {Part=P[744], Material=Enum.Material.Glass} end
if P[472] then matT[#matT+1] = {Part=P[472], Material=Enum.Material.Plastic} end
if P[877] then matT[#matT+1] = {Part=P[877], Material=Enum.Material.Concrete} end
if P[1208] then matT[#matT+1] = {Part=P[1208], Material=Enum.Material.Metal} end
if P[50] then matT[#matT+1] = {Part=P[50], Material=Enum.Material.Plastic} end
if P[773] then matT[#matT+1] = {Part=P[773], Material=Enum.Material.Metal} end
if P[1080] then matT[#matT+1] = {Part=P[1080], Material=Enum.Material.Metal} end
if P[830] then matT[#matT+1] = {Part=P[830], Material=Enum.Material.Concrete} end
if P[1108] then matT[#matT+1] = {Part=P[1108], Material=Enum.Material.Metal} end
if P[1207] then matT[#matT+1] = {Part=P[1207], Material=Enum.Material.Metal} end
if P[981] then matT[#matT+1] = {Part=P[981], Material=Enum.Material.Fabric} end
if P[588] then matT[#matT+1] = {Part=P[588], Material=Enum.Material.Fabric} end
if P[1205] then matT[#matT+1] = {Part=P[1205], Material=Enum.Material.Metal} end
if P[1314] then matT[#matT+1] = {Part=P[1314], Material=Enum.Material.Metal} end
if P[841] then matT[#matT+1] = {Part=P[841], Material=Enum.Material.Concrete} end
if P[715] then matT[#matT+1] = {Part=P[715], Material=Enum.Material.Concrete} end
if P[802] then matT[#matT+1] = {Part=P[802], Material=Enum.Material.Neon} end
if P[856] then matT[#matT+1] = {Part=P[856], Material=Enum.Material.Wood} end
if P[1057] then matT[#matT+1] = {Part=P[1057], Material=Enum.Material.Glass} end
if P[433] then matT[#matT+1] = {Part=P[433], Material=Enum.Material.Plastic} end
if P[1128] then matT[#matT+1] = {Part=P[1128], Material=Enum.Material.Plastic} end
if P[853] then matT[#matT+1] = {Part=P[853], Material=Enum.Material.Wood} end
if P[1146] then matT[#matT+1] = {Part=P[1146], Material=Enum.Material.Plastic} end
if P[202] then matT[#matT+1] = {Part=P[202], Material=Enum.Material.SmoothPlastic} end
if P[122] then matT[#matT+1] = {Part=P[122], Material=Enum.Material.Plastic} end
if P[1190] then matT[#matT+1] = {Part=P[1190], Material=Enum.Material.Metal} end
if P[546] then matT[#matT+1] = {Part=P[546], Material=Enum.Material.Fabric} end
if P[1186] then matT[#matT+1] = {Part=P[1186], Material=Enum.Material.Glass} end
if P[698] then matT[#matT+1] = {Part=P[698], Material=Enum.Material.Concrete} end
if P[640] then matT[#matT+1] = {Part=P[640], Material=Enum.Material.SmoothPlastic} end
if P[848] then matT[#matT+1] = {Part=P[848], Material=Enum.Material.Metal} end
if P[1176] then matT[#matT+1] = {Part=P[1176], Material=Enum.Material.Plastic} end
if P[556] then matT[#matT+1] = {Part=P[556], Material=Enum.Material.WoodPlanks} end
if P[1175] then matT[#matT+1] = {Part=P[1175], Material=Enum.Material.Metal} end
if P[791] then matT[#matT+1] = {Part=P[791], Material=Enum.Material.Concrete} end
if P[882] then matT[#matT+1] = {Part=P[882], Material=Enum.Material.Concrete} end
if P[836] then matT[#matT+1] = {Part=P[836], Material=Enum.Material.Concrete} end
if P[1173] then matT[#matT+1] = {Part=P[1173], Material=Enum.Material.Metal} end
if P[752] then matT[#matT+1] = {Part=P[752], Material=Enum.Material.Glass} end
if P[811] then matT[#matT+1] = {Part=P[811], Material=Enum.Material.Wood} end
if P[807] then matT[#matT+1] = {Part=P[807], Material=Enum.Material.Wood} end
if P[489] then matT[#matT+1] = {Part=P[489], Material=Enum.Material.Neon} end
if P[935] then matT[#matT+1] = {Part=P[935], Material=Enum.Material.Fabric} end
if P[1160] then matT[#matT+1] = {Part=P[1160], Material=Enum.Material.Metal} end
if P[527] then matT[#matT+1] = {Part=P[527], Material=Enum.Material.Metal} end
if P[1156] then matT[#matT+1] = {Part=P[1156], Material=Enum.Material.Glass} end
if P[734] then matT[#matT+1] = {Part=P[734], Material=Enum.Material.Glass} end
if P[506] then matT[#matT+1] = {Part=P[506], Material=Enum.Material.Glass} end
if P[995] then matT[#matT+1] = {Part=P[995], Material=Enum.Material.Wood} end
if P[104] then matT[#matT+1] = {Part=P[104], Material=Enum.Material.Plastic} end
if P[823] then matT[#matT+1] = {Part=P[823], Material=Enum.Material.Metal} end
if P[1138] then matT[#matT+1] = {Part=P[1138], Material=Enum.Material.Glass} end
if P[1127] then matT[#matT+1] = {Part=P[1127], Material=Enum.Material.Metal} end
if P[821] then matT[#matT+1] = {Part=P[821], Material=Enum.Material.Glass} end
if P[1125] then matT[#matT+1] = {Part=P[1125], Material=Enum.Material.Metal} end
if P[1015] then matT[#matT+1] = {Part=P[1015], Material=Enum.Material.Metal} end
if P[799] then matT[#matT+1] = {Part=P[799], Material=Enum.Material.SmoothPlastic} end
if P[747] then matT[#matT+1] = {Part=P[747], Material=Enum.Material.Glass} end
if P[1046] then matT[#matT+1] = {Part=P[1046], Material=Enum.Material.Metal} end
if P[185] then matT[#matT+1] = {Part=P[185], Material=Enum.Material.Fabric} end
if P[1121] then matT[#matT+1] = {Part=P[1121], Material=Enum.Material.Metal} end
if P[363] then matT[#matT+1] = {Part=P[363], Material=Enum.Material.Plastic} end
if P[857] then matT[#matT+1] = {Part=P[857], Material=Enum.Material.Wood} end
if P[43] then matT[#matT+1] = {Part=P[43], Material=Enum.Material.Plastic} end
if P[288] then matT[#matT+1] = {Part=P[288], Material=Enum.Material.Plastic} end
if P[902] then matT[#matT+1] = {Part=P[902], Material=Enum.Material.Plastic} end
if P[949] then matT[#matT+1] = {Part=P[949], Material=Enum.Material.Fabric} end
if P[1230] then matT[#matT+1] = {Part=P[1230], Material=Enum.Material.SmoothPlastic} end
if P[739] then matT[#matT+1] = {Part=P[739], Material=Enum.Material.Glass} end
if P[1097] then matT[#matT+1] = {Part=P[1097], Material=Enum.Material.Neon} end
if P[834] then matT[#matT+1] = {Part=P[834], Material=Enum.Material.Concrete} end
if P[736] then matT[#matT+1] = {Part=P[736], Material=Enum.Material.Glass} end
if P[766] then matT[#matT+1] = {Part=P[766], Material=Enum.Material.Concrete} end
if P[803] then matT[#matT+1] = {Part=P[803], Material=Enum.Material.Metal} end
if P[726] then matT[#matT+1] = {Part=P[726], Material=Enum.Material.Wood} end
if P[1091] then matT[#matT+1] = {Part=P[1091], Material=Enum.Material.Glass} end
if P[795] then matT[#matT+1] = {Part=P[795], Material=Enum.Material.Concrete} end
if P[548] then matT[#matT+1] = {Part=P[548], Material=Enum.Material.Fabric} end
if P[1078] then matT[#matT+1] = {Part=P[1078], Material=Enum.Material.Metal} end
if P[721] then matT[#matT+1] = {Part=P[721], Material=Enum.Material.Marble} end
if P[119] then matT[#matT+1] = {Part=P[119], Material=Enum.Material.Plastic} end
if P[611] then matT[#matT+1] = {Part=P[611], Material=Enum.Material.Fabric} end
if P[530] then matT[#matT+1] = {Part=P[530], Material=Enum.Material.SmoothPlastic} end
if P[1278] then matT[#matT+1] = {Part=P[1278], Material=Enum.Material.Glass} end
if P[756] then matT[#matT+1] = {Part=P[756], Material=Enum.Material.Metal} end
if P[947] then matT[#matT+1] = {Part=P[947], Material=Enum.Material.Fabric} end
if P[508] then matT[#matT+1] = {Part=P[508], Material=Enum.Material.Metal} end
if P[85] then matT[#matT+1] = {Part=P[85], Material=Enum.Material.Plastic} end
if P[163] then matT[#matT+1] = {Part=P[163], Material=Enum.Material.SmoothPlastic} end
if P[746] then matT[#matT+1] = {Part=P[746], Material=Enum.Material.Glass} end
if P[1072] then matT[#matT+1] = {Part=P[1072], Material=Enum.Material.Glass} end
if P[622] then matT[#matT+1] = {Part=P[622], Material=Enum.Material.SmoothPlastic} end
if P[175] then matT[#matT+1] = {Part=P[175], Material=Enum.Material.SmoothPlastic} end
if P[916] then matT[#matT+1] = {Part=P[916], Material=Enum.Material.Fabric} end
if P[1061] then matT[#matT+1] = {Part=P[1061], Material=Enum.Material.Metal} end
if P[1034] then matT[#matT+1] = {Part=P[1034], Material=Enum.Material.Plastic} end
if P[810] then matT[#matT+1] = {Part=P[810], Material=Enum.Material.Wood} end
if P[565] then matT[#matT+1] = {Part=P[565], Material=Enum.Material.Fabric} end
if P[920] then matT[#matT+1] = {Part=P[920], Material=Enum.Material.Fabric} end
if P[870] then matT[#matT+1] = {Part=P[870], Material=Enum.Material.Wood} end
if P[1124] then matT[#matT+1] = {Part=P[1124], Material=Enum.Material.Metal} end
if P[580] then matT[#matT+1] = {Part=P[580], Material=Enum.Material.Fabric} end
if P[261] then matT[#matT+1] = {Part=P[261], Material=Enum.Material.Plastic} end
if P[779] then matT[#matT+1] = {Part=P[779], Material=Enum.Material.Wood} end
if P[876] then matT[#matT+1] = {Part=P[876], Material=Enum.Material.Concrete} end
if P[1032] then matT[#matT+1] = {Part=P[1032], Material=Enum.Material.Metal} end
if P[858] then matT[#matT+1] = {Part=P[858], Material=Enum.Material.Wood} end
if P[617] then matT[#matT+1] = {Part=P[617], Material=Enum.Material.Metal} end
if P[1020] then matT[#matT+1] = {Part=P[1020], Material=Enum.Material.Plastic} end
if P[266] then matT[#matT+1] = {Part=P[266], Material=Enum.Material.Plastic} end
if P[1019] then matT[#matT+1] = {Part=P[1019], Material=Enum.Material.Metal} end
if P[1016] then matT[#matT+1] = {Part=P[1016], Material=Enum.Material.Metal} end
if P[158] then matT[#matT+1] = {Part=P[158], Material=Enum.Material.Plastic} end
if P[845] then matT[#matT+1] = {Part=P[845], Material=Enum.Material.Metal} end
if P[731] then matT[#matT+1] = {Part=P[731], Material=Enum.Material.Neon} end
if P[1011] then matT[#matT+1] = {Part=P[1011], Material=Enum.Material.Glass} end
if P[1000] then matT[#matT+1] = {Part=P[1000], Material=Enum.Material.Metal} end
if P[996] then matT[#matT+1] = {Part=P[996], Material=Enum.Material.Wood} end
if P[884] then matT[#matT+1] = {Part=P[884], Material=Enum.Material.Neon} end
if P[1141] then matT[#matT+1] = {Part=P[1141], Material=Enum.Material.Metal} end
if P[958] then matT[#matT+1] = {Part=P[958], Material=Enum.Material.Fabric} end
if P[911] then matT[#matT+1] = {Part=P[911], Material=Enum.Material.Grass} end
if P[511] then matT[#matT+1] = {Part=P[511], Material=Enum.Material.Metal} end
if P[994] then matT[#matT+1] = {Part=P[994], Material=Enum.Material.Wood} end
if P[993] then matT[#matT+1] = {Part=P[993], Material=Enum.Material.Wood} end
if P[1074] then matT[#matT+1] = {Part=P[1074], Material=Enum.Material.Metal} end
if P[991] then matT[#matT+1] = {Part=P[991], Material=Enum.Material.Wood} end
if P[844] then matT[#matT+1] = {Part=P[844], Material=Enum.Material.Glass} end
if P[990] then matT[#matT+1] = {Part=P[990], Material=Enum.Material.Wood} end
if P[987] then matT[#matT+1] = {Part=P[987], Material=Enum.Material.Metal} end
if P[985] then matT[#matT+1] = {Part=P[985], Material=Enum.Material.Fabric} end
if P[964] then matT[#matT+1] = {Part=P[964], Material=Enum.Material.Fabric} end
if P[975] then matT[#matT+1] = {Part=P[975], Material=Enum.Material.Fabric} end
if P[192] then matT[#matT+1] = {Part=P[192], Material=Enum.Material.SmoothPlastic} end
if P[973] then matT[#matT+1] = {Part=P[973], Material=Enum.Material.Fabric} end
if P[1253] then matT[#matT+1] = {Part=P[1253], Material=Enum.Material.Plastic} end
if P[310] then matT[#matT+1] = {Part=P[310], Material=Enum.Material.Plastic} end
if P[809] then matT[#matT+1] = {Part=P[809], Material=Enum.Material.Wood} end
if P[780] then matT[#matT+1] = {Part=P[780], Material=Enum.Material.SmoothPlastic} end
if P[595] then matT[#matT+1] = {Part=P[595], Material=Enum.Material.Fabric} end
if P[200] then matT[#matT+1] = {Part=P[200], Material=Enum.Material.SmoothPlastic} end
if P[966] then matT[#matT+1] = {Part=P[966], Material=Enum.Material.Fabric} end
if P[429] then matT[#matT+1] = {Part=P[429], Material=Enum.Material.Plastic} end
if P[776] then matT[#matT+1] = {Part=P[776], Material=Enum.Material.Glass} end
if P[515] then matT[#matT+1] = {Part=P[515], Material=Enum.Material.Plastic} end
if P[461] then matT[#matT+1] = {Part=P[461], Material=Enum.Material.Fabric} end
if P[983] then matT[#matT+1] = {Part=P[983], Material=Enum.Material.Fabric} end
if P[669] then matT[#matT+1] = {Part=P[669], Material=Enum.Material.Marble} end
if P[786] then matT[#matT+1] = {Part=P[786], Material=Enum.Material.Wood} end
if P[960] then matT[#matT+1] = {Part=P[960], Material=Enum.Material.Fabric} end
if P[956] then matT[#matT+1] = {Part=P[956], Material=Enum.Material.Fabric} end
if P[72] then matT[#matT+1] = {Part=P[72], Material=Enum.Material.Plastic} end
if P[926] then matT[#matT+1] = {Part=P[926], Material=Enum.Material.Fabric} end
if P[514] then matT[#matT+1] = {Part=P[514], Material=Enum.Material.Metal} end
if P[790] then matT[#matT+1] = {Part=P[790], Material=Enum.Material.Metal} end
if P[703] then matT[#matT+1] = {Part=P[703], Material=Enum.Material.Glass} end
if P[954] then matT[#matT+1] = {Part=P[954], Material=Enum.Material.Fabric} end
if P[714] then matT[#matT+1] = {Part=P[714], Material=Enum.Material.Neon} end
if P[605] then matT[#matT+1] = {Part=P[605], Material=Enum.Material.Fabric} end
if P[436] then matT[#matT+1] = {Part=P[436], Material=Enum.Material.Plastic} end
if P[945] then matT[#matT+1] = {Part=P[945], Material=Enum.Material.Fabric} end
if P[204] then matT[#matT+1] = {Part=P[204], Material=Enum.Material.Concrete} end
if P[941] then matT[#matT+1] = {Part=P[941], Material=Enum.Material.Fabric} end
if P[525] then matT[#matT+1] = {Part=P[525], Material=Enum.Material.Glass} end
if P[939] then matT[#matT+1] = {Part=P[939], Material=Enum.Material.Fabric} end
if P[414] then matT[#matT+1] = {Part=P[414], Material=Enum.Material.Plastic} end
if P[77] then matT[#matT+1] = {Part=P[77], Material=Enum.Material.Plastic} end
if P[664] then matT[#matT+1] = {Part=P[664], Material=Enum.Material.Metal} end
if P[1161] then matT[#matT+1] = {Part=P[1161], Material=Enum.Material.Plastic} end
if P[930] then matT[#matT+1] = {Part=P[930], Material=Enum.Material.Fabric} end
if P[670] then matT[#matT+1] = {Part=P[670], Material=Enum.Material.Marble} end
if P[928] then matT[#matT+1] = {Part=P[928], Material=Enum.Material.Fabric} end
if P[573] then matT[#matT+1] = {Part=P[573], Material=Enum.Material.Fabric} end
if P[924] then matT[#matT+1] = {Part=P[924], Material=Enum.Material.Fabric} end
if P[1047] then matT[#matT+1] = {Part=P[1047], Material=Enum.Material.Plastic} end
if P[307] then matT[#matT+1] = {Part=P[307], Material=Enum.Material.Plastic} end
if P[680] then matT[#matT+1] = {Part=P[680], Material=Enum.Material.SmoothPlastic} end
if P[913] then matT[#matT+1] = {Part=P[913], Material=Enum.Material.WoodPlanks} end
if P[909] then matT[#matT+1] = {Part=P[909], Material=Enum.Material.WoodPlanks} end
if P[906] then matT[#matT+1] = {Part=P[906], Material=Enum.Material.Plastic} end
if P[904] then matT[#matT+1] = {Part=P[904], Material=Enum.Material.Plastic} end
if P[900] then matT[#matT+1] = {Part=P[900], Material=Enum.Material.Plastic} end
if P[453] then matT[#matT+1] = {Part=P[453], Material=Enum.Material.Plastic} end
if P[894] then matT[#matT+1] = {Part=P[894], Material=Enum.Material.Plastic} end
if P[890] then matT[#matT+1] = {Part=P[890], Material=Enum.Material.Plastic} end
if P[634] then matT[#matT+1] = {Part=P[634], Material=Enum.Material.Plastic} end
if P[886] then matT[#matT+1] = {Part=P[886], Material=Enum.Material.Plastic} end
if P[463] then matT[#matT+1] = {Part=P[463], Material=Enum.Material.Metal} end
if P[1042] then matT[#matT+1] = {Part=P[1042], Material=Enum.Material.Metal} end
if P[196] then matT[#matT+1] = {Part=P[196], Material=Enum.Material.SmoothPlastic} end
if P[847] then matT[#matT+1] = {Part=P[847], Material=Enum.Material.Glass} end
if P[567] then matT[#matT+1] = {Part=P[567], Material=Enum.Material.Fabric} end
if P[554] then matT[#matT+1] = {Part=P[554], Material=Enum.Material.Fabric} end
if P[487] then matT[#matT+1] = {Part=P[487], Material=Enum.Material.Plastic} end
if P[697] then matT[#matT+1] = {Part=P[697], Material=Enum.Material.Wood} end
if P[187] then matT[#matT+1] = {Part=P[187], Material=Enum.Material.Fabric} end
if P[937] then matT[#matT+1] = {Part=P[937], Material=Enum.Material.Fabric} end
if P[872] then matT[#matT+1] = {Part=P[872], Material=Enum.Material.Concrete} end
if P[867] then matT[#matT+1] = {Part=P[867], Material=Enum.Material.Wood} end
if P[720] then matT[#matT+1] = {Part=P[720], Material=Enum.Material.Glass} end
if P[592] then matT[#matT+1] = {Part=P[592], Material=Enum.Material.Fabric} end
if P[813] then matT[#matT+1] = {Part=P[813], Material=Enum.Material.Wood} end
if P[355] then matT[#matT+1] = {Part=P[355], Material=Enum.Material.Plastic} end
if P[828] then matT[#matT+1] = {Part=P[828], Material=Enum.Material.Wood} end
if P[370] then matT[#matT+1] = {Part=P[370], Material=Enum.Material.Plastic} end
if P[528] then matT[#matT+1] = {Part=P[528], Material=Enum.Material.Metal} end
if P[481] then matT[#matT+1] = {Part=P[481], Material=Enum.Material.Plastic} end
if P[677] then matT[#matT+1] = {Part=P[677], Material=Enum.Material.Wood} end
if P[1328] then matT[#matT+1] = {Part=P[1328], Material=Enum.Material.Plastic} end
if P[1313] then matT[#matT+1] = {Part=P[1313], Material=Enum.Material.Metal} end
if P[859] then matT[#matT+1] = {Part=P[859], Material=Enum.Material.Concrete} end
if P[1030] then matT[#matT+1] = {Part=P[1030], Material=Enum.Material.Glass} end
if P[1119] then matT[#matT+1] = {Part=P[1119], Material=Enum.Material.Glass} end
if P[850] then matT[#matT+1] = {Part=P[850], Material=Enum.Material.Wood} end
if P[1095] then matT[#matT+1] = {Part=P[1095], Material=Enum.Material.Neon} end
if P[57] then matT[#matT+1] = {Part=P[57], Material=Enum.Material.Plastic} end
if P[40] then matT[#matT+1] = {Part=P[40], Material=Enum.Material.Plastic} end
if P[1211] then matT[#matT+1] = {Part=P[1211], Material=Enum.Material.Plastic} end
if P[827] then matT[#matT+1] = {Part=P[827], Material=Enum.Material.Plastic} end
if P[563] then matT[#matT+1] = {Part=P[563], Material=Enum.Material.Fabric} end
if P[91] then matT[#matT+1] = {Part=P[91], Material=Enum.Material.Plastic} end
if P[896] then matT[#matT+1] = {Part=P[896], Material=Enum.Material.Plastic} end
if P[705] then matT[#matT+1] = {Part=P[705], Material=Enum.Material.Concrete} end
if P[825] then matT[#matT+1] = {Part=P[825], Material=Enum.Material.Glass} end
if P[1140] then matT[#matT+1] = {Part=P[1140], Material=Enum.Material.Metal} end
if P[599] then matT[#matT+1] = {Part=P[599], Material=Enum.Material.Fabric} end
if P[951] then matT[#matT+1] = {Part=P[951], Material=Enum.Material.WoodPlanks} end
if P[465] then matT[#matT+1] = {Part=P[465], Material=Enum.Material.Plastic} end
if P[322] then matT[#matT+1] = {Part=P[322], Material=Enum.Material.Plastic} end
if P[586] then matT[#matT+1] = {Part=P[586], Material=Enum.Material.Fabric} end
if P[510] then matT[#matT+1] = {Part=P[510], Material=Enum.Material.Metal} end
if P[438] then matT[#matT+1] = {Part=P[438], Material=Enum.Material.Plastic} end
if P[760] then matT[#matT+1] = {Part=P[760], Material=Enum.Material.Concrete} end
if P[171] then matT[#matT+1] = {Part=P[171], Material=Enum.Material.SmoothPlastic} end
if P[544] then matT[#matT+1] = {Part=P[544], Material=Enum.Material.Fabric} end
if P[571] then matT[#matT+1] = {Part=P[571], Material=Enum.Material.Fabric} end
if P[584] then matT[#matT+1] = {Part=P[584], Material=Enum.Material.Fabric} end
if P[352] then matT[#matT+1] = {Part=P[352], Material=Enum.Material.Plastic} end
if P[469] then matT[#matT+1] = {Part=P[469], Material=Enum.Material.Metal} end
if P[242] then matT[#matT+1] = {Part=P[242], Material=Enum.Material.Plastic} end
if P[180] then matT[#matT+1] = {Part=P[180], Material=Enum.Material.Fabric} end
if P[819] then matT[#matT+1] = {Part=P[819], Material=Enum.Material.Metal} end
if P[97] then matT[#matT+1] = {Part=P[97], Material=Enum.Material.Plastic} end
if P[459] then matT[#matT+1] = {Part=P[459], Material=Enum.Material.Neon} end
if P[348] then matT[#matT+1] = {Part=P[348], Material=Enum.Material.Plastic} end
if P[875] then matT[#matT+1] = {Part=P[875], Material=Enum.Material.Metal} end
if P[735] then matT[#matT+1] = {Part=P[735], Material=Enum.Material.Glass} end
if P[491] then matT[#matT+1] = {Part=P[491], Material=Enum.Material.Neon} end
if P[360] then matT[#matT+1] = {Part=P[360], Material=Enum.Material.Plastic} end
if P[817] then matT[#matT+1] = {Part=P[817], Material=Enum.Material.Glass} end
if P[814] then matT[#matT+1] = {Part=P[814], Material=Enum.Material.Wood} end
if P[590] then matT[#matT+1] = {Part=P[590], Material=Enum.Material.Fabric} end
if P[753] then matT[#matT+1] = {Part=P[753], Material=Enum.Material.SmoothPlastic} end
if P[1171] then matT[#matT+1] = {Part=P[1171], Material=Enum.Material.Glass} end
if P[615] then matT[#matT+1] = {Part=P[615], Material=Enum.Material.Neon} end
if P[32] then matT[#matT+1] = {Part=P[32], Material=Enum.Material.Plastic} end
if P[808] then matT[#matT+1] = {Part=P[808], Material=Enum.Material.Wood} end
if P[647] then matT[#matT+1] = {Part=P[647], Material=Enum.Material.SmoothPlastic} end
if P[16] then matT[#matT+1] = {Part=P[16], Material=Enum.Material.Plastic} end
if P[729] then matT[#matT+1] = {Part=P[729], Material=Enum.Material.Glass} end
if P[445] then matT[#matT+1] = {Part=P[445], Material=Enum.Material.Plastic} end
if P[632] then matT[#matT+1] = {Part=P[632], Material=Enum.Material.Plastic} end
if P[741] then matT[#matT+1] = {Part=P[741], Material=Enum.Material.Glass} end
if P[385] then matT[#matT+1] = {Part=P[385], Material=Enum.Material.Plastic} end
if P[655] then matT[#matT+1] = {Part=P[655], Material=Enum.Material.Metal} end
if P[193] then matT[#matT+1] = {Part=P[193], Material=Enum.Material.SmoothPlastic} end
if P[774] then matT[#matT+1] = {Part=P[774], Material=Enum.Material.Wood} end
if P[629] then matT[#matT+1] = {Part=P[629], Material=Enum.Material.Metal} end
if P[688] then matT[#matT+1] = {Part=P[688], Material=Enum.Material.Concrete} end
if P[962] then matT[#matT+1] = {Part=P[962], Material=Enum.Material.Fabric} end
if P[777] then matT[#matT+1] = {Part=P[777], Material=Enum.Material.Marble} end
if P[822] then matT[#matT+1] = {Part=P[822], Material=Enum.Material.Glass} end
if P[829] then matT[#matT+1] = {Part=P[829], Material=Enum.Material.Concrete} end
if P[768] then matT[#matT+1] = {Part=P[768], Material=Enum.Material.Neon} end
if P[668] then matT[#matT+1] = {Part=P[668], Material=Enum.Material.SmoothPlastic} end
if P[866] then matT[#matT+1] = {Part=P[866], Material=Enum.Material.Wood} end
if P[778] then matT[#matT+1] = {Part=P[778], Material=Enum.Material.Wood} end
if P[578] then matT[#matT+1] = {Part=P[578], Material=Enum.Material.Fabric} end
if P[1093] then matT[#matT+1] = {Part=P[1093], Material=Enum.Material.Metal} end
if P[1225] then matT[#matT+1] = {Part=P[1225], Material=Enum.Material.Metal} end
if P[9] then matT[#matT+1] = {Part=P[9], Material=Enum.Material.Plastic} end
if P[550] then matT[#matT+1] = {Part=P[550], Material=Enum.Material.Fabric} end
if P[271] then matT[#matT+1] = {Part=P[271], Material=Enum.Material.Plastic} end
if P[743] then matT[#matT+1] = {Part=P[743], Material=Enum.Material.Glass} end
if P[787] then matT[#matT+1] = {Part=P[787], Material=Enum.Material.Glass} end
if P[737] then matT[#matT+1] = {Part=P[737], Material=Enum.Material.Glass} end
if P[888] then matT[#matT+1] = {Part=P[888], Material=Enum.Material.Plastic} end
if P[296] then matT[#matT+1] = {Part=P[296], Material=Enum.Material.Plastic} end
if P[542] then matT[#matT+1] = {Part=P[542], Material=Enum.Material.Fabric} end
if P[552] then matT[#matT+1] = {Part=P[552], Material=Enum.Material.Fabric} end
if P[1267] then matT[#matT+1] = {Part=P[1267], Material=Enum.Material.Metal} end
if P[559] then matT[#matT+1] = {Part=P[559], Material=Enum.Material.Fabric} end
if P[1268] then matT[#matT+1] = {Part=P[1268], Material=Enum.Material.Plastic} end
if P[537] then matT[#matT+1] = {Part=P[537], Material=Enum.Material.WoodPlanks} end
if P[704] then matT[#matT+1] = {Part=P[704], Material=Enum.Material.Glass} end
if P[710] then matT[#matT+1] = {Part=P[710], Material=Enum.Material.Glass} end
if P[1191] then matT[#matT+1] = {Part=P[1191], Material=Enum.Material.Plastic} end
if P[712] then matT[#matT+1] = {Part=P[712], Material=Enum.Material.Concrete} end
if P[533] then matT[#matT+1] = {Part=P[533], Material=Enum.Material.WoodPlanks} end
if P[535] then matT[#matT+1] = {Part=P[535], Material=Enum.Material.Grass} end
if P[918] then matT[#matT+1] = {Part=P[918], Material=Enum.Material.Fabric} end
if P[37] then matT[#matT+1] = {Part=P[37], Material=Enum.Material.Plastic} end
if P[74] then matT[#matT+1] = {Part=P[74], Material=Enum.Material.Plastic} end
if P[666] then matT[#matT+1] = {Part=P[666], Material=Enum.Material.Concrete} end
if P[601] then matT[#matT+1] = {Part=P[601], Material=Enum.Material.Fabric} end
if P[613] then matT[#matT+1] = {Part=P[613], Material=Enum.Material.Metal} end
if P[387] then matT[#matT+1] = {Part=P[387], Material=Enum.Material.Plastic} end
if P[862] then matT[#matT+1] = {Part=P[862], Material=Enum.Material.Metal} end
if P[693] then matT[#matT+1] = {Part=P[693], Material=Enum.Material.Concrete} end
if P[167] then matT[#matT+1] = {Part=P[167], Material=Enum.Material.SmoothPlastic} end
if P[191] then matT[#matT+1] = {Part=P[191], Material=Enum.Material.SmoothPlastic} end
bMaterial(endpoint, matT)
local trT = {}
if P[561] then trT[#trT+1] = {Part=P[561], Transparency=1} end
if P[892] then trT[#trT+1] = {Part=P[892], Transparency=1} end
if P[597] then trT[#trT+1] = {Part=P[597], Transparency=1} end
if P[184] then trT[#trT+1] = {Part=P[184], Transparency=1} end
if P[569] then trT[#trT+1] = {Part=P[569], Transparency=1} end
if P[582] then trT[#trT+1] = {Part=P[582], Transparency=1} end
if P[748] then trT[#trT+1] = {Part=P[748], Transparency=1} end
if P[767] then trT[#trT+1] = {Part=P[767], Transparency=0.5} end
if P[607] then trT[#trT+1] = {Part=P[607], Transparency=1} end
if P[979] then trT[#trT+1] = {Part=P[979], Transparency=1} end
if P[782] then trT[#trT+1] = {Part=P[782], Transparency=1} end
if P[1081] then trT[#trT+1] = {Part=P[1081], Transparency=1} end
if P[1062] then trT[#trT+1] = {Part=P[1062], Transparency=1} end
if P[609] then trT[#trT+1] = {Part=P[609], Transparency=1} end
if P[1001] then trT[#trT+1] = {Part=P[1001], Transparency=1} end
if P[540] then trT[#trT+1] = {Part=P[540], Transparency=1} end
if P[922] then trT[#trT+1] = {Part=P[922], Transparency=1} end
if P[603] then trT[#trT+1] = {Part=P[603], Transparency=1} end
if P[745] then trT[#trT+1] = {Part=P[745], Transparency=0.800000011920929} end
if P[898] then trT[#trT+1] = {Part=P[898], Transparency=1} end
if P[681] then trT[#trT+1] = {Part=P[681], Transparency=1} end
if P[775] then trT[#trT+1] = {Part=P[775], Transparency=0.5} end
if P[1109] then trT[#trT+1] = {Part=P[1109], Transparency=1} end
if P[977] then trT[#trT+1] = {Part=P[977], Transparency=1} end
if P[1326] then trT[#trT+1] = {Part=P[1326], Transparency=1} end
if P[968] then trT[#trT+1] = {Part=P[968], Transparency=1} end
if P[1298] then trT[#trT+1] = {Part=P[1298], Transparency=1} end
if P[496] then trT[#trT+1] = {Part=P[496], Transparency=1} end
if P[943] then trT[#trT+1] = {Part=P[943], Transparency=1} end
if P[1283] then trT[#trT+1] = {Part=P[1283], Transparency=1} end
if P[971] then trT[#trT+1] = {Part=P[971], Transparency=1} end
if P[1242] then trT[#trT+1] = {Part=P[1242], Transparency=1} end
if P[1236] then trT[#trT+1] = {Part=P[1236], Transparency=1} end
if P[1099] then trT[#trT+1] = {Part=P[1099], Transparency=1} end
if P[1227] then trT[#trT+1] = {Part=P[1227], Transparency=1} end
if P[1219] then trT[#trT+1] = {Part=P[1219], Transparency=1} end
if P[472] then trT[#trT+1] = {Part=P[472], Transparency=1} end
if P[981] then trT[#trT+1] = {Part=P[981], Transparency=1} end
if P[588] then trT[#trT+1] = {Part=P[588], Transparency=1} end
if P[802] then trT[#trT+1] = {Part=P[802], Transparency=1} end
if P[1128] then trT[#trT+1] = {Part=P[1128], Transparency=1} end
if P[1146] then trT[#trT+1] = {Part=P[1146], Transparency=1} end
if P[546] then trT[#trT+1] = {Part=P[546], Transparency=1} end
if P[640] then trT[#trT+1] = {Part=P[640], Transparency=1} end
if P[1176] then trT[#trT+1] = {Part=P[1176], Transparency=1} end
if P[935] then trT[#trT+1] = {Part=P[935], Transparency=1} end
if P[799] then trT[#trT+1] = {Part=P[799], Transparency=0.5} end
if P[185] then trT[#trT+1] = {Part=P[185], Transparency=0.019999999552965164} end
if P[902] then trT[#trT+1] = {Part=P[902], Transparency=1} end
if P[949] then trT[#trT+1] = {Part=P[949], Transparency=1} end
if P[1230] then trT[#trT+1] = {Part=P[1230], Transparency=1} end
if P[739] then trT[#trT+1] = {Part=P[739], Transparency=0.800000011920929} end
if P[795] then trT[#trT+1] = {Part=P[795], Transparency=1} end
if P[548] then trT[#trT+1] = {Part=P[548], Transparency=1} end
if P[530] then trT[#trT+1] = {Part=P[530], Transparency=1} end
if P[947] then trT[#trT+1] = {Part=P[947], Transparency=1} end
if P[163] then trT[#trT+1] = {Part=P[163], Transparency=1} end
if P[622] then trT[#trT+1] = {Part=P[622], Transparency=1} end
if P[175] then trT[#trT+1] = {Part=P[175], Transparency=1} end
if P[916] then trT[#trT+1] = {Part=P[916], Transparency=1} end
if P[1034] then trT[#trT+1] = {Part=P[1034], Transparency=1} end
if P[565] then trT[#trT+1] = {Part=P[565], Transparency=1} end
if P[920] then trT[#trT+1] = {Part=P[920], Transparency=1} end
if P[580] then trT[#trT+1] = {Part=P[580], Transparency=1} end
if P[1020] then trT[#trT+1] = {Part=P[1020], Transparency=1} end
if P[958] then trT[#trT+1] = {Part=P[958], Transparency=1} end
if P[987] then trT[#trT+1] = {Part=P[987], Transparency=1} end
if P[985] then trT[#trT+1] = {Part=P[985], Transparency=1} end
if P[964] then trT[#trT+1] = {Part=P[964], Transparency=1} end
if P[975] then trT[#trT+1] = {Part=P[975], Transparency=1} end
if P[973] then trT[#trT+1] = {Part=P[973], Transparency=1} end
if P[1253] then trT[#trT+1] = {Part=P[1253], Transparency=1} end
if P[780] then trT[#trT+1] = {Part=P[780], Transparency=0.5} end
if P[595] then trT[#trT+1] = {Part=P[595], Transparency=1} end
if P[966] then trT[#trT+1] = {Part=P[966], Transparency=1} end
if P[429] then trT[#trT+1] = {Part=P[429], Transparency=1} end
if P[515] then trT[#trT+1] = {Part=P[515], Transparency=1} end
if P[983] then trT[#trT+1] = {Part=P[983], Transparency=1} end
if P[960] then trT[#trT+1] = {Part=P[960], Transparency=1} end
if P[956] then trT[#trT+1] = {Part=P[956], Transparency=1} end
if P[926] then trT[#trT+1] = {Part=P[926], Transparency=1} end
if P[954] then trT[#trT+1] = {Part=P[954], Transparency=1} end
if P[605] then trT[#trT+1] = {Part=P[605], Transparency=1} end
if P[945] then trT[#trT+1] = {Part=P[945], Transparency=1} end
if P[941] then trT[#trT+1] = {Part=P[941], Transparency=1} end
if P[939] then trT[#trT+1] = {Part=P[939], Transparency=1} end
if P[1161] then trT[#trT+1] = {Part=P[1161], Transparency=1} end
if P[930] then trT[#trT+1] = {Part=P[930], Transparency=1} end
if P[928] then trT[#trT+1] = {Part=P[928], Transparency=1} end
if P[573] then trT[#trT+1] = {Part=P[573], Transparency=1} end
if P[924] then trT[#trT+1] = {Part=P[924], Transparency=1} end
if P[1047] then trT[#trT+1] = {Part=P[1047], Transparency=1} end
if P[307] then trT[#trT+1] = {Part=P[307], Transparency=1} end
if P[680] then trT[#trT+1] = {Part=P[680], Transparency=0.5} end
if P[906] then trT[#trT+1] = {Part=P[906], Transparency=1} end
if P[904] then trT[#trT+1] = {Part=P[904], Transparency=1} end
if P[900] then trT[#trT+1] = {Part=P[900], Transparency=1} end
if P[894] then trT[#trT+1] = {Part=P[894], Transparency=1} end
if P[890] then trT[#trT+1] = {Part=P[890], Transparency=1} end
if P[634] then trT[#trT+1] = {Part=P[634], Transparency=1} end
if P[886] then trT[#trT+1] = {Part=P[886], Transparency=1} end
if P[567] then trT[#trT+1] = {Part=P[567], Transparency=1} end
if P[554] then trT[#trT+1] = {Part=P[554], Transparency=1} end
if P[937] then trT[#trT+1] = {Part=P[937], Transparency=1} end
if P[592] then trT[#trT+1] = {Part=P[592], Transparency=1} end
if P[528] then trT[#trT+1] = {Part=P[528], Transparency=1} end
if P[481] then trT[#trT+1] = {Part=P[481], Transparency=1} end
if P[1211] then trT[#trT+1] = {Part=P[1211], Transparency=1} end
if P[827] then trT[#trT+1] = {Part=P[827], Transparency=1} end
if P[563] then trT[#trT+1] = {Part=P[563], Transparency=1} end
if P[896] then trT[#trT+1] = {Part=P[896], Transparency=1} end
if P[599] then trT[#trT+1] = {Part=P[599], Transparency=1} end
if P[586] then trT[#trT+1] = {Part=P[586], Transparency=1} end
if P[171] then trT[#trT+1] = {Part=P[171], Transparency=1} end
if P[544] then trT[#trT+1] = {Part=P[544], Transparency=1} end
if P[571] then trT[#trT+1] = {Part=P[571], Transparency=1} end
if P[584] then trT[#trT+1] = {Part=P[584], Transparency=1} end
if P[242] then trT[#trT+1] = {Part=P[242], Transparency=1} end
if P[590] then trT[#trT+1] = {Part=P[590], Transparency=1} end
if P[753] then trT[#trT+1] = {Part=P[753], Transparency=0.5} end
if P[647] then trT[#trT+1] = {Part=P[647], Transparency=1} end
if P[729] then trT[#trT+1] = {Part=P[729], Transparency=0.800000011920929} end
if P[962] then trT[#trT+1] = {Part=P[962], Transparency=1} end
if P[668] then trT[#trT+1] = {Part=P[668], Transparency=0.5} end
if P[578] then trT[#trT+1] = {Part=P[578], Transparency=1} end
if P[550] then trT[#trT+1] = {Part=P[550], Transparency=1} end
if P[888] then trT[#trT+1] = {Part=P[888], Transparency=1} end
if P[296] then trT[#trT+1] = {Part=P[296], Transparency=1} end
if P[542] then trT[#trT+1] = {Part=P[542], Transparency=1} end
if P[552] then trT[#trT+1] = {Part=P[552], Transparency=1} end
if P[559] then trT[#trT+1] = {Part=P[559], Transparency=1} end
if P[1268] then trT[#trT+1] = {Part=P[1268], Transparency=1} end
if P[1191] then trT[#trT+1] = {Part=P[1191], Transparency=1} end
if P[918] then trT[#trT+1] = {Part=P[918], Transparency=1} end
if P[601] then trT[#trT+1] = {Part=P[601], Transparency=1} end
if P[387] then trT[#trT+1] = {Part=P[387], Transparency=1} end
if P[693] then trT[#trT+1] = {Part=P[693], Transparency=1} end
if P[167] then trT[#trT+1] = {Part=P[167], Transparency=1} end
if #trT>0 then bMaterial(endpoint, trT) end
local rfT = {}
if P[767] then rfT[#rfT+1] = {Part=P[767], Reflectance=0.30000001192092896} end
if P[745] then rfT[#rfT+1] = {Part=P[745], Reflectance=0.5} end
if P[775] then rfT[#rfT+1] = {Part=P[775], Reflectance=0.30000001192092896} end
if P[821] then rfT[#rfT+1] = {Part=P[821], Reflectance=0.5} end
if P[799] then rfT[#rfT+1] = {Part=P[799], Reflectance=0.30000001192092896} end
if P[739] then rfT[#rfT+1] = {Part=P[739], Reflectance=0.5} end
if P[780] then rfT[#rfT+1] = {Part=P[780], Reflectance=0.30000001192092896} end
if P[680] then rfT[#rfT+1] = {Part=P[680], Reflectance=0.30000001192092896} end
if P[847] then rfT[#rfT+1] = {Part=P[847], Reflectance=0.5} end
if P[753] then rfT[#rfT+1] = {Part=P[753], Reflectance=0.30000001192092896} end
if P[729] then rfT[#rfT+1] = {Part=P[729], Reflectance=0.5} end
if P[668] then rfT[#rfT+1] = {Part=P[668], Reflectance=0.30000001192092896} end
if #rfT>0 then bMaterial(endpoint, rfT) end
local colT = {}
if P[6] then colT[#colT+1] = {Part=P[6], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[673] then colT[#colT+1] = {Part=P[673], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[815] then colT[#colT+1] = {Part=P[815], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[685] then colT[#colT+1] = {Part=P[685], Color=Color3.new(0.6705882549285889,0.658823549747467,0.6196078658103943), UnionColoring=false} end
if P[561] then colT[#colT+1] = {Part=P[561], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[892] then colT[#colT+1] = {Part=P[892], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[725] then colT[#colT+1] = {Part=P[725], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[41] then colT[#colT+1] = {Part=P[41], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[675] then colT[#colT+1] = {Part=P[675], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[357] then colT[#colT+1] = {Part=P[357], Color=Color3.new(0.3176470696926117,0.6000000238418579,0.2980392277240753), UnionColoring=false} end
if P[871] then colT[#colT+1] = {Part=P[871], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[124] then colT[#colT+1] = {Part=P[124], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1201] then colT[#colT+1] = {Part=P[1201], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[182] then colT[#colT+1] = {Part=P[182], Color=Color3.new(0.13725490868091583,0.13725490868091583,0.13725490868091583), UnionColoring=false} end
if P[320] then colT[#colT+1] = {Part=P[320], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[855] then colT[#colT+1] = {Part=P[855], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[1188] then colT[#colT+1] = {Part=P[1188], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[762] then colT[#colT+1] = {Part=P[762], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[597] then colT[#colT+1] = {Part=P[597], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[184] then colT[#colT+1] = {Part=P[184], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[804] then colT[#colT+1] = {Part=P[804], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[402] then colT[#colT+1] = {Part=P[402], Color=Color3.new(0.5215686559677124,0.2980392277240753,0.8980392217636108), UnionColoring=false} end
if P[569] then colT[#colT+1] = {Part=P[569], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[582] then colT[#colT+1] = {Part=P[582], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[512] then colT[#colT+1] = {Part=P[512], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[279] then colT[#colT+1] = {Part=P[279], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[742] then colT[#colT+1] = {Part=P[742], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[748] then colT[#colT+1] = {Part=P[748], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[478] then colT[#colT+1] = {Part=P[478], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[767] then colT[#colT+1] = {Part=P[767], Color=Color3.new(0.27843138575553894,0.38823530077934265,0.3490196168422699), UnionColoring=false} end
if P[607] then colT[#colT+1] = {Part=P[607], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[979] then colT[#colT+1] = {Part=P[979], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[788] then colT[#colT+1] = {Part=P[788], Color=Color3.new(0.6274510025978088,0.33725491166114807,0.1411764770746231), UnionColoring=false} end
if P[1123] then colT[#colT+1] = {Part=P[1123], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[575] then colT[#colT+1] = {Part=P[575], Color=Color3.new(0.800000011920929,0.5568627715110779,0.4117647111415863), UnionColoring=false} end
if P[782] then colT[#colT+1] = {Part=P[782], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[1081] then colT[#colT+1] = {Part=P[1081], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[1062] then colT[#colT+1] = {Part=P[1062], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[1017] then colT[#colT+1] = {Part=P[1017], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[868] then colT[#colT+1] = {Part=P[868], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[1145] then colT[#colT+1] = {Part=P[1145], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1263] then colT[#colT+1] = {Part=P[1263], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[94] then colT[#colT+1] = {Part=P[94], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[1239] then colT[#colT+1] = {Part=P[1239], Color=Color3.new(0.9960784316062927,0.9529411792755127,0.7333333492279053), UnionColoring=false} end
if P[676] then colT[#colT+1] = {Part=P[676], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[609] then colT[#colT+1] = {Part=P[609], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1001] then colT[#colT+1] = {Part=P[1001], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[1315] then colT[#colT+1] = {Part=P[1315], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[656] then colT[#colT+1] = {Part=P[656], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[495] then colT[#colT+1] = {Part=P[495], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[997] then colT[#colT+1] = {Part=P[997], Color=Color3.new(0.6274510025978088,0.33725491166114807,0.1411764770746231), UnionColoring=false} end
if P[733] then colT[#colT+1] = {Part=P[733], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[540] then colT[#colT+1] = {Part=P[540], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[781] then colT[#colT+1] = {Part=P[781], Color=Color3.new(0.32549020648002625,0.2078431397676468,0.14509804546833038), UnionColoring=false} end
if P[619] then colT[#colT+1] = {Part=P[619], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[264] then colT[#colT+1] = {Part=P[264], Color=Color3.new(0.9764705896377563,0.9764705896377563,0.9764705896377563), UnionColoring=false} end
if P[441] then colT[#colT+1] = {Part=P[441], Color=Color3.new(0.5215686559677124,0.2980392277240753,0.8980392217636108), UnionColoring=false} end
if P[922] then colT[#colT+1] = {Part=P[922], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1223] then colT[#colT+1] = {Part=P[1223], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[769] then colT[#colT+1] = {Part=P[769], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[603] then colT[#colT+1] = {Part=P[603], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1312] then colT[#colT+1] = {Part=P[1312], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[789] then colT[#colT+1] = {Part=P[789], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[745] then colT[#colT+1] = {Part=P[745], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[812] then colT[#colT+1] = {Part=P[812], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[898] then colT[#colT+1] = {Part=P[898], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[732] then colT[#colT+1] = {Part=P[732], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[391] then colT[#colT+1] = {Part=P[391], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[681] then colT[#colT+1] = {Part=P[681], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[309] then colT[#colT+1] = {Part=P[309], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[88] then colT[#colT+1] = {Part=P[88], Color=Color3.new(0,0,0), UnionColoring=false} end
if P[1297] then colT[#colT+1] = {Part=P[1297], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[213] then colT[#colT+1] = {Part=P[213], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[212] then colT[#colT+1] = {Part=P[212], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[775] then colT[#colT+1] = {Part=P[775], Color=Color3.new(0.27843138575553894,0.38823530077934265,0.3490196168422699), UnionColoring=false} end
if P[1295] then colT[#colT+1] = {Part=P[1295], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[728] then colT[#colT+1] = {Part=P[728], Color=Color3.new(1,1,0.800000011920929), UnionColoring=false} end
if P[1076] then colT[#colT+1] = {Part=P[1076], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1109] then colT[#colT+1] = {Part=P[1109], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[1013] then colT[#colT+1] = {Part=P[1013], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1280] then colT[#colT+1] = {Part=P[1280], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[42] then colT[#colT+1] = {Part=P[42], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[313] then colT[#colT+1] = {Part=P[313], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[1059] then colT[#colT+1] = {Part=P[1059], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[227] then colT[#colT+1] = {Part=P[227], Color=Color3.new(0.6470588445663452,0.6431372761726379,0.6549019813537598), UnionColoring=false} end
if P[833] then colT[#colT+1] = {Part=P[833], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[730] then colT[#colT+1] = {Part=P[730], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[300] then colT[#colT+1] = {Part=P[300], Color=Color3.new(0.9490196108818054,0.9529411792755127,0.9529411792755127), UnionColoring=false} end
if P[190] then colT[#colT+1] = {Part=P[190], Color=Color3.new(0.9058823585510254,0.9058823585510254,0.9254902005195618), UnionColoring=false} end
if P[1040] then colT[#colT+1] = {Part=P[1040], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[338] then colT[#colT+1] = {Part=P[338], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[977] then colT[#colT+1] = {Part=P[977], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1331] then colT[#colT+1] = {Part=P[1331], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1329] then colT[#colT+1] = {Part=P[1329], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[865] then colT[#colT+1] = {Part=P[865], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[248] then colT[#colT+1] = {Part=P[248], Color=Color3.new(0.9764705896377563,0.9764705896377563,0.9764705896377563), UnionColoring=false} end
if P[1326] then colT[#colT+1] = {Part=P[1326], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1077] then colT[#colT+1] = {Part=P[1077], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1324] then colT[#colT+1] = {Part=P[1324], Color=Color3.new(0.9960784316062927,0.9529411792755127,0.7333333492279053), UnionColoring=false} end
if P[1317] then colT[#colT+1] = {Part=P[1317], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1203] then colT[#colT+1] = {Part=P[1203], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[245] then colT[#colT+1] = {Part=P[245], Color=Color3.new(0.9764705896377563,0.9764705896377563,0.9764705896377563), UnionColoring=false} end
if P[852] then colT[#colT+1] = {Part=P[852], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[1158] then colT[#colT+1] = {Part=P[1158], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[47] then colT[#colT+1] = {Part=P[47], Color=Color3.new(0.9450980424880981,0.8666666746139526,0.7764706015586853), UnionColoring=false} end
if P[869] then colT[#colT+1] = {Part=P[869], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[740] then colT[#colT+1] = {Part=P[740], Color=Color3.new(1,1,0.800000011920929), UnionColoring=false} end
if P[968] then colT[#colT+1] = {Part=P[968], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[678] then colT[#colT+1] = {Part=P[678], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[34] then colT[#colT+1] = {Part=P[34], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[1310] then colT[#colT+1] = {Part=P[1310], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1308] then colT[#colT+1] = {Part=P[1308], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[1298] then colT[#colT+1] = {Part=P[1298], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[1206] then colT[#colT+1] = {Part=P[1206], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[722] then colT[#colT+1] = {Part=P[722], Color=Color3.new(0.35686275362968445,0.364705890417099,0.4117647111415863), UnionColoring=false} end
if P[496] then colT[#colT+1] = {Part=P[496], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[738] then colT[#colT+1] = {Part=P[738], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[214] then colT[#colT+1] = {Part=P[214], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[943] then colT[#colT+1] = {Part=P[943], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1293] then colT[#colT+1] = {Part=P[1293], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[992] then colT[#colT+1] = {Part=P[992], Color=Color3.new(0.6274510025978088,0.33725491166114807,0.1411764770746231), UnionColoring=false} end
if P[1282] then colT[#colT+1] = {Part=P[1282], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1283] then colT[#colT+1] = {Part=P[1283], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[724] then colT[#colT+1] = {Part=P[724], Color=Color3.new(0.6274510025978088,0.33725491166114807,0.1411764770746231), UnionColoring=false} end
if P[687] then colT[#colT+1] = {Part=P[687], Color=Color3.new(0.38823530077934265,0.37254902720451355,0.3843137323856354), UnionColoring=false} end
if P[674] then colT[#colT+1] = {Part=P[674], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[1265] then colT[#colT+1] = {Part=P[1265], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[971] then colT[#colT+1] = {Part=P[971], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1252] then colT[#colT+1] = {Part=P[1252], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1248] then colT[#colT+1] = {Part=P[1248], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1242] then colT[#colT+1] = {Part=P[1242], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[1237] then colT[#colT+1] = {Part=P[1237], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1236] then colT[#colT+1] = {Part=P[1236], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1234] then colT[#colT+1] = {Part=P[1234], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[854] then colT[#colT+1] = {Part=P[854], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[1232] then colT[#colT+1] = {Part=P[1232], Color=Color3.new(0.8039215803146362,0.8039215803146362,0.8039215803146362), UnionColoring=false} end
if P[660] then colT[#colT+1] = {Part=P[660], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[1099] then colT[#colT+1] = {Part=P[1099], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[679] then colT[#colT+1] = {Part=P[679], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[1228] then colT[#colT+1] = {Part=P[1228], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1227] then colT[#colT+1] = {Part=P[1227], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[764] then colT[#colT+1] = {Part=P[764], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[456] then colT[#colT+1] = {Part=P[456], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1220] then colT[#colT+1] = {Part=P[1220], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[467] then colT[#colT+1] = {Part=P[467], Color=Color3.new(0.9960784316062927,0.9529411792755127,0.7333333492279053), UnionColoring=false} end
if P[932] then colT[#colT+1] = {Part=P[932], Color=Color3.new(0.800000011920929,0.5568627715110779,0.4117647111415863), UnionColoring=false} end
if P[1219] then colT[#colT+1] = {Part=P[1219], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[1217] then colT[#colT+1] = {Part=P[1217], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[194] then colT[#colT+1] = {Part=P[194], Color=Color3.new(0.9058823585510254,0.9058823585510254,0.9254902005195618), UnionColoring=false} end
if P[744] then colT[#colT+1] = {Part=P[744], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[472] then colT[#colT+1] = {Part=P[472], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[877] then colT[#colT+1] = {Part=P[877], Color=Color3.new(0.32549020648002625,0.2078431397676468,0.14509804546833038), UnionColoring=false} end
if P[1208] then colT[#colT+1] = {Part=P[1208], Color=Color3.new(0.8039215803146362,0.8039215803146362,0.8039215803146362), UnionColoring=false} end
if P[50] then colT[#colT+1] = {Part=P[50], Color=Color3.new(0.9450980424880981,0.8666666746139526,0.7764706015586853), UnionColoring=false} end
if P[773] then colT[#colT+1] = {Part=P[773], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1080] then colT[#colT+1] = {Part=P[1080], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[830] then colT[#colT+1] = {Part=P[830], Color=Color3.new(0.32549020648002625,0.2078431397676468,0.14509804546833038), UnionColoring=false} end
if P[1108] then colT[#colT+1] = {Part=P[1108], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1207] then colT[#colT+1] = {Part=P[1207], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[981] then colT[#colT+1] = {Part=P[981], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[588] then colT[#colT+1] = {Part=P[588], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1205] then colT[#colT+1] = {Part=P[1205], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1314] then colT[#colT+1] = {Part=P[1314], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[841] then colT[#colT+1] = {Part=P[841], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[715] then colT[#colT+1] = {Part=P[715], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[802] then colT[#colT+1] = {Part=P[802], Color=Color3.new(0.01568627543747425,0.686274528503418,0.9254902005195618), UnionColoring=false} end
if P[856] then colT[#colT+1] = {Part=P[856], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[1057] then colT[#colT+1] = {Part=P[1057], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[433] then colT[#colT+1] = {Part=P[433], Color=Color3.new(0.5215686559677124,0.2980392277240753,0.8980392217636108), UnionColoring=false} end
if P[1128] then colT[#colT+1] = {Part=P[1128], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[853] then colT[#colT+1] = {Part=P[853], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[1146] then colT[#colT+1] = {Part=P[1146], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[202] then colT[#colT+1] = {Part=P[202], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[122] then colT[#colT+1] = {Part=P[122], Color=Color3.new(0.9764705896377563,0.9764705896377563,0.9764705896377563), UnionColoring=false} end
if P[1190] then colT[#colT+1] = {Part=P[1190], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[546] then colT[#colT+1] = {Part=P[546], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1186] then colT[#colT+1] = {Part=P[1186], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[698] then colT[#colT+1] = {Part=P[698], Color=Color3.new(0.32549020648002625,0.2078431397676468,0.14509804546833038), UnionColoring=false} end
if P[640] then colT[#colT+1] = {Part=P[640], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[848] then colT[#colT+1] = {Part=P[848], Color=Color3.new(0.8039215803146362,0.8039215803146362,0.8039215803146362), UnionColoring=false} end
if P[1176] then colT[#colT+1] = {Part=P[1176], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[556] then colT[#colT+1] = {Part=P[556], Color=Color3.new(0.800000011920929,0.5568627715110779,0.4117647111415863), UnionColoring=false} end
if P[1175] then colT[#colT+1] = {Part=P[1175], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[791] then colT[#colT+1] = {Part=P[791], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[882] then colT[#colT+1] = {Part=P[882], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[836] then colT[#colT+1] = {Part=P[836], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[1173] then colT[#colT+1] = {Part=P[1173], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[752] then colT[#colT+1] = {Part=P[752], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[811] then colT[#colT+1] = {Part=P[811], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[807] then colT[#colT+1] = {Part=P[807], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[489] then colT[#colT+1] = {Part=P[489], Color=Color3.new(0.9960784316062927,0.9529411792755127,0.7333333492279053), UnionColoring=false} end
if P[935] then colT[#colT+1] = {Part=P[935], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1160] then colT[#colT+1] = {Part=P[1160], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[527] then colT[#colT+1] = {Part=P[527], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1156] then colT[#colT+1] = {Part=P[1156], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[734] then colT[#colT+1] = {Part=P[734], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[506] then colT[#colT+1] = {Part=P[506], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[995] then colT[#colT+1] = {Part=P[995], Color=Color3.new(0.6274510025978088,0.33725491166114807,0.1411764770746231), UnionColoring=false} end
if P[104] then colT[#colT+1] = {Part=P[104], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[823] then colT[#colT+1] = {Part=P[823], Color=Color3.new(0.8039215803146362,0.8039215803146362,0.8039215803146362), UnionColoring=false} end
if P[1138] then colT[#colT+1] = {Part=P[1138], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[1127] then colT[#colT+1] = {Part=P[1127], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[821] then colT[#colT+1] = {Part=P[821], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[1125] then colT[#colT+1] = {Part=P[1125], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1015] then colT[#colT+1] = {Part=P[1015], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[799] then colT[#colT+1] = {Part=P[799], Color=Color3.new(0.27843138575553894,0.38823530077934265,0.3490196168422699), UnionColoring=false} end
if P[747] then colT[#colT+1] = {Part=P[747], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1046] then colT[#colT+1] = {Part=P[1046], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[185] then colT[#colT+1] = {Part=P[185], Color=Color3.new(0.13725490868091583,0.13725490868091583,0.13725490868091583), UnionColoring=false} end
if P[1121] then colT[#colT+1] = {Part=P[1121], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[363] then colT[#colT+1] = {Part=P[363], Color=Color3.new(0.3176470696926117,0.6000000238418579,0.2980392277240753), UnionColoring=false} end
if P[857] then colT[#colT+1] = {Part=P[857], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[43] then colT[#colT+1] = {Part=P[43], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[288] then colT[#colT+1] = {Part=P[288], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[902] then colT[#colT+1] = {Part=P[902], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[949] then colT[#colT+1] = {Part=P[949], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1230] then colT[#colT+1] = {Part=P[1230], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[739] then colT[#colT+1] = {Part=P[739], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1097] then colT[#colT+1] = {Part=P[1097], Color=Color3.new(0.9960784316062927,0.9529411792755127,0.7333333492279053), UnionColoring=false} end
if P[834] then colT[#colT+1] = {Part=P[834], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[736] then colT[#colT+1] = {Part=P[736], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[766] then colT[#colT+1] = {Part=P[766], Color=Color3.new(0.43529412150382996,0.4274509847164154,0.40392157435417175), UnionColoring=false} end
if P[803] then colT[#colT+1] = {Part=P[803], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[726] then colT[#colT+1] = {Part=P[726], Color=Color3.new(0.6274510025978088,0.33725491166114807,0.1411764770746231), UnionColoring=false} end
if P[1091] then colT[#colT+1] = {Part=P[1091], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[795] then colT[#colT+1] = {Part=P[795], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[548] then colT[#colT+1] = {Part=P[548], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1078] then colT[#colT+1] = {Part=P[1078], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[721] then colT[#colT+1] = {Part=P[721], Color=Color3.new(0.7372549176216125,0.6078431606292725,0.364705890417099), UnionColoring=false} end
if P[119] then colT[#colT+1] = {Part=P[119], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[611] then colT[#colT+1] = {Part=P[611], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[530] then colT[#colT+1] = {Part=P[530], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[1278] then colT[#colT+1] = {Part=P[1278], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[756] then colT[#colT+1] = {Part=P[756], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[947] then colT[#colT+1] = {Part=P[947], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[508] then colT[#colT+1] = {Part=P[508], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[85] then colT[#colT+1] = {Part=P[85], Color=Color3.new(0.9450980424880981,0.8666666746139526,0.7764706015586853), UnionColoring=false} end
if P[163] then colT[#colT+1] = {Part=P[163], Color=Color3.new(0,0,0), UnionColoring=false} end
if P[746] then colT[#colT+1] = {Part=P[746], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1072] then colT[#colT+1] = {Part=P[1072], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[622] then colT[#colT+1] = {Part=P[622], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[175] then colT[#colT+1] = {Part=P[175], Color=Color3.new(0,0,0), UnionColoring=false} end
if P[916] then colT[#colT+1] = {Part=P[916], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1061] then colT[#colT+1] = {Part=P[1061], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1034] then colT[#colT+1] = {Part=P[1034], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[810] then colT[#colT+1] = {Part=P[810], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[565] then colT[#colT+1] = {Part=P[565], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[920] then colT[#colT+1] = {Part=P[920], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[870] then colT[#colT+1] = {Part=P[870], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[1124] then colT[#colT+1] = {Part=P[1124], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[580] then colT[#colT+1] = {Part=P[580], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[261] then colT[#colT+1] = {Part=P[261], Color=Color3.new(0.9764705896377563,0.9764705896377563,0.9764705896377563), UnionColoring=false} end
if P[779] then colT[#colT+1] = {Part=P[779], Color=Color3.new(0.21176470816135406,0.16078431904315948,0.13333334028720856), UnionColoring=false} end
if P[876] then colT[#colT+1] = {Part=P[876], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1032] then colT[#colT+1] = {Part=P[1032], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[858] then colT[#colT+1] = {Part=P[858], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[617] then colT[#colT+1] = {Part=P[617], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1020] then colT[#colT+1] = {Part=P[1020], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[266] then colT[#colT+1] = {Part=P[266], Color=Color3.new(0.9764705896377563,0.9764705896377563,0.9764705896377563), UnionColoring=false} end
if P[1019] then colT[#colT+1] = {Part=P[1019], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1016] then colT[#colT+1] = {Part=P[1016], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[158] then colT[#colT+1] = {Part=P[158], Color=Color3.new(0.9764705896377563,0.9764705896377563,0.9764705896377563), UnionColoring=false} end
if P[845] then colT[#colT+1] = {Part=P[845], Color=Color3.new(0.8039215803146362,0.8039215803146362,0.8039215803146362), UnionColoring=false} end
if P[731] then colT[#colT+1] = {Part=P[731], Color=Color3.new(1,1,0.800000011920929), UnionColoring=false} end
if P[1011] then colT[#colT+1] = {Part=P[1011], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[1000] then colT[#colT+1] = {Part=P[1000], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[996] then colT[#colT+1] = {Part=P[996], Color=Color3.new(0.6274510025978088,0.33725491166114807,0.1411764770746231), UnionColoring=false} end
if P[884] then colT[#colT+1] = {Part=P[884], Color=Color3.new(0.05098039284348488,0.4117647111415863,0.6745098233222961), UnionColoring=false} end
if P[1141] then colT[#colT+1] = {Part=P[1141], Color=Color3.new(0.8039215803146362,0.8039215803146362,0.8039215803146362), UnionColoring=false} end
if P[958] then colT[#colT+1] = {Part=P[958], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[911] then colT[#colT+1] = {Part=P[911], Color=Color3.new(0.2078431397676468,0.16862745583057404,0.1411764770746231), UnionColoring=false} end
if P[511] then colT[#colT+1] = {Part=P[511], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[994] then colT[#colT+1] = {Part=P[994], Color=Color3.new(0.6274510025978088,0.33725491166114807,0.1411764770746231), UnionColoring=false} end
if P[993] then colT[#colT+1] = {Part=P[993], Color=Color3.new(0.6274510025978088,0.33725491166114807,0.1411764770746231), UnionColoring=false} end
if P[1074] then colT[#colT+1] = {Part=P[1074], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[991] then colT[#colT+1] = {Part=P[991], Color=Color3.new(0.6274510025978088,0.33725491166114807,0.1411764770746231), UnionColoring=false} end
if P[844] then colT[#colT+1] = {Part=P[844], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[990] then colT[#colT+1] = {Part=P[990], Color=Color3.new(0.6274510025978088,0.33725491166114807,0.1411764770746231), UnionColoring=false} end
if P[987] then colT[#colT+1] = {Part=P[987], Color=Color3.new(0.38823530077934265,0.37254902720451355,0.3843137323856354), UnionColoring=false} end
if P[985] then colT[#colT+1] = {Part=P[985], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[964] then colT[#colT+1] = {Part=P[964], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[975] then colT[#colT+1] = {Part=P[975], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[192] then colT[#colT+1] = {Part=P[192], Color=Color3.new(0.9058823585510254,0.9058823585510254,0.9254902005195618), UnionColoring=false} end
if P[973] then colT[#colT+1] = {Part=P[973], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1253] then colT[#colT+1] = {Part=P[1253], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[310] then colT[#colT+1] = {Part=P[310], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[809] then colT[#colT+1] = {Part=P[809], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[780] then colT[#colT+1] = {Part=P[780], Color=Color3.new(0.27843138575553894,0.38823530077934265,0.3490196168422699), UnionColoring=false} end
if P[595] then colT[#colT+1] = {Part=P[595], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[200] then colT[#colT+1] = {Part=P[200], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[966] then colT[#colT+1] = {Part=P[966], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[429] then colT[#colT+1] = {Part=P[429], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[776] then colT[#colT+1] = {Part=P[776], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[515] then colT[#colT+1] = {Part=P[515], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[461] then colT[#colT+1] = {Part=P[461], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[983] then colT[#colT+1] = {Part=P[983], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[669] then colT[#colT+1] = {Part=P[669], Color=Color3.new(0.7372549176216125,0.6078431606292725,0.364705890417099), UnionColoring=false} end
if P[786] then colT[#colT+1] = {Part=P[786], Color=Color3.new(0.6274510025978088,0.33725491166114807,0.1411764770746231), UnionColoring=false} end
if P[960] then colT[#colT+1] = {Part=P[960], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[956] then colT[#colT+1] = {Part=P[956], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[72] then colT[#colT+1] = {Part=P[72], Color=Color3.new(0,0,0), UnionColoring=false} end
if P[926] then colT[#colT+1] = {Part=P[926], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[514] then colT[#colT+1] = {Part=P[514], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[790] then colT[#colT+1] = {Part=P[790], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[703] then colT[#colT+1] = {Part=P[703], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[954] then colT[#colT+1] = {Part=P[954], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[714] then colT[#colT+1] = {Part=P[714], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[605] then colT[#colT+1] = {Part=P[605], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[436] then colT[#colT+1] = {Part=P[436], Color=Color3.new(0.5215686559677124,0.2980392277240753,0.8980392217636108), UnionColoring=false} end
if P[945] then colT[#colT+1] = {Part=P[945], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[204] then colT[#colT+1] = {Part=P[204], Color=Color3.new(0.9490196108818054,0.9529411792755127,0.9529411792755127), UnionColoring=false} end
if P[941] then colT[#colT+1] = {Part=P[941], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[525] then colT[#colT+1] = {Part=P[525], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[939] then colT[#colT+1] = {Part=P[939], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[414] then colT[#colT+1] = {Part=P[414], Color=Color3.new(0.6235294342041016,0.45490196347236633,0.6823529601097107), UnionColoring=false} end
if P[77] then colT[#colT+1] = {Part=P[77], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[664] then colT[#colT+1] = {Part=P[664], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[1161] then colT[#colT+1] = {Part=P[1161], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[930] then colT[#colT+1] = {Part=P[930], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[670] then colT[#colT+1] = {Part=P[670], Color=Color3.new(0.7372549176216125,0.6078431606292725,0.364705890417099), UnionColoring=false} end
if P[928] then colT[#colT+1] = {Part=P[928], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[573] then colT[#colT+1] = {Part=P[573], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[924] then colT[#colT+1] = {Part=P[924], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1047] then colT[#colT+1] = {Part=P[1047], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[307] then colT[#colT+1] = {Part=P[307], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[680] then colT[#colT+1] = {Part=P[680], Color=Color3.new(0.27843138575553894,0.38823530077934265,0.3490196168422699), UnionColoring=false} end
if P[913] then colT[#colT+1] = {Part=P[913], Color=Color3.new(0.800000011920929,0.5568627715110779,0.4117647111415863), UnionColoring=false} end
if P[909] then colT[#colT+1] = {Part=P[909], Color=Color3.new(0.800000011920929,0.5568627715110779,0.4117647111415863), UnionColoring=false} end
if P[906] then colT[#colT+1] = {Part=P[906], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[904] then colT[#colT+1] = {Part=P[904], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[900] then colT[#colT+1] = {Part=P[900], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[453] then colT[#colT+1] = {Part=P[453], Color=Color3.new(0.6392157077789307,0.6313725709915161,0.6431372761726379), UnionColoring=false} end
if P[894] then colT[#colT+1] = {Part=P[894], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[890] then colT[#colT+1] = {Part=P[890], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[634] then colT[#colT+1] = {Part=P[634], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[886] then colT[#colT+1] = {Part=P[886], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[463] then colT[#colT+1] = {Part=P[463], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1042] then colT[#colT+1] = {Part=P[1042], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[196] then colT[#colT+1] = {Part=P[196], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[847] then colT[#colT+1] = {Part=P[847], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[567] then colT[#colT+1] = {Part=P[567], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[554] then colT[#colT+1] = {Part=P[554], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[487] then colT[#colT+1] = {Part=P[487], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[697] then colT[#colT+1] = {Part=P[697], Color=Color3.new(0.6274510025978088,0.33725491166114807,0.1411764770746231), UnionColoring=false} end
if P[187] then colT[#colT+1] = {Part=P[187], Color=Color3.new(0.13725490868091583,0.13725490868091583,0.13725490868091583), UnionColoring=false} end
if P[937] then colT[#colT+1] = {Part=P[937], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[872] then colT[#colT+1] = {Part=P[872], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[867] then colT[#colT+1] = {Part=P[867], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[720] then colT[#colT+1] = {Part=P[720], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[592] then colT[#colT+1] = {Part=P[592], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[813] then colT[#colT+1] = {Part=P[813], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[355] then colT[#colT+1] = {Part=P[355], Color=Color3.new(0.3176470696926117,0.6000000238418579,0.2980392277240753), UnionColoring=false} end
if P[828] then colT[#colT+1] = {Part=P[828], Color=Color3.new(0.6274510025978088,0.33725491166114807,0.1411764770746231), UnionColoring=false} end
if P[370] then colT[#colT+1] = {Part=P[370], Color=Color3.new(0.1568627506494522,0.47843137383461,0.2705882489681244), UnionColoring=false} end
if P[528] then colT[#colT+1] = {Part=P[528], Color=Color3.new(0.38823530077934265,0.37254902720451355,0.3843137323856354), UnionColoring=false} end
if P[481] then colT[#colT+1] = {Part=P[481], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[677] then colT[#colT+1] = {Part=P[677], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[1328] then colT[#colT+1] = {Part=P[1328], Color=Color3.new(0.38823530077934265,0.37254902720451355,0.3843137323856354), UnionColoring=false} end
if P[1313] then colT[#colT+1] = {Part=P[1313], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[859] then colT[#colT+1] = {Part=P[859], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[1030] then colT[#colT+1] = {Part=P[1030], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[1119] then colT[#colT+1] = {Part=P[1119], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[850] then colT[#colT+1] = {Part=P[850], Color=Color3.new(0.21176470816135406,0.16078431904315948,0.13333334028720856), UnionColoring=false} end
if P[1095] then colT[#colT+1] = {Part=P[1095], Color=Color3.new(0.9960784316062927,0.9529411792755127,0.7333333492279053), UnionColoring=false} end
if P[57] then colT[#colT+1] = {Part=P[57], Color=Color3.new(0,0,0), UnionColoring=false} end
if P[40] then colT[#colT+1] = {Part=P[40], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1211] then colT[#colT+1] = {Part=P[1211], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[827] then colT[#colT+1] = {Part=P[827], Color=Color3.new(0.48627451062202454,0.3607843220233917,0.27450981736183167), UnionColoring=false} end
if P[563] then colT[#colT+1] = {Part=P[563], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[91] then colT[#colT+1] = {Part=P[91], Color=Color3.new(0,0,0), UnionColoring=false} end
if P[896] then colT[#colT+1] = {Part=P[896], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[705] then colT[#colT+1] = {Part=P[705], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[825] then colT[#colT+1] = {Part=P[825], Color=Color3.new(0.4156862795352936,0.2235294133424759,0.03529411926865578), UnionColoring=false} end
if P[1140] then colT[#colT+1] = {Part=P[1140], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[599] then colT[#colT+1] = {Part=P[599], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[951] then colT[#colT+1] = {Part=P[951], Color=Color3.new(0.800000011920929,0.5568627715110779,0.4117647111415863), UnionColoring=false} end
if P[465] then colT[#colT+1] = {Part=P[465], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[322] then colT[#colT+1] = {Part=P[322], Color=Color3.new(0.3803921639919281,0.0941176488995552,0.07450980693101883), UnionColoring=false} end
if P[586] then colT[#colT+1] = {Part=P[586], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[510] then colT[#colT+1] = {Part=P[510], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[438] then colT[#colT+1] = {Part=P[438], Color=Color3.new(0.5215686559677124,0.2980392277240753,0.8980392217636108), UnionColoring=false} end
if P[760] then colT[#colT+1] = {Part=P[760], Color=Color3.new(0.32549020648002625,0.2078431397676468,0.14509804546833038), UnionColoring=false} end
if P[171] then colT[#colT+1] = {Part=P[171], Color=Color3.new(0,0,0), UnionColoring=false} end
if P[544] then colT[#colT+1] = {Part=P[544], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[571] then colT[#colT+1] = {Part=P[571], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[584] then colT[#colT+1] = {Part=P[584], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[352] then colT[#colT+1] = {Part=P[352], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[469] then colT[#colT+1] = {Part=P[469], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[242] then colT[#colT+1] = {Part=P[242], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[180] then colT[#colT+1] = {Part=P[180], Color=Color3.new(0.13725490868091583,0.13725490868091583,0.13725490868091583), UnionColoring=false} end
if P[819] then colT[#colT+1] = {Part=P[819], Color=Color3.new(0.8039215803146362,0.8039215803146362,0.8039215803146362), UnionColoring=false} end
if P[97] then colT[#colT+1] = {Part=P[97], Color=Color3.new(0.9764705896377563,0.9764705896377563,0.9764705896377563), UnionColoring=false} end
if P[459] then colT[#colT+1] = {Part=P[459], Color=Color3.new(0.9960784316062927,0.9529411792755127,0.7333333492279053), UnionColoring=false} end
if P[348] then colT[#colT+1] = {Part=P[348], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[875] then colT[#colT+1] = {Part=P[875], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[735] then colT[#colT+1] = {Part=P[735], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[491] then colT[#colT+1] = {Part=P[491], Color=Color3.new(0.9960784316062927,0.9529411792755127,0.7333333492279053), UnionColoring=false} end
if P[360] then colT[#colT+1] = {Part=P[360], Color=Color3.new(0.3176470696926117,0.6000000238418579,0.2980392277240753), UnionColoring=false} end
if P[817] then colT[#colT+1] = {Part=P[817], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[814] then colT[#colT+1] = {Part=P[814], Color=Color3.new(0.21176470816135406,0.16078431904315948,0.13333334028720856), UnionColoring=false} end
if P[590] then colT[#colT+1] = {Part=P[590], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[753] then colT[#colT+1] = {Part=P[753], Color=Color3.new(0.27843138575553894,0.38823530077934265,0.3490196168422699), UnionColoring=false} end
if P[1171] then colT[#colT+1] = {Part=P[1171], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[615] then colT[#colT+1] = {Part=P[615], Color=Color3.new(0.9960784316062927,0.9529411792755127,0.7333333492279053), UnionColoring=false} end
if P[32] then colT[#colT+1] = {Part=P[32], Color=Color3.new(0.9764705896377563,0.9764705896377563,0.9764705896377563), UnionColoring=false} end
if P[808] then colT[#colT+1] = {Part=P[808], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[647] then colT[#colT+1] = {Part=P[647], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[16] then colT[#colT+1] = {Part=P[16], Color=Color3.new(0.06666667014360428,0.06666667014360428,0.06666667014360428), UnionColoring=false} end
if P[729] then colT[#colT+1] = {Part=P[729], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[445] then colT[#colT+1] = {Part=P[445], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[632] then colT[#colT+1] = {Part=P[632], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[741] then colT[#colT+1] = {Part=P[741], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[385] then colT[#colT+1] = {Part=P[385], Color=Color3.new(0.3176470696926117,0.6000000238418579,0.2980392277240753), UnionColoring=false} end
if P[655] then colT[#colT+1] = {Part=P[655], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[193] then colT[#colT+1] = {Part=P[193], Color=Color3.new(0.9058823585510254,0.9058823585510254,0.9254902005195618), UnionColoring=false} end
if P[774] then colT[#colT+1] = {Part=P[774], Color=Color3.new(0.6274510025978088,0.33725491166114807,0.1411764770746231), UnionColoring=false} end
if P[629] then colT[#colT+1] = {Part=P[629], Color=Color3.new(0.8039215803146362,0.8039215803146362,0.8039215803146362), UnionColoring=false} end
if P[688] then colT[#colT+1] = {Part=P[688], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[962] then colT[#colT+1] = {Part=P[962], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[777] then colT[#colT+1] = {Part=P[777], Color=Color3.new(0.7372549176216125,0.6078431606292725,0.364705890417099), UnionColoring=false} end
if P[822] then colT[#colT+1] = {Part=P[822], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[829] then colT[#colT+1] = {Part=P[829], Color=Color3.new(0.43529412150382996,0.4274509847164154,0.40392157435417175), UnionColoring=false} end
if P[768] then colT[#colT+1] = {Part=P[768], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[668] then colT[#colT+1] = {Part=P[668], Color=Color3.new(0.27843138575553894,0.38823530077934265,0.3490196168422699), UnionColoring=false} end
if P[866] then colT[#colT+1] = {Part=P[866], Color=Color3.new(0.6274510025978088,0.37254902720451355,0.2078431397676468), UnionColoring=false} end
if P[778] then colT[#colT+1] = {Part=P[778], Color=Color3.new(0.6274510025978088,0.33725491166114807,0.1411764770746231), UnionColoring=false} end
if P[578] then colT[#colT+1] = {Part=P[578], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1093] then colT[#colT+1] = {Part=P[1093], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1225] then colT[#colT+1] = {Part=P[1225], Color=Color3.new(0.8039215803146362,0.8039215803146362,0.8039215803146362), UnionColoring=false} end
if P[9] then colT[#colT+1] = {Part=P[9], Color=Color3.new(0.9764705896377563,0.9764705896377563,0.9764705896377563), UnionColoring=false} end
if P[550] then colT[#colT+1] = {Part=P[550], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[271] then colT[#colT+1] = {Part=P[271], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[743] then colT[#colT+1] = {Part=P[743], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[787] then colT[#colT+1] = {Part=P[787], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[737] then colT[#colT+1] = {Part=P[737], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[888] then colT[#colT+1] = {Part=P[888], Color=Color3.new(0.9725490212440491,0.9725490212440491,0.9725490212440491), UnionColoring=false} end
if P[296] then colT[#colT+1] = {Part=P[296], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[542] then colT[#colT+1] = {Part=P[542], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[552] then colT[#colT+1] = {Part=P[552], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1267] then colT[#colT+1] = {Part=P[1267], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[559] then colT[#colT+1] = {Part=P[559], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[1268] then colT[#colT+1] = {Part=P[1268], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[537] then colT[#colT+1] = {Part=P[537], Color=Color3.new(0.800000011920929,0.5568627715110779,0.4117647111415863), UnionColoring=false} end
if P[704] then colT[#colT+1] = {Part=P[704], Color=Color3.new(0.6235294342041016,0.6313725709915161,0.6745098233222961), UnionColoring=false} end
if P[710] then colT[#colT+1] = {Part=P[710], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[1191] then colT[#colT+1] = {Part=P[1191], Color=Color3.new(0.10588235408067703,0.16470588743686676,0.2078431397676468), UnionColoring=false} end
if P[712] then colT[#colT+1] = {Part=P[712], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[533] then colT[#colT+1] = {Part=P[533], Color=Color3.new(0.800000011920929,0.5568627715110779,0.4117647111415863), UnionColoring=false} end
if P[535] then colT[#colT+1] = {Part=P[535], Color=Color3.new(0.2078431397676468,0.16862745583057404,0.1411764770746231), UnionColoring=false} end
if P[918] then colT[#colT+1] = {Part=P[918], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[37] then colT[#colT+1] = {Part=P[37], Color=Color3.new(0.9764705896377563,0.9764705896377563,0.9764705896377563), UnionColoring=false} end
if P[74] then colT[#colT+1] = {Part=P[74], Color=Color3.new(0,0,0), UnionColoring=false} end
if P[666] then colT[#colT+1] = {Part=P[666], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[601] then colT[#colT+1] = {Part=P[601], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[613] then colT[#colT+1] = {Part=P[613], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[387] then colT[#colT+1] = {Part=P[387], Color=Color3.new(0.6392157077789307,0.6352941393852234,0.6470588445663452), UnionColoring=false} end
if P[862] then colT[#colT+1] = {Part=P[862], Color=Color3.new(0.19607843458652496,0.19607843458652496,0.19607843458652496), UnionColoring=false} end
if P[693] then colT[#colT+1] = {Part=P[693], Color=Color3.new(0.4117647111415863,0.4000000059604645,0.3607843220233917), UnionColoring=false} end
if P[167] then colT[#colT+1] = {Part=P[167], Color=Color3.new(0,0,0), UnionColoring=false} end
if P[191] then colT[#colT+1] = {Part=P[191], Color=Color3.new(0.9058823585510254,0.9058823585510254,0.9254902005195618), UnionColoring=false} end
bColor(endpoint, colT)
local ccT = {}
if P[6] then ccT[#ccT+1] = {Part=P[6], CanCollide=false} end
if P[673] then ccT[#ccT+1] = {Part=P[673], CanCollide=true} end
if P[815] then ccT[#ccT+1] = {Part=P[815], CanCollide=true} end
if P[685] then ccT[#ccT+1] = {Part=P[685], CanCollide=true} end
if P[561] then ccT[#ccT+1] = {Part=P[561], CanCollide=false} end
if P[892] then ccT[#ccT+1] = {Part=P[892], CanCollide=true} end
if P[725] then ccT[#ccT+1] = {Part=P[725], CanCollide=true} end
if P[41] then ccT[#ccT+1] = {Part=P[41], CanCollide=false} end
if P[675] then ccT[#ccT+1] = {Part=P[675], CanCollide=true} end
if P[357] then ccT[#ccT+1] = {Part=P[357], CanCollide=true} end
if P[871] then ccT[#ccT+1] = {Part=P[871], CanCollide=true} end
if P[124] then ccT[#ccT+1] = {Part=P[124], CanCollide=false} end
if P[1201] then ccT[#ccT+1] = {Part=P[1201], CanCollide=true} end
if P[182] then ccT[#ccT+1] = {Part=P[182], CanCollide=true} end
if P[320] then ccT[#ccT+1] = {Part=P[320], CanCollide=false} end
if P[855] then ccT[#ccT+1] = {Part=P[855], CanCollide=true} end
if P[1188] then ccT[#ccT+1] = {Part=P[1188], CanCollide=true} end
if P[762] then ccT[#ccT+1] = {Part=P[762], CanCollide=true} end
if P[597] then ccT[#ccT+1] = {Part=P[597], CanCollide=false} end
if P[184] then ccT[#ccT+1] = {Part=P[184], CanCollide=false} end
if P[804] then ccT[#ccT+1] = {Part=P[804], CanCollide=true} end
if P[402] then ccT[#ccT+1] = {Part=P[402], CanCollide=false} end
if P[569] then ccT[#ccT+1] = {Part=P[569], CanCollide=false} end
if P[582] then ccT[#ccT+1] = {Part=P[582], CanCollide=false} end
if P[512] then ccT[#ccT+1] = {Part=P[512], CanCollide=true} end
if P[279] then ccT[#ccT+1] = {Part=P[279], CanCollide=false} end
if P[742] then ccT[#ccT+1] = {Part=P[742], CanCollide=true} end
if P[748] then ccT[#ccT+1] = {Part=P[748], CanCollide=true} end
if P[478] then ccT[#ccT+1] = {Part=P[478], CanCollide=true} end
if P[767] then ccT[#ccT+1] = {Part=P[767], CanCollide=true} end
if P[607] then ccT[#ccT+1] = {Part=P[607], CanCollide=false} end
if P[979] then ccT[#ccT+1] = {Part=P[979], CanCollide=false} end
if P[788] then ccT[#ccT+1] = {Part=P[788], CanCollide=true} end
if P[1123] then ccT[#ccT+1] = {Part=P[1123], CanCollide=true} end
if P[575] then ccT[#ccT+1] = {Part=P[575], CanCollide=true} end
if P[782] then ccT[#ccT+1] = {Part=P[782], CanCollide=true} end
if P[1081] then ccT[#ccT+1] = {Part=P[1081], CanCollide=true} end
if P[1062] then ccT[#ccT+1] = {Part=P[1062], CanCollide=true} end
if P[1017] then ccT[#ccT+1] = {Part=P[1017], CanCollide=true} end
if P[868] then ccT[#ccT+1] = {Part=P[868], CanCollide=true} end
if P[1145] then ccT[#ccT+1] = {Part=P[1145], CanCollide=true} end
if P[1263] then ccT[#ccT+1] = {Part=P[1263], CanCollide=true} end
if P[94] then ccT[#ccT+1] = {Part=P[94], CanCollide=true} end
if P[1239] then ccT[#ccT+1] = {Part=P[1239], CanCollide=true} end
if P[676] then ccT[#ccT+1] = {Part=P[676], CanCollide=true} end
if P[609] then ccT[#ccT+1] = {Part=P[609], CanCollide=false} end
if P[1001] then ccT[#ccT+1] = {Part=P[1001], CanCollide=true} end
if P[1315] then ccT[#ccT+1] = {Part=P[1315], CanCollide=false} end
if P[656] then ccT[#ccT+1] = {Part=P[656], CanCollide=true} end
if P[495] then ccT[#ccT+1] = {Part=P[495], CanCollide=true} end
if P[997] then ccT[#ccT+1] = {Part=P[997], CanCollide=true} end
if P[733] then ccT[#ccT+1] = {Part=P[733], CanCollide=true} end
if P[540] then ccT[#ccT+1] = {Part=P[540], CanCollide=false} end
if P[781] then ccT[#ccT+1] = {Part=P[781], CanCollide=true} end
if P[619] then ccT[#ccT+1] = {Part=P[619], CanCollide=true} end
if P[264] then ccT[#ccT+1] = {Part=P[264], CanCollide=true} end
if P[441] then ccT[#ccT+1] = {Part=P[441], CanCollide=true} end
if P[922] then ccT[#ccT+1] = {Part=P[922], CanCollide=false} end
if P[1223] then ccT[#ccT+1] = {Part=P[1223], CanCollide=false} end
if P[769] then ccT[#ccT+1] = {Part=P[769], CanCollide=true} end
if P[603] then ccT[#ccT+1] = {Part=P[603], CanCollide=false} end
if P[1312] then ccT[#ccT+1] = {Part=P[1312], CanCollide=true} end
if P[789] then ccT[#ccT+1] = {Part=P[789], CanCollide=true} end
if P[745] then ccT[#ccT+1] = {Part=P[745], CanCollide=true} end
if P[812] then ccT[#ccT+1] = {Part=P[812], CanCollide=true} end
if P[898] then ccT[#ccT+1] = {Part=P[898], CanCollide=true} end
if P[732] then ccT[#ccT+1] = {Part=P[732], CanCollide=true} end
if P[391] then ccT[#ccT+1] = {Part=P[391], CanCollide=false} end
if P[681] then ccT[#ccT+1] = {Part=P[681], CanCollide=true} end
if P[309] then ccT[#ccT+1] = {Part=P[309], CanCollide=false} end
if P[88] then ccT[#ccT+1] = {Part=P[88], CanCollide=false} end
if P[1297] then ccT[#ccT+1] = {Part=P[1297], CanCollide=true} end
if P[213] then ccT[#ccT+1] = {Part=P[213], CanCollide=false} end
if P[212] then ccT[#ccT+1] = {Part=P[212], CanCollide=false} end
if P[775] then ccT[#ccT+1] = {Part=P[775], CanCollide=true} end
if P[1295] then ccT[#ccT+1] = {Part=P[1295], CanCollide=true} end
if P[728] then ccT[#ccT+1] = {Part=P[728], CanCollide=true} end
if P[1076] then ccT[#ccT+1] = {Part=P[1076], CanCollide=true} end
if P[1109] then ccT[#ccT+1] = {Part=P[1109], CanCollide=true} end
if P[1013] then ccT[#ccT+1] = {Part=P[1013], CanCollide=true} end
if P[1280] then ccT[#ccT+1] = {Part=P[1280], CanCollide=true} end
if P[42] then ccT[#ccT+1] = {Part=P[42], CanCollide=false} end
if P[313] then ccT[#ccT+1] = {Part=P[313], CanCollide=false} end
if P[1059] then ccT[#ccT+1] = {Part=P[1059], CanCollide=true} end
if P[227] then ccT[#ccT+1] = {Part=P[227], CanCollide=true} end
if P[833] then ccT[#ccT+1] = {Part=P[833], CanCollide=true} end
if P[730] then ccT[#ccT+1] = {Part=P[730], CanCollide=true} end
if P[300] then ccT[#ccT+1] = {Part=P[300], CanCollide=true} end
if P[190] then ccT[#ccT+1] = {Part=P[190], CanCollide=true} end
if P[1040] then ccT[#ccT+1] = {Part=P[1040], CanCollide=true} end
if P[338] then ccT[#ccT+1] = {Part=P[338], CanCollide=false} end
if P[977] then ccT[#ccT+1] = {Part=P[977], CanCollide=false} end
if P[1331] then ccT[#ccT+1] = {Part=P[1331], CanCollide=true} end
if P[1329] then ccT[#ccT+1] = {Part=P[1329], CanCollide=true} end
if P[865] then ccT[#ccT+1] = {Part=P[865], CanCollide=true} end
if P[248] then ccT[#ccT+1] = {Part=P[248], CanCollide=false} end
if P[1326] then ccT[#ccT+1] = {Part=P[1326], CanCollide=false} end
if P[1077] then ccT[#ccT+1] = {Part=P[1077], CanCollide=true} end
if P[1324] then ccT[#ccT+1] = {Part=P[1324], CanCollide=true} end
if P[1317] then ccT[#ccT+1] = {Part=P[1317], CanCollide=true} end
if P[1203] then ccT[#ccT+1] = {Part=P[1203], CanCollide=true} end
if P[245] then ccT[#ccT+1] = {Part=P[245], CanCollide=true} end
if P[852] then ccT[#ccT+1] = {Part=P[852], CanCollide=true} end
if P[1158] then ccT[#ccT+1] = {Part=P[1158], CanCollide=true} end
if P[47] then ccT[#ccT+1] = {Part=P[47], CanCollide=false} end
if P[869] then ccT[#ccT+1] = {Part=P[869], CanCollide=true} end
if P[740] then ccT[#ccT+1] = {Part=P[740], CanCollide=true} end
if P[968] then ccT[#ccT+1] = {Part=P[968], CanCollide=false} end
if P[678] then ccT[#ccT+1] = {Part=P[678], CanCollide=true} end
if P[34] then ccT[#ccT+1] = {Part=P[34], CanCollide=false} end
if P[1310] then ccT[#ccT+1] = {Part=P[1310], CanCollide=true} end
if P[1308] then ccT[#ccT+1] = {Part=P[1308], CanCollide=true} end
if P[1298] then ccT[#ccT+1] = {Part=P[1298], CanCollide=true} end
if P[1206] then ccT[#ccT+1] = {Part=P[1206], CanCollide=true} end
if P[722] then ccT[#ccT+1] = {Part=P[722], CanCollide=true} end
if P[496] then ccT[#ccT+1] = {Part=P[496], CanCollide=true} end
if P[738] then ccT[#ccT+1] = {Part=P[738], CanCollide=true} end
if P[214] then ccT[#ccT+1] = {Part=P[214], CanCollide=false} end
if P[943] then ccT[#ccT+1] = {Part=P[943], CanCollide=false} end
if P[1293] then ccT[#ccT+1] = {Part=P[1293], CanCollide=true} end
if P[992] then ccT[#ccT+1] = {Part=P[992], CanCollide=true} end
if P[1282] then ccT[#ccT+1] = {Part=P[1282], CanCollide=true} end
if P[1283] then ccT[#ccT+1] = {Part=P[1283], CanCollide=true} end
if P[724] then ccT[#ccT+1] = {Part=P[724], CanCollide=true} end
if P[687] then ccT[#ccT+1] = {Part=P[687], CanCollide=true} end
if P[674] then ccT[#ccT+1] = {Part=P[674], CanCollide=true} end
if P[1265] then ccT[#ccT+1] = {Part=P[1265], CanCollide=true} end
if P[971] then ccT[#ccT+1] = {Part=P[971], CanCollide=false} end
if P[1252] then ccT[#ccT+1] = {Part=P[1252], CanCollide=true} end
if P[1248] then ccT[#ccT+1] = {Part=P[1248], CanCollide=true} end
if P[1242] then ccT[#ccT+1] = {Part=P[1242], CanCollide=true} end
if P[1237] then ccT[#ccT+1] = {Part=P[1237], CanCollide=true} end
if P[1236] then ccT[#ccT+1] = {Part=P[1236], CanCollide=true} end
if P[1234] then ccT[#ccT+1] = {Part=P[1234], CanCollide=true} end
if P[854] then ccT[#ccT+1] = {Part=P[854], CanCollide=true} end
if P[1232] then ccT[#ccT+1] = {Part=P[1232], CanCollide=true} end
if P[660] then ccT[#ccT+1] = {Part=P[660], CanCollide=true} end
if P[1099] then ccT[#ccT+1] = {Part=P[1099], CanCollide=true} end
if P[679] then ccT[#ccT+1] = {Part=P[679], CanCollide=true} end
if P[1228] then ccT[#ccT+1] = {Part=P[1228], CanCollide=true} end
if P[1227] then ccT[#ccT+1] = {Part=P[1227], CanCollide=true} end
if P[764] then ccT[#ccT+1] = {Part=P[764], CanCollide=true} end
if P[456] then ccT[#ccT+1] = {Part=P[456], CanCollide=true} end
if P[1220] then ccT[#ccT+1] = {Part=P[1220], CanCollide=true} end
if P[467] then ccT[#ccT+1] = {Part=P[467], CanCollide=true} end
if P[932] then ccT[#ccT+1] = {Part=P[932], CanCollide=true} end
if P[1219] then ccT[#ccT+1] = {Part=P[1219], CanCollide=false} end
if P[1217] then ccT[#ccT+1] = {Part=P[1217], CanCollide=true} end
if P[194] then ccT[#ccT+1] = {Part=P[194], CanCollide=true} end
if P[744] then ccT[#ccT+1] = {Part=P[744], CanCollide=true} end
if P[472] then ccT[#ccT+1] = {Part=P[472], CanCollide=true} end
if P[877] then ccT[#ccT+1] = {Part=P[877], CanCollide=true} end
if P[1208] then ccT[#ccT+1] = {Part=P[1208], CanCollide=true} end
if P[50] then ccT[#ccT+1] = {Part=P[50], CanCollide=false} end
if P[773] then ccT[#ccT+1] = {Part=P[773], CanCollide=true} end
if P[1080] then ccT[#ccT+1] = {Part=P[1080], CanCollide=true} end
if P[830] then ccT[#ccT+1] = {Part=P[830], CanCollide=true} end
if P[1108] then ccT[#ccT+1] = {Part=P[1108], CanCollide=true} end
if P[1207] then ccT[#ccT+1] = {Part=P[1207], CanCollide=true} end
if P[981] then ccT[#ccT+1] = {Part=P[981], CanCollide=false} end
if P[588] then ccT[#ccT+1] = {Part=P[588], CanCollide=false} end
if P[1205] then ccT[#ccT+1] = {Part=P[1205], CanCollide=true} end
if P[1314] then ccT[#ccT+1] = {Part=P[1314], CanCollide=true} end
if P[841] then ccT[#ccT+1] = {Part=P[841], CanCollide=true} end
if P[715] then ccT[#ccT+1] = {Part=P[715], CanCollide=true} end
if P[802] then ccT[#ccT+1] = {Part=P[802], CanCollide=true} end
if P[856] then ccT[#ccT+1] = {Part=P[856], CanCollide=true} end
if P[1057] then ccT[#ccT+1] = {Part=P[1057], CanCollide=true} end
if P[433] then ccT[#ccT+1] = {Part=P[433], CanCollide=true} end
if P[1128] then ccT[#ccT+1] = {Part=P[1128], CanCollide=true} end
if P[853] then ccT[#ccT+1] = {Part=P[853], CanCollide=true} end
if P[1146] then ccT[#ccT+1] = {Part=P[1146], CanCollide=true} end
if P[202] then ccT[#ccT+1] = {Part=P[202], CanCollide=true} end
if P[122] then ccT[#ccT+1] = {Part=P[122], CanCollide=true} end
if P[1190] then ccT[#ccT+1] = {Part=P[1190], CanCollide=true} end
if P[546] then ccT[#ccT+1] = {Part=P[546], CanCollide=false} end
if P[1186] then ccT[#ccT+1] = {Part=P[1186], CanCollide=true} end
if P[698] then ccT[#ccT+1] = {Part=P[698], CanCollide=true} end
if P[640] then ccT[#ccT+1] = {Part=P[640], CanCollide=true} end
if P[848] then ccT[#ccT+1] = {Part=P[848], CanCollide=true} end
if P[1176] then ccT[#ccT+1] = {Part=P[1176], CanCollide=true} end
if P[556] then ccT[#ccT+1] = {Part=P[556], CanCollide=true} end
if P[1175] then ccT[#ccT+1] = {Part=P[1175], CanCollide=true} end
if P[791] then ccT[#ccT+1] = {Part=P[791], CanCollide=true} end
if P[882] then ccT[#ccT+1] = {Part=P[882], CanCollide=true} end
if P[836] then ccT[#ccT+1] = {Part=P[836], CanCollide=true} end
if P[1173] then ccT[#ccT+1] = {Part=P[1173], CanCollide=true} end
if P[752] then ccT[#ccT+1] = {Part=P[752], CanCollide=true} end
if P[811] then ccT[#ccT+1] = {Part=P[811], CanCollide=true} end
if P[807] then ccT[#ccT+1] = {Part=P[807], CanCollide=true} end
if P[489] then ccT[#ccT+1] = {Part=P[489], CanCollide=true} end
if P[935] then ccT[#ccT+1] = {Part=P[935], CanCollide=false} end
if P[1160] then ccT[#ccT+1] = {Part=P[1160], CanCollide=true} end
if P[527] then ccT[#ccT+1] = {Part=P[527], CanCollide=true} end
if P[1156] then ccT[#ccT+1] = {Part=P[1156], CanCollide=true} end
if P[734] then ccT[#ccT+1] = {Part=P[734], CanCollide=true} end
if P[506] then ccT[#ccT+1] = {Part=P[506], CanCollide=true} end
if P[995] then ccT[#ccT+1] = {Part=P[995], CanCollide=true} end
if P[104] then ccT[#ccT+1] = {Part=P[104], CanCollide=true} end
if P[823] then ccT[#ccT+1] = {Part=P[823], CanCollide=true} end
if P[1138] then ccT[#ccT+1] = {Part=P[1138], CanCollide=true} end
if P[1127] then ccT[#ccT+1] = {Part=P[1127], CanCollide=true} end
if P[821] then ccT[#ccT+1] = {Part=P[821], CanCollide=true} end
if P[1125] then ccT[#ccT+1] = {Part=P[1125], CanCollide=true} end
if P[1015] then ccT[#ccT+1] = {Part=P[1015], CanCollide=true} end
if P[799] then ccT[#ccT+1] = {Part=P[799], CanCollide=true} end
if P[747] then ccT[#ccT+1] = {Part=P[747], CanCollide=true} end
if P[1046] then ccT[#ccT+1] = {Part=P[1046], CanCollide=true} end
if P[185] then ccT[#ccT+1] = {Part=P[185], CanCollide=true} end
if P[1121] then ccT[#ccT+1] = {Part=P[1121], CanCollide=true} end
if P[363] then ccT[#ccT+1] = {Part=P[363], CanCollide=true} end
if P[857] then ccT[#ccT+1] = {Part=P[857], CanCollide=true} end
if P[43] then ccT[#ccT+1] = {Part=P[43], CanCollide=false} end
if P[288] then ccT[#ccT+1] = {Part=P[288], CanCollide=false} end
if P[902] then ccT[#ccT+1] = {Part=P[902], CanCollide=true} end
if P[949] then ccT[#ccT+1] = {Part=P[949], CanCollide=false} end
if P[1230] then ccT[#ccT+1] = {Part=P[1230], CanCollide=false} end
if P[739] then ccT[#ccT+1] = {Part=P[739], CanCollide=true} end
if P[1097] then ccT[#ccT+1] = {Part=P[1097], CanCollide=true} end
if P[834] then ccT[#ccT+1] = {Part=P[834], CanCollide=true} end
if P[736] then ccT[#ccT+1] = {Part=P[736], CanCollide=true} end
if P[766] then ccT[#ccT+1] = {Part=P[766], CanCollide=true} end
if P[803] then ccT[#ccT+1] = {Part=P[803], CanCollide=true} end
if P[726] then ccT[#ccT+1] = {Part=P[726], CanCollide=true} end
if P[1091] then ccT[#ccT+1] = {Part=P[1091], CanCollide=true} end
if P[795] then ccT[#ccT+1] = {Part=P[795], CanCollide=true} end
if P[548] then ccT[#ccT+1] = {Part=P[548], CanCollide=false} end
if P[1078] then ccT[#ccT+1] = {Part=P[1078], CanCollide=true} end
if P[721] then ccT[#ccT+1] = {Part=P[721], CanCollide=true} end
if P[119] then ccT[#ccT+1] = {Part=P[119], CanCollide=true} end
if P[611] then ccT[#ccT+1] = {Part=P[611], CanCollide=true} end
if P[530] then ccT[#ccT+1] = {Part=P[530], CanCollide=false} end
if P[1278] then ccT[#ccT+1] = {Part=P[1278], CanCollide=true} end
if P[756] then ccT[#ccT+1] = {Part=P[756], CanCollide=true} end
if P[947] then ccT[#ccT+1] = {Part=P[947], CanCollide=false} end
if P[508] then ccT[#ccT+1] = {Part=P[508], CanCollide=true} end
if P[85] then ccT[#ccT+1] = {Part=P[85], CanCollide=false} end
if P[163] then ccT[#ccT+1] = {Part=P[163], CanCollide=true} end
if P[746] then ccT[#ccT+1] = {Part=P[746], CanCollide=true} end
if P[1072] then ccT[#ccT+1] = {Part=P[1072], CanCollide=true} end
if P[622] then ccT[#ccT+1] = {Part=P[622], CanCollide=true} end
if P[175] then ccT[#ccT+1] = {Part=P[175], CanCollide=true} end
if P[916] then ccT[#ccT+1] = {Part=P[916], CanCollide=false} end
if P[1061] then ccT[#ccT+1] = {Part=P[1061], CanCollide=true} end
if P[1034] then ccT[#ccT+1] = {Part=P[1034], CanCollide=true} end
if P[810] then ccT[#ccT+1] = {Part=P[810], CanCollide=true} end
if P[565] then ccT[#ccT+1] = {Part=P[565], CanCollide=false} end
if P[920] then ccT[#ccT+1] = {Part=P[920], CanCollide=false} end
if P[870] then ccT[#ccT+1] = {Part=P[870], CanCollide=true} end
if P[1124] then ccT[#ccT+1] = {Part=P[1124], CanCollide=true} end
if P[580] then ccT[#ccT+1] = {Part=P[580], CanCollide=false} end
if P[261] then ccT[#ccT+1] = {Part=P[261], CanCollide=true} end
if P[779] then ccT[#ccT+1] = {Part=P[779], CanCollide=true} end
if P[876] then ccT[#ccT+1] = {Part=P[876], CanCollide=true} end
if P[1032] then ccT[#ccT+1] = {Part=P[1032], CanCollide=true} end
if P[858] then ccT[#ccT+1] = {Part=P[858], CanCollide=true} end
if P[617] then ccT[#ccT+1] = {Part=P[617], CanCollide=true} end
if P[1020] then ccT[#ccT+1] = {Part=P[1020], CanCollide=true} end
if P[266] then ccT[#ccT+1] = {Part=P[266], CanCollide=true} end
if P[1019] then ccT[#ccT+1] = {Part=P[1019], CanCollide=true} end
if P[1016] then ccT[#ccT+1] = {Part=P[1016], CanCollide=true} end
if P[158] then ccT[#ccT+1] = {Part=P[158], CanCollide=true} end
if P[845] then ccT[#ccT+1] = {Part=P[845], CanCollide=true} end
if P[731] then ccT[#ccT+1] = {Part=P[731], CanCollide=true} end
if P[1011] then ccT[#ccT+1] = {Part=P[1011], CanCollide=true} end
if P[1000] then ccT[#ccT+1] = {Part=P[1000], CanCollide=true} end
if P[996] then ccT[#ccT+1] = {Part=P[996], CanCollide=true} end
if P[884] then ccT[#ccT+1] = {Part=P[884], CanCollide=true} end
if P[1141] then ccT[#ccT+1] = {Part=P[1141], CanCollide=true} end
if P[958] then ccT[#ccT+1] = {Part=P[958], CanCollide=false} end
if P[911] then ccT[#ccT+1] = {Part=P[911], CanCollide=true} end
if P[511] then ccT[#ccT+1] = {Part=P[511], CanCollide=true} end
if P[994] then ccT[#ccT+1] = {Part=P[994], CanCollide=true} end
if P[993] then ccT[#ccT+1] = {Part=P[993], CanCollide=true} end
if P[1074] then ccT[#ccT+1] = {Part=P[1074], CanCollide=true} end
if P[991] then ccT[#ccT+1] = {Part=P[991], CanCollide=true} end
if P[844] then ccT[#ccT+1] = {Part=P[844], CanCollide=true} end
if P[990] then ccT[#ccT+1] = {Part=P[990], CanCollide=true} end
if P[987] then ccT[#ccT+1] = {Part=P[987], CanCollide=false} end
if P[985] then ccT[#ccT+1] = {Part=P[985], CanCollide=false} end
if P[964] then ccT[#ccT+1] = {Part=P[964], CanCollide=false} end
if P[975] then ccT[#ccT+1] = {Part=P[975], CanCollide=false} end
if P[192] then ccT[#ccT+1] = {Part=P[192], CanCollide=true} end
if P[973] then ccT[#ccT+1] = {Part=P[973], CanCollide=false} end
if P[1253] then ccT[#ccT+1] = {Part=P[1253], CanCollide=true} end
if P[310] then ccT[#ccT+1] = {Part=P[310], CanCollide=false} end
if P[809] then ccT[#ccT+1] = {Part=P[809], CanCollide=true} end
if P[780] then ccT[#ccT+1] = {Part=P[780], CanCollide=true} end
if P[595] then ccT[#ccT+1] = {Part=P[595], CanCollide=false} end
if P[200] then ccT[#ccT+1] = {Part=P[200], CanCollide=true} end
if P[966] then ccT[#ccT+1] = {Part=P[966], CanCollide=false} end
if P[429] then ccT[#ccT+1] = {Part=P[429], CanCollide=true} end
if P[776] then ccT[#ccT+1] = {Part=P[776], CanCollide=true} end
if P[515] then ccT[#ccT+1] = {Part=P[515], CanCollide=true} end
if P[461] then ccT[#ccT+1] = {Part=P[461], CanCollide=true} end
if P[983] then ccT[#ccT+1] = {Part=P[983], CanCollide=false} end
if P[669] then ccT[#ccT+1] = {Part=P[669], CanCollide=true} end
if P[786] then ccT[#ccT+1] = {Part=P[786], CanCollide=true} end
if P[960] then ccT[#ccT+1] = {Part=P[960], CanCollide=false} end
if P[956] then ccT[#ccT+1] = {Part=P[956], CanCollide=false} end
if P[72] then ccT[#ccT+1] = {Part=P[72], CanCollide=false} end
if P[926] then ccT[#ccT+1] = {Part=P[926], CanCollide=false} end
if P[514] then ccT[#ccT+1] = {Part=P[514], CanCollide=true} end
if P[790] then ccT[#ccT+1] = {Part=P[790], CanCollide=true} end
if P[703] then ccT[#ccT+1] = {Part=P[703], CanCollide=true} end
if P[954] then ccT[#ccT+1] = {Part=P[954], CanCollide=false} end
if P[714] then ccT[#ccT+1] = {Part=P[714], CanCollide=true} end
if P[605] then ccT[#ccT+1] = {Part=P[605], CanCollide=false} end
if P[436] then ccT[#ccT+1] = {Part=P[436], CanCollide=true} end
if P[945] then ccT[#ccT+1] = {Part=P[945], CanCollide=false} end
if P[204] then ccT[#ccT+1] = {Part=P[204], CanCollide=true} end
if P[941] then ccT[#ccT+1] = {Part=P[941], CanCollide=false} end
if P[525] then ccT[#ccT+1] = {Part=P[525], CanCollide=true} end
if P[939] then ccT[#ccT+1] = {Part=P[939], CanCollide=false} end
if P[414] then ccT[#ccT+1] = {Part=P[414], CanCollide=true} end
if P[77] then ccT[#ccT+1] = {Part=P[77], CanCollide=false} end
if P[664] then ccT[#ccT+1] = {Part=P[664], CanCollide=true} end
if P[1161] then ccT[#ccT+1] = {Part=P[1161], CanCollide=true} end
if P[930] then ccT[#ccT+1] = {Part=P[930], CanCollide=false} end
if P[670] then ccT[#ccT+1] = {Part=P[670], CanCollide=true} end
if P[928] then ccT[#ccT+1] = {Part=P[928], CanCollide=false} end
if P[573] then ccT[#ccT+1] = {Part=P[573], CanCollide=false} end
if P[924] then ccT[#ccT+1] = {Part=P[924], CanCollide=false} end
if P[1047] then ccT[#ccT+1] = {Part=P[1047], CanCollide=true} end
if P[307] then ccT[#ccT+1] = {Part=P[307], CanCollide=true} end
if P[680] then ccT[#ccT+1] = {Part=P[680], CanCollide=true} end
if P[913] then ccT[#ccT+1] = {Part=P[913], CanCollide=true} end
if P[909] then ccT[#ccT+1] = {Part=P[909], CanCollide=true} end
if P[906] then ccT[#ccT+1] = {Part=P[906], CanCollide=true} end
if P[904] then ccT[#ccT+1] = {Part=P[904], CanCollide=true} end
if P[900] then ccT[#ccT+1] = {Part=P[900], CanCollide=true} end
if P[453] then ccT[#ccT+1] = {Part=P[453], CanCollide=false} end
if P[894] then ccT[#ccT+1] = {Part=P[894], CanCollide=true} end
if P[890] then ccT[#ccT+1] = {Part=P[890], CanCollide=true} end
if P[634] then ccT[#ccT+1] = {Part=P[634], CanCollide=true} end
if P[886] then ccT[#ccT+1] = {Part=P[886], CanCollide=true} end
if P[463] then ccT[#ccT+1] = {Part=P[463], CanCollide=true} end
if P[1042] then ccT[#ccT+1] = {Part=P[1042], CanCollide=true} end
if P[196] then ccT[#ccT+1] = {Part=P[196], CanCollide=true} end
if P[847] then ccT[#ccT+1] = {Part=P[847], CanCollide=true} end
if P[567] then ccT[#ccT+1] = {Part=P[567], CanCollide=false} end
if P[554] then ccT[#ccT+1] = {Part=P[554], CanCollide=false} end
if P[487] then ccT[#ccT+1] = {Part=P[487], CanCollide=true} end
if P[697] then ccT[#ccT+1] = {Part=P[697], CanCollide=true} end
if P[187] then ccT[#ccT+1] = {Part=P[187], CanCollide=true} end
if P[937] then ccT[#ccT+1] = {Part=P[937], CanCollide=false} end
if P[872] then ccT[#ccT+1] = {Part=P[872], CanCollide=true} end
if P[867] then ccT[#ccT+1] = {Part=P[867], CanCollide=true} end
if P[720] then ccT[#ccT+1] = {Part=P[720], CanCollide=true} end
if P[592] then ccT[#ccT+1] = {Part=P[592], CanCollide=false} end
if P[813] then ccT[#ccT+1] = {Part=P[813], CanCollide=true} end
if P[355] then ccT[#ccT+1] = {Part=P[355], CanCollide=true} end
if P[828] then ccT[#ccT+1] = {Part=P[828], CanCollide=true} end
if P[370] then ccT[#ccT+1] = {Part=P[370], CanCollide=true} end
if P[528] then ccT[#ccT+1] = {Part=P[528], CanCollide=false} end
if P[481] then ccT[#ccT+1] = {Part=P[481], CanCollide=true} end
if P[677] then ccT[#ccT+1] = {Part=P[677], CanCollide=true} end
if P[1328] then ccT[#ccT+1] = {Part=P[1328], CanCollide=true} end
if P[1313] then ccT[#ccT+1] = {Part=P[1313], CanCollide=true} end
if P[859] then ccT[#ccT+1] = {Part=P[859], CanCollide=true} end
if P[1030] then ccT[#ccT+1] = {Part=P[1030], CanCollide=true} end
if P[1119] then ccT[#ccT+1] = {Part=P[1119], CanCollide=true} end
if P[850] then ccT[#ccT+1] = {Part=P[850], CanCollide=true} end
if P[1095] then ccT[#ccT+1] = {Part=P[1095], CanCollide=true} end
if P[57] then ccT[#ccT+1] = {Part=P[57], CanCollide=false} end
if P[40] then ccT[#ccT+1] = {Part=P[40], CanCollide=false} end
if P[1211] then ccT[#ccT+1] = {Part=P[1211], CanCollide=true} end
if P[827] then ccT[#ccT+1] = {Part=P[827], CanCollide=false} end
if P[563] then ccT[#ccT+1] = {Part=P[563], CanCollide=false} end
if P[91] then ccT[#ccT+1] = {Part=P[91], CanCollide=false} end
if P[896] then ccT[#ccT+1] = {Part=P[896], CanCollide=true} end
if P[705] then ccT[#ccT+1] = {Part=P[705], CanCollide=true} end
if P[825] then ccT[#ccT+1] = {Part=P[825], CanCollide=true} end
if P[1140] then ccT[#ccT+1] = {Part=P[1140], CanCollide=true} end
if P[599] then ccT[#ccT+1] = {Part=P[599], CanCollide=false} end
if P[951] then ccT[#ccT+1] = {Part=P[951], CanCollide=true} end
if P[465] then ccT[#ccT+1] = {Part=P[465], CanCollide=true} end
if P[322] then ccT[#ccT+1] = {Part=P[322], CanCollide=false} end
if P[586] then ccT[#ccT+1] = {Part=P[586], CanCollide=false} end
if P[510] then ccT[#ccT+1] = {Part=P[510], CanCollide=true} end
if P[438] then ccT[#ccT+1] = {Part=P[438], CanCollide=true} end
if P[760] then ccT[#ccT+1] = {Part=P[760], CanCollide=true} end
if P[171] then ccT[#ccT+1] = {Part=P[171], CanCollide=true} end
if P[544] then ccT[#ccT+1] = {Part=P[544], CanCollide=false} end
if P[571] then ccT[#ccT+1] = {Part=P[571], CanCollide=false} end
if P[584] then ccT[#ccT+1] = {Part=P[584], CanCollide=false} end
if P[352] then ccT[#ccT+1] = {Part=P[352], CanCollide=false} end
if P[469] then ccT[#ccT+1] = {Part=P[469], CanCollide=true} end
if P[242] then ccT[#ccT+1] = {Part=P[242], CanCollide=true} end
if P[180] then ccT[#ccT+1] = {Part=P[180], CanCollide=true} end
if P[819] then ccT[#ccT+1] = {Part=P[819], CanCollide=true} end
if P[97] then ccT[#ccT+1] = {Part=P[97], CanCollide=false} end
if P[459] then ccT[#ccT+1] = {Part=P[459], CanCollide=true} end
if P[348] then ccT[#ccT+1] = {Part=P[348], CanCollide=false} end
if P[875] then ccT[#ccT+1] = {Part=P[875], CanCollide=true} end
if P[735] then ccT[#ccT+1] = {Part=P[735], CanCollide=true} end
if P[491] then ccT[#ccT+1] = {Part=P[491], CanCollide=true} end
if P[360] then ccT[#ccT+1] = {Part=P[360], CanCollide=true} end
if P[817] then ccT[#ccT+1] = {Part=P[817], CanCollide=true} end
if P[814] then ccT[#ccT+1] = {Part=P[814], CanCollide=true} end
if P[590] then ccT[#ccT+1] = {Part=P[590], CanCollide=false} end
if P[753] then ccT[#ccT+1] = {Part=P[753], CanCollide=true} end
if P[1171] then ccT[#ccT+1] = {Part=P[1171], CanCollide=true} end
if P[615] then ccT[#ccT+1] = {Part=P[615], CanCollide=true} end
if P[32] then ccT[#ccT+1] = {Part=P[32], CanCollide=false} end
if P[808] then ccT[#ccT+1] = {Part=P[808], CanCollide=true} end
if P[647] then ccT[#ccT+1] = {Part=P[647], CanCollide=true} end
if P[16] then ccT[#ccT+1] = {Part=P[16], CanCollide=false} end
if P[729] then ccT[#ccT+1] = {Part=P[729], CanCollide=true} end
if P[445] then ccT[#ccT+1] = {Part=P[445], CanCollide=false} end
if P[632] then ccT[#ccT+1] = {Part=P[632], CanCollide=true} end
if P[741] then ccT[#ccT+1] = {Part=P[741], CanCollide=true} end
if P[385] then ccT[#ccT+1] = {Part=P[385], CanCollide=true} end
if P[655] then ccT[#ccT+1] = {Part=P[655], CanCollide=true} end
if P[193] then ccT[#ccT+1] = {Part=P[193], CanCollide=true} end
if P[774] then ccT[#ccT+1] = {Part=P[774], CanCollide=true} end
if P[629] then ccT[#ccT+1] = {Part=P[629], CanCollide=false} end
if P[688] then ccT[#ccT+1] = {Part=P[688], CanCollide=true} end
if P[962] then ccT[#ccT+1] = {Part=P[962], CanCollide=false} end
if P[777] then ccT[#ccT+1] = {Part=P[777], CanCollide=true} end
if P[822] then ccT[#ccT+1] = {Part=P[822], CanCollide=true} end
if P[829] then ccT[#ccT+1] = {Part=P[829], CanCollide=true} end
if P[768] then ccT[#ccT+1] = {Part=P[768], CanCollide=true} end
if P[668] then ccT[#ccT+1] = {Part=P[668], CanCollide=true} end
if P[866] then ccT[#ccT+1] = {Part=P[866], CanCollide=true} end
if P[778] then ccT[#ccT+1] = {Part=P[778], CanCollide=true} end
if P[578] then ccT[#ccT+1] = {Part=P[578], CanCollide=false} end
if P[1093] then ccT[#ccT+1] = {Part=P[1093], CanCollide=true} end
if P[1225] then ccT[#ccT+1] = {Part=P[1225], CanCollide=true} end
if P[9] then ccT[#ccT+1] = {Part=P[9], CanCollide=false} end
if P[550] then ccT[#ccT+1] = {Part=P[550], CanCollide=false} end
if P[271] then ccT[#ccT+1] = {Part=P[271], CanCollide=false} end
if P[743] then ccT[#ccT+1] = {Part=P[743], CanCollide=true} end
if P[787] then ccT[#ccT+1] = {Part=P[787], CanCollide=true} end
if P[737] then ccT[#ccT+1] = {Part=P[737], CanCollide=true} end
if P[888] then ccT[#ccT+1] = {Part=P[888], CanCollide=true} end
if P[296] then ccT[#ccT+1] = {Part=P[296], CanCollide=true} end
if P[542] then ccT[#ccT+1] = {Part=P[542], CanCollide=false} end
if P[552] then ccT[#ccT+1] = {Part=P[552], CanCollide=false} end
if P[1267] then ccT[#ccT+1] = {Part=P[1267], CanCollide=true} end
if P[559] then ccT[#ccT+1] = {Part=P[559], CanCollide=false} end
if P[1268] then ccT[#ccT+1] = {Part=P[1268], CanCollide=true} end
if P[537] then ccT[#ccT+1] = {Part=P[537], CanCollide=true} end
if P[704] then ccT[#ccT+1] = {Part=P[704], CanCollide=true} end
if P[710] then ccT[#ccT+1] = {Part=P[710], CanCollide=true} end
if P[1191] then ccT[#ccT+1] = {Part=P[1191], CanCollide=true} end
if P[712] then ccT[#ccT+1] = {Part=P[712], CanCollide=true} end
if P[533] then ccT[#ccT+1] = {Part=P[533], CanCollide=true} end
if P[535] then ccT[#ccT+1] = {Part=P[535], CanCollide=true} end
if P[918] then ccT[#ccT+1] = {Part=P[918], CanCollide=false} end
if P[37] then ccT[#ccT+1] = {Part=P[37], CanCollide=false} end
if P[74] then ccT[#ccT+1] = {Part=P[74], CanCollide=false} end
if P[666] then ccT[#ccT+1] = {Part=P[666], CanCollide=true} end
if P[601] then ccT[#ccT+1] = {Part=P[601], CanCollide=false} end
if P[613] then ccT[#ccT+1] = {Part=P[613], CanCollide=true} end
if P[387] then ccT[#ccT+1] = {Part=P[387], CanCollide=false} end
if P[862] then ccT[#ccT+1] = {Part=P[862], CanCollide=true} end
if P[693] then ccT[#ccT+1] = {Part=P[693], CanCollide=true} end
if P[167] then ccT[#ccT+1] = {Part=P[167], CanCollide=true} end
if P[191] then ccT[#ccT+1] = {Part=P[191], CanCollide=true} end
bCollision(endpoint, ccT)
if P[6] then task.spawn(function() setName(endpoint, P[6], "Right Arm") end) end
if P[673] then task.spawn(function() setLocked(endpoint, P[673], true) end) end
if P[673] then task.spawn(function() setName(endpoint, P[673], "Part3") end) end
if P[815] then task.spawn(function() setLocked(endpoint, P[815], true) end) end
if P[815] then task.spawn(function() setName(endpoint, P[815], "Part21") end) end
if P[685] then task.spawn(function() setLocked(endpoint, P[685], true) end) end
if P[685] then task.spawn(function() setName(endpoint, P[685], "Part8") end) end
if P[561] then task.spawn(function() setLocked(endpoint, P[561], true) end) end
if P[561] then task.spawn(function() setName(endpoint, P[561], "Part5") end) end
if P[892] then task.spawn(function() setLocked(endpoint, P[892], true) end) end
if P[892] then task.spawn(function() setName(endpoint, P[892], "Light") end) end
if P[725] then task.spawn(function() setLocked(endpoint, P[725], true) end) end
if P[725] then task.spawn(function() setName(endpoint, P[725], "Part13") end) end
if P[41] then task.spawn(function() setName(endpoint, P[41], "Handle") end) end
if P[675] then task.spawn(function() setLocked(endpoint, P[675], true) end) end
if P[675] then task.spawn(function() setName(endpoint, P[675], "Part6") end) end
if P[357] then task.spawn(function() setName(endpoint, P[357], "Right Arm") end) end
if P[871] then task.spawn(function() setLocked(endpoint, P[871], true) end) end
if P[124] then task.spawn(function() setName(endpoint, P[124], "Handle") end) end
if P[1201] then task.spawn(function() setLocked(endpoint, P[1201], true) end) end
if P[1201] then task.spawn(function() setName(endpoint, P[1201], "MeshPart") end) end
if P[182] then task.spawn(function() setLocked(endpoint, P[182], true) end) end
if P[182] then task.spawn(function() setName(endpoint, P[182], "Bottom") end) end
if P[320] then task.spawn(function() setName(endpoint, P[320], "Right Leg") end) end
if P[855] then task.spawn(function() setLocked(endpoint, P[855], true) end) end
if P[855] then task.spawn(function() setName(endpoint, P[855], "Part4") end) end
if P[1188] then task.spawn(function() setLocked(endpoint, P[1188], true) end) end
if P[762] then task.spawn(function() setLocked(endpoint, P[762], true) end) end
if P[762] then task.spawn(function() setName(endpoint, P[762], "Part23") end) end
if P[597] then task.spawn(function() setLocked(endpoint, P[597], true) end) end
if P[597] then task.spawn(function() setName(endpoint, P[597], "Part5") end) end
if P[184] then task.spawn(function() setName(endpoint, P[184], "Seat") end) end
if P[804] then task.spawn(function() setLocked(endpoint, P[804], true) end) end
if P[804] then task.spawn(function() setName(endpoint, P[804], "Part6") end) end
if P[402] then task.spawn(function() setName(endpoint, P[402], "Head") end) end
if P[569] then task.spawn(function() setLocked(endpoint, P[569], true) end) end
if P[569] then task.spawn(function() setName(endpoint, P[569], "Part2") end) end
if P[582] then task.spawn(function() setLocked(endpoint, P[582], true) end) end
if P[582] then task.spawn(function() setName(endpoint, P[582], "Part6") end) end
if P[512] then task.spawn(function() setLocked(endpoint, P[512], true) end) end
if P[279] then task.spawn(function() setName(endpoint, P[279], "Handle") end) end
if P[742] then task.spawn(function() setLocked(endpoint, P[742], true) end) end
if P[742] then task.spawn(function() setName(endpoint, P[742], "Part20") end) end
if P[748] then task.spawn(function() setLocked(endpoint, P[748], true) end) end
if P[748] then task.spawn(function() setName(endpoint, P[748], "Part29") end) end
if P[478] then task.spawn(function() setLocked(endpoint, P[478], true) end) end
if P[478] then task.spawn(function() setName(endpoint, P[478], "MeshPart") end) end
if P[767] then task.spawn(function() setLocked(endpoint, P[767], true) end) end
if P[767] then task.spawn(function() setName(endpoint, P[767], "Part73") end) end
if P[607] then task.spawn(function() setLocked(endpoint, P[607], true) end) end
if P[607] then task.spawn(function() setName(endpoint, P[607], "Part7") end) end
if P[979] then task.spawn(function() setLocked(endpoint, P[979], true) end) end
if P[979] then task.spawn(function() setName(endpoint, P[979], "Part4") end) end
if P[788] then task.spawn(function() setLocked(endpoint, P[788], true) end) end
if P[788] then task.spawn(function() setName(endpoint, P[788], "Part2") end) end
if P[1123] then task.spawn(function() setLocked(endpoint, P[1123], true) end) end
if P[1123] then task.spawn(function() setName(endpoint, P[1123], "Part3") end) end
if P[575] then task.spawn(function() setLocked(endpoint, P[575], true) end) end
if P[575] then task.spawn(function() setName(endpoint, P[575], "Part2") end) end
if P[782] then task.spawn(function() setLocked(endpoint, P[782], true) end) end
if P[782] then task.spawn(function() setName(endpoint, P[782], "Part58") end) end
if P[1081] then task.spawn(function() setLocked(endpoint, P[1081], true) end) end
if P[1081] then task.spawn(function() setName(endpoint, P[1081], "Seat") end) end
if P[1062] then task.spawn(function() setLocked(endpoint, P[1062], true) end) end
if P[1062] then task.spawn(function() setName(endpoint, P[1062], "Seat") end) end
if P[1017] then task.spawn(function() setLocked(endpoint, P[1017], true) end) end
if P[868] then task.spawn(function() setLocked(endpoint, P[868], true) end) end
if P[868] then task.spawn(function() setName(endpoint, P[868], "Part4") end) end
if P[1145] then task.spawn(function() setLocked(endpoint, P[1145], true) end) end
if P[1145] then task.spawn(function() setName(endpoint, P[1145], "Part2") end) end
if P[1263] then task.spawn(function() setLocked(endpoint, P[1263], true) end) end
if P[1263] then task.spawn(function() setName(endpoint, P[1263], "MeshPart") end) end
if P[94] then task.spawn(function() setName(endpoint, P[94], "Right Arm") end) end
if P[1239] then task.spawn(function() setLocked(endpoint, P[1239], true) end) end
if P[1239] then task.spawn(function() setName(endpoint, P[1239], "Smooth Block Model") end) end
if P[676] then task.spawn(function() setLocked(endpoint, P[676], true) end) end
if P[676] then task.spawn(function() setName(endpoint, P[676], "Part4") end) end
if P[609] then task.spawn(function() setLocked(endpoint, P[609], true) end) end
if P[1001] then task.spawn(function() setLocked(endpoint, P[1001], true) end) end
if P[1001] then task.spawn(function() setName(endpoint, P[1001], "Seat") end) end
if P[1315] then task.spawn(function() setLocked(endpoint, P[1315], true) end) end
if P[1315] then task.spawn(function() setName(endpoint, P[1315], "Part7") end) end
if P[656] then task.spawn(function() setLocked(endpoint, P[656], true) end) end
if P[656] then task.spawn(function() setName(endpoint, P[656], "Part5") end) end
if P[495] then task.spawn(function() setLocked(endpoint, P[495], true) end) end
if P[495] then task.spawn(function() setName(endpoint, P[495], "Part2") end) end
if P[997] then task.spawn(function() setLocked(endpoint, P[997], true) end) end
if P[997] then task.spawn(function() setName(endpoint, P[997], "Part6") end) end
if P[733] then task.spawn(function() setLocked(endpoint, P[733], true) end) end
if P[733] then task.spawn(function() setName(endpoint, P[733], "Part10") end) end
if P[540] then task.spawn(function() setLocked(endpoint, P[540], true) end) end
if P[540] then task.spawn(function() setName(endpoint, P[540], "Part3") end) end
if P[781] then task.spawn(function() setLocked(endpoint, P[781], true) end) end
if P[781] then task.spawn(function() setName(endpoint, P[781], "Part48") end) end
if P[619] then task.spawn(function() setLocked(endpoint, P[619], true) end) end
if P[619] then task.spawn(function() setName(endpoint, P[619], "Solar") end) end
if P[264] then task.spawn(function() setName(endpoint, P[264], "Right Leg") end) end
if P[441] then task.spawn(function() setName(endpoint, P[441], "Left Leg") end) end
if P[922] then task.spawn(function() setLocked(endpoint, P[922], true) end) end
if P[922] then task.spawn(function() setName(endpoint, P[922], "Part8") end) end
if P[1223] then task.spawn(function() setLocked(endpoint, P[1223], true) end) end
if P[1223] then task.spawn(function() setName(endpoint, P[1223], "Part17") end) end
if P[769] then task.spawn(function() setLocked(endpoint, P[769], true) end) end
if P[769] then task.spawn(function() setName(endpoint, P[769], "Part22") end) end
if P[603] then task.spawn(function() setLocked(endpoint, P[603], true) end) end
if P[603] then task.spawn(function() setName(endpoint, P[603], "Part4") end) end
if P[1312] then task.spawn(function() setLocked(endpoint, P[1312], true) end) end
if P[1312] then task.spawn(function() setName(endpoint, P[1312], "Part3") end) end
if P[789] then task.spawn(function() setLocked(endpoint, P[789], true) end) end
if P[789] then task.spawn(function() setName(endpoint, P[789], "Part70") end) end
if P[745] then task.spawn(function() setLocked(endpoint, P[745], true) end) end
if P[745] then task.spawn(function() setName(endpoint, P[745], "Part12") end) end
if P[812] then task.spawn(function() setLocked(endpoint, P[812], true) end) end
if P[812] then task.spawn(function() setName(endpoint, P[812], "Part7") end) end
if P[898] then task.spawn(function() setLocked(endpoint, P[898], true) end) end
if P[898] then task.spawn(function() setName(endpoint, P[898], "Light") end) end
if P[732] then task.spawn(function() setLocked(endpoint, P[732], true) end) end
if P[732] then task.spawn(function() setName(endpoint, P[732], "Part16") end) end
if P[391] then task.spawn(function() setName(endpoint, P[391], "Handle") end) end
if P[681] then task.spawn(function() setLocked(endpoint, P[681], true) end) end
if P[681] then task.spawn(function() setName(endpoint, P[681], "Part24") end) end
if P[309] then task.spawn(function() setLocked(endpoint, P[309], true) end) end
if P[309] then task.spawn(function() setName(endpoint, P[309], "Handle") end) end
if P[88] then task.spawn(function() setName(endpoint, P[88], "Left Arm") end) end
if P[1297] then task.spawn(function() setLocked(endpoint, P[1297], true) end) end
if P[1297] then task.spawn(function() setName(endpoint, P[1297], "Part2") end) end
if P[213] then task.spawn(function() setName(endpoint, P[213], "Handle") end) end
if P[212] then task.spawn(function() setLocked(endpoint, P[212], true) end) end
if P[212] then task.spawn(function() setName(endpoint, P[212], "Handle") end) end
if P[775] then task.spawn(function() setLocked(endpoint, P[775], true) end) end
if P[775] then task.spawn(function() setName(endpoint, P[775], "Part25") end) end
if P[1295] then task.spawn(function() setLocked(endpoint, P[1295], true) end) end
if P[728] then task.spawn(function() setLocked(endpoint, P[728], true) end) end
if P[728] then task.spawn(function() setName(endpoint, P[728], "Part5") end) end
if P[1076] then task.spawn(function() setLocked(endpoint, P[1076], true) end) end
if P[1076] then task.spawn(function() setName(endpoint, P[1076], "Part3") end) end
if P[1109] then task.spawn(function() setLocked(endpoint, P[1109], true) end) end
if P[1109] then task.spawn(function() setName(endpoint, P[1109], "Seat") end) end
if P[1013] then task.spawn(function() setLocked(endpoint, P[1013], true) end) end
if P[1280] then task.spawn(function() setLocked(endpoint, P[1280], true) end) end
if P[42] then task.spawn(function() setName(endpoint, P[42], "Handle") end) end
if P[313] then task.spawn(function() setName(endpoint, P[313], "Head") end) end
if P[1059] then task.spawn(function() setLocked(endpoint, P[1059], true) end) end
if P[227] then task.spawn(function() setName(endpoint, P[227], "Torso") end) end
if P[833] then task.spawn(function() setLocked(endpoint, P[833], true) end) end
if P[833] then task.spawn(function() setName(endpoint, P[833], "Part3") end) end
if P[730] then task.spawn(function() setLocked(endpoint, P[730], true) end) end
if P[730] then task.spawn(function() setName(endpoint, P[730], "Part4") end) end
if P[300] then task.spawn(function() setName(endpoint, P[300], "Part2") end) end
if P[190] then task.spawn(function() setLocked(endpoint, P[190], true) end) end
if P[190] then task.spawn(function() setName(endpoint, P[190], "Part3") end) end
if P[1040] then task.spawn(function() setLocked(endpoint, P[1040], true) end) end
if P[1040] then task.spawn(function() setName(endpoint, P[1040], "MeshPart") end) end
if P[338] then task.spawn(function() setLocked(endpoint, P[338], true) end) end
if P[338] then task.spawn(function() setName(endpoint, P[338], "Handle") end) end
if P[977] then task.spawn(function() setLocked(endpoint, P[977], true) end) end
if P[977] then task.spawn(function() setName(endpoint, P[977], "Part8") end) end
if P[1331] then task.spawn(function() setName(endpoint, P[1331], "SpawnLocation") end) end
if P[1329] then task.spawn(function() setName(endpoint, P[1329], "bacon") end) end
if P[865] then task.spawn(function() setLocked(endpoint, P[865], true) end) end
if P[865] then task.spawn(function() setName(endpoint, P[865], "Part3") end) end
if P[248] then task.spawn(function() setName(endpoint, P[248], "Head") end) end
if P[1326] then task.spawn(function() setName(endpoint, P[1326], "Part2") end) end
if P[1077] then task.spawn(function() setLocked(endpoint, P[1077], true) end) end
if P[1077] then task.spawn(function() setName(endpoint, P[1077], "Part2") end) end
if P[1324] then task.spawn(function() setLocked(endpoint, P[1324], true) end) end
if P[1324] then task.spawn(function() setName(endpoint, P[1324], "Smooth Block Model") end) end
if P[1317] then task.spawn(function() setLocked(endpoint, P[1317], true) end) end
if P[1317] then task.spawn(function() setName(endpoint, P[1317], "Part19") end) end
if P[1203] then task.spawn(function() setLocked(endpoint, P[1203], true) end) end
if P[245] then task.spawn(function() setName(endpoint, P[245], "Right Arm") end) end
if P[852] then task.spawn(function() setLocked(endpoint, P[852], true) end) end
if P[852] then task.spawn(function() setName(endpoint, P[852], "Part3") end) end
if P[1158] then task.spawn(function() setLocked(endpoint, P[1158], true) end) end
if P[47] then task.spawn(function() setName(endpoint, P[47], "Right Arm") end) end
if P[869] then task.spawn(function() setLocked(endpoint, P[869], true) end) end
if P[869] then task.spawn(function() setName(endpoint, P[869], "Part2") end) end
if P[740] then task.spawn(function() setLocked(endpoint, P[740], true) end) end
if P[740] then task.spawn(function() setName(endpoint, P[740], "Part8") end) end
if P[968] then task.spawn(function() setLocked(endpoint, P[968], true) end) end
if P[678] then task.spawn(function() setLocked(endpoint, P[678], true) end) end
if P[678] then task.spawn(function() setName(endpoint, P[678], "Part7") end) end
if P[34] then task.spawn(function() setName(endpoint, P[34], "Left Arm") end) end
if P[1310] then task.spawn(function() setLocked(endpoint, P[1310], true) end) end
if P[1308] then task.spawn(function() setLocked(endpoint, P[1308], true) end) end
if P[1308] then task.spawn(function() setName(endpoint, P[1308], "MeshPart") end) end
if P[1298] then task.spawn(function() setLocked(endpoint, P[1298], true) end) end
if P[1298] then task.spawn(function() setName(endpoint, P[1298], "Seat") end) end
if P[1206] then task.spawn(function() setLocked(endpoint, P[1206], true) end) end
if P[1206] then task.spawn(function() setName(endpoint, P[1206], "Part2") end) end
if P[722] then task.spawn(function() setLocked(endpoint, P[722], true) end) end
if P[722] then task.spawn(function() setName(endpoint, P[722], "Part34") end) end
if P[496] then task.spawn(function() setLocked(endpoint, P[496], true) end) end
if P[496] then task.spawn(function() setName(endpoint, P[496], "Seat") end) end
if P[738] then task.spawn(function() setLocked(endpoint, P[738], true) end) end
if P[214] then task.spawn(function() setName(endpoint, P[214], "Handle") end) end
if P[943] then task.spawn(function() setLocked(endpoint, P[943], true) end) end
if P[943] then task.spawn(function() setName(endpoint, P[943], "Part4") end) end
if P[1293] then task.spawn(function() setLocked(endpoint, P[1293], true) end) end
if P[1293] then task.spawn(function() setName(endpoint, P[1293], "MeshPart") end) end
if P[992] then task.spawn(function() setLocked(endpoint, P[992], true) end) end
if P[1282] then task.spawn(function() setLocked(endpoint, P[1282], true) end) end
if P[1282] then task.spawn(function() setName(endpoint, P[1282], "Part2") end) end
if P[1283] then task.spawn(function() setLocked(endpoint, P[1283], true) end) end
if P[1283] then task.spawn(function() setName(endpoint, P[1283], "Seat") end) end
if P[724] then task.spawn(function() setLocked(endpoint, P[724], true) end) end
if P[724] then task.spawn(function() setName(endpoint, P[724], "Wedge") end) end
if P[687] then task.spawn(function() setLocked(endpoint, P[687], true) end) end
if P[687] then task.spawn(function() setName(endpoint, P[687], "Part9") end) end
if P[674] then task.spawn(function() setLocked(endpoint, P[674], true) end) end
if P[674] then task.spawn(function() setName(endpoint, P[674], "Part5") end) end
if P[1265] then task.spawn(function() setLocked(endpoint, P[1265], true) end) end
if P[971] then task.spawn(function() setLocked(endpoint, P[971], true) end) end
if P[971] then task.spawn(function() setName(endpoint, P[971], "Part3") end) end
if P[1252] then task.spawn(function() setLocked(endpoint, P[1252], true) end) end
if P[1252] then task.spawn(function() setName(endpoint, P[1252], "Part2") end) end
if P[1248] then task.spawn(function() setLocked(endpoint, P[1248], true) end) end
if P[1248] then task.spawn(function() setName(endpoint, P[1248], "MeshPart") end) end
if P[1242] then task.spawn(function() setLocked(endpoint, P[1242], true) end) end
if P[1242] then task.spawn(function() setName(endpoint, P[1242], "Seat") end) end
if P[1237] then task.spawn(function() setLocked(endpoint, P[1237], true) end) end
if P[1237] then task.spawn(function() setName(endpoint, P[1237], "MeshPart") end) end
if P[1236] then task.spawn(function() setLocked(endpoint, P[1236], true) end) end
if P[1236] then task.spawn(function() setName(endpoint, P[1236], "DonutGiver") end) end
if P[1234] then task.spawn(function() setLocked(endpoint, P[1234], true) end) end
if P[1234] then task.spawn(function() setName(endpoint, P[1234], "Smooth Block Model") end) end
if P[854] then task.spawn(function() setLocked(endpoint, P[854], true) end) end
if P[854] then task.spawn(function() setName(endpoint, P[854], "Part6") end) end
if P[1232] then task.spawn(function() setLocked(endpoint, P[1232], true) end) end
if P[1232] then task.spawn(function() setName(endpoint, P[1232], "Part14") end) end
if P[660] then task.spawn(function() setLocked(endpoint, P[660], true) end) end
if P[660] then task.spawn(function() setName(endpoint, P[660], "Part27") end) end
if P[1099] then task.spawn(function() setLocked(endpoint, P[1099], true) end) end
if P[1099] then task.spawn(function() setName(endpoint, P[1099], "Part4") end) end
if P[679] then task.spawn(function() setLocked(endpoint, P[679], true) end) end
if P[1228] then task.spawn(function() setLocked(endpoint, P[1228], true) end) end
if P[1228] then task.spawn(function() setName(endpoint, P[1228], "Smooth Block Model") end) end
if P[1227] then task.spawn(function() setName(endpoint, P[1227], "Part13") end) end
if P[764] then task.spawn(function() setLocked(endpoint, P[764], true) end) end
if P[764] then task.spawn(function() setName(endpoint, P[764], "Part71") end) end
if P[456] then task.spawn(function() setName(endpoint, P[456], "bacon") end) end
if P[1220] then task.spawn(function() setLocked(endpoint, P[1220], true) end) end
if P[1220] then task.spawn(function() setName(endpoint, P[1220], "Solar") end) end
if P[467] then task.spawn(function() setLocked(endpoint, P[467], true) end) end
if P[467] then task.spawn(function() setName(endpoint, P[467], "Smooth Block Model") end) end
if P[932] then task.spawn(function() setLocked(endpoint, P[932], true) end) end
if P[932] then task.spawn(function() setName(endpoint, P[932], "Part4") end) end
if P[1219] then task.spawn(function() setLocked(endpoint, P[1219], true) end) end
if P[1219] then task.spawn(function() setName(endpoint, P[1219], "Sound_MusicCafe") end) end
if P[1217] then task.spawn(function() setLocked(endpoint, P[1217], true) end) end
if P[1217] then task.spawn(function() setName(endpoint, P[1217], "MeshPart") end) end
if P[194] then task.spawn(function() setLocked(endpoint, P[194], true) end) end
if P[194] then task.spawn(function() setName(endpoint, P[194], "Part2") end) end
if P[744] then task.spawn(function() setLocked(endpoint, P[744], true) end) end
if P[744] then task.spawn(function() setName(endpoint, P[744], "Part7") end) end
if P[472] then task.spawn(function() setLocked(endpoint, P[472], true) end) end
if P[472] then task.spawn(function() setName(endpoint, P[472], "Seat") end) end
if P[877] then task.spawn(function() setLocked(endpoint, P[877], true) end) end
if P[877] then task.spawn(function() setName(endpoint, P[877], "Part60") end) end
if P[1208] then task.spawn(function() setLocked(endpoint, P[1208], true) end) end
if P[1208] then task.spawn(function() setName(endpoint, P[1208], "Part16") end) end
if P[50] then task.spawn(function() setName(endpoint, P[50], "Head") end) end
if P[773] then task.spawn(function() setLocked(endpoint, P[773], true) end) end
if P[773] then task.spawn(function() setName(endpoint, P[773], "Part33") end) end
if P[1080] then task.spawn(function() setLocked(endpoint, P[1080], true) end) end
if P[1080] then task.spawn(function() setName(endpoint, P[1080], "Part2") end) end
if P[830] then task.spawn(function() setLocked(endpoint, P[830], true) end) end
if P[830] then task.spawn(function() setName(endpoint, P[830], "Part17") end) end
if P[1108] then task.spawn(function() setLocked(endpoint, P[1108], true) end) end
if P[1108] then task.spawn(function() setName(endpoint, P[1108], "Part2") end) end
if P[1207] then task.spawn(function() setLocked(endpoint, P[1207], true) end) end
if P[981] then task.spawn(function() setLocked(endpoint, P[981], true) end) end
if P[981] then task.spawn(function() setName(endpoint, P[981], "Part2") end) end
if P[588] then task.spawn(function() setLocked(endpoint, P[588], true) end) end
if P[588] then task.spawn(function() setName(endpoint, P[588], "Part2") end) end
if P[1205] then task.spawn(function() setLocked(endpoint, P[1205], true) end) end
if P[1205] then task.spawn(function() setName(endpoint, P[1205], "Part3") end) end
if P[1314] then task.spawn(function() setLocked(endpoint, P[1314], true) end) end
if P[841] then task.spawn(function() setLocked(endpoint, P[841], true) end) end
if P[841] then task.spawn(function() setName(endpoint, P[841], "Part32") end) end
if P[715] then task.spawn(function() setLocked(endpoint, P[715], true) end) end
if P[715] then task.spawn(function() setName(endpoint, P[715], "Part45") end) end
if P[802] then task.spawn(function() setLocked(endpoint, P[802], true) end) end
if P[802] then task.spawn(function() setName(endpoint, P[802], "Neon") end) end
if P[856] then task.spawn(function() setLocked(endpoint, P[856], true) end) end
if P[856] then task.spawn(function() setName(endpoint, P[856], "Part2") end) end
if P[1057] then task.spawn(function() setLocked(endpoint, P[1057], true) end) end
if P[1057] then task.spawn(function() setName(endpoint, P[1057], "MeshPart") end) end
if P[433] then task.spawn(function() setName(endpoint, P[433], "Left Arm") end) end
if P[1128] then task.spawn(function() setLocked(endpoint, P[1128], true) end) end
if P[1128] then task.spawn(function() setName(endpoint, P[1128], "Seat") end) end
if P[853] then task.spawn(function() setLocked(endpoint, P[853], true) end) end
if P[853] then task.spawn(function() setName(endpoint, P[853], "Part5") end) end
if P[1146] then task.spawn(function() setLocked(endpoint, P[1146], true) end) end
if P[1146] then task.spawn(function() setName(endpoint, P[1146], "Seat") end) end
if P[202] then task.spawn(function() setLocked(endpoint, P[202], true) end) end
if P[122] then task.spawn(function() setName(endpoint, P[122], "Right Leg") end) end
if P[1190] then task.spawn(function() setLocked(endpoint, P[1190], true) end) end
if P[1190] then task.spawn(function() setName(endpoint, P[1190], "Part2") end) end
if P[546] then task.spawn(function() setLocked(endpoint, P[546], true) end) end
if P[546] then task.spawn(function() setName(endpoint, P[546], "Part8") end) end
if P[1186] then task.spawn(function() setLocked(endpoint, P[1186], true) end) end
if P[1186] then task.spawn(function() setName(endpoint, P[1186], "MeshPart") end) end
if P[698] then task.spawn(function() setLocked(endpoint, P[698], true) end) end
if P[698] then task.spawn(function() setName(endpoint, P[698], "Part12") end) end
if P[640] then task.spawn(function() setLocked(endpoint, P[640], true) end) end
if P[640] then task.spawn(function() setName(endpoint, P[640], "Part6") end) end
if P[848] then task.spawn(function() setLocked(endpoint, P[848], true) end) end
if P[848] then task.spawn(function() setName(endpoint, P[848], "Part4") end) end
if P[1176] then task.spawn(function() setLocked(endpoint, P[1176], true) end) end
if P[1176] then task.spawn(function() setName(endpoint, P[1176], "Seat") end) end
if P[556] then task.spawn(function() setLocked(endpoint, P[556], true) end) end
if P[556] then task.spawn(function() setName(endpoint, P[556], "Part4") end) end
if P[1175] then task.spawn(function() setLocked(endpoint, P[1175], true) end) end
if P[1175] then task.spawn(function() setName(endpoint, P[1175], "Part2") end) end
if P[791] then task.spawn(function() setLocked(endpoint, P[791], true) end) end
if P[791] then task.spawn(function() setName(endpoint, P[791], "Part46") end) end
if P[882] then task.spawn(function() setLocked(endpoint, P[882], true) end) end
if P[882] then task.spawn(function() setName(endpoint, P[882], "Part75") end) end
if P[836] then task.spawn(function() setLocked(endpoint, P[836], true) end) end
if P[836] then task.spawn(function() setName(endpoint, P[836], "Part45") end) end
if P[1173] then task.spawn(function() setLocked(endpoint, P[1173], true) end) end
if P[752] then task.spawn(function() setLocked(endpoint, P[752], true) end) end
if P[752] then task.spawn(function() setName(endpoint, P[752], "Part37") end) end
if P[811] then task.spawn(function() setLocked(endpoint, P[811], true) end) end
if P[811] then task.spawn(function() setName(endpoint, P[811], "Part2") end) end
if P[807] then task.spawn(function() setLocked(endpoint, P[807], true) end) end
if P[807] then task.spawn(function() setName(endpoint, P[807], "Part3") end) end
if P[489] then task.spawn(function() setLocked(endpoint, P[489], true) end) end
if P[489] then task.spawn(function() setName(endpoint, P[489], "Smooth Block Model") end) end
if P[935] then task.spawn(function() setLocked(endpoint, P[935], true) end) end
if P[935] then task.spawn(function() setName(endpoint, P[935], "Part3") end) end
if P[1160] then task.spawn(function() setLocked(endpoint, P[1160], true) end) end
if P[1160] then task.spawn(function() setName(endpoint, P[1160], "Part2") end) end
if P[527] then task.spawn(function() setLocked(endpoint, P[527], true) end) end
if P[1156] then task.spawn(function() setLocked(endpoint, P[1156], true) end) end
if P[1156] then task.spawn(function() setName(endpoint, P[1156], "MeshPart") end) end
if P[734] then task.spawn(function() setLocked(endpoint, P[734], true) end) end
if P[734] then task.spawn(function() setName(endpoint, P[734], "Part17") end) end
if P[506] then task.spawn(function() setLocked(endpoint, P[506], true) end) end
if P[506] then task.spawn(function() setName(endpoint, P[506], "MeshPart") end) end
if P[995] then task.spawn(function() setLocked(endpoint, P[995], true) end) end
if P[995] then task.spawn(function() setName(endpoint, P[995], "Part2") end) end
if P[104] then task.spawn(function() setName(endpoint, P[104], "Torso") end) end
if P[823] then task.spawn(function() setLocked(endpoint, P[823], true) end) end
if P[823] then task.spawn(function() setName(endpoint, P[823], "Part4") end) end
if P[1138] then task.spawn(function() setLocked(endpoint, P[1138], true) end) end
if P[1138] then task.spawn(function() setName(endpoint, P[1138], "MeshPart") end) end
if P[1127] then task.spawn(function() setLocked(endpoint, P[1127], true) end) end
if P[1127] then task.spawn(function() setName(endpoint, P[1127], "Part2") end) end
if P[821] then task.spawn(function() setLocked(endpoint, P[821], true) end) end
if P[821] then task.spawn(function() setName(endpoint, P[821], "Part2") end) end
if P[1125] then task.spawn(function() setLocked(endpoint, P[1125], true) end) end
if P[1015] then task.spawn(function() setLocked(endpoint, P[1015], true) end) end
if P[1015] then task.spawn(function() setName(endpoint, P[1015], "Part3") end) end
if P[799] then task.spawn(function() setLocked(endpoint, P[799], true) end) end
if P[799] then task.spawn(function() setName(endpoint, P[799], "Part67") end) end
if P[747] then task.spawn(function() setLocked(endpoint, P[747], true) end) end
if P[747] then task.spawn(function() setName(endpoint, P[747], "Part2") end) end
if P[1046] then task.spawn(function() setLocked(endpoint, P[1046], true) end) end
if P[1046] then task.spawn(function() setName(endpoint, P[1046], "Part2") end) end
if P[185] then task.spawn(function() setLocked(endpoint, P[185], true) end) end
if P[185] then task.spawn(function() setName(endpoint, P[185], "Logo") end) end
if P[1121] then task.spawn(function() setLocked(endpoint, P[1121], true) end) end
if P[363] then task.spawn(function() setName(endpoint, P[363], "Head") end) end
if P[857] then task.spawn(function() setLocked(endpoint, P[857], true) end) end
if P[857] then task.spawn(function() setName(endpoint, P[857], "Part7") end) end
if P[43] then task.spawn(function() setLocked(endpoint, P[43], true) end) end
if P[43] then task.spawn(function() setName(endpoint, P[43], "Handle") end) end
if P[288] then task.spawn(function() setName(endpoint, P[288], "Handle") end) end
if P[902] then task.spawn(function() setLocked(endpoint, P[902], true) end) end
if P[902] then task.spawn(function() setName(endpoint, P[902], "Light") end) end
if P[949] then task.spawn(function() setLocked(endpoint, P[949], true) end) end
if P[1230] then task.spawn(function() setLocked(endpoint, P[1230], true) end) end
if P[1230] then task.spawn(function() setName(endpoint, P[1230], "Neon Sign") end) end
if P[739] then task.spawn(function() setLocked(endpoint, P[739], true) end) end
if P[739] then task.spawn(function() setName(endpoint, P[739], "Part15") end) end
if P[1097] then task.spawn(function() setLocked(endpoint, P[1097], true) end) end
if P[1097] then task.spawn(function() setName(endpoint, P[1097], "Smooth Block Model") end) end
if P[834] then task.spawn(function() setLocked(endpoint, P[834], true) end) end
if P[834] then task.spawn(function() setName(endpoint, P[834], "Part57") end) end
if P[736] then task.spawn(function() setLocked(endpoint, P[736], true) end) end
if P[736] then task.spawn(function() setName(endpoint, P[736], "Part13") end) end
if P[766] then task.spawn(function() setLocked(endpoint, P[766], true) end) end
if P[766] then task.spawn(function() setName(endpoint, P[766], "Part36") end) end
if P[803] then task.spawn(function() setLocked(endpoint, P[803], true) end) end
if P[803] then task.spawn(function() setName(endpoint, P[803], "Part49") end) end
if P[726] then task.spawn(function() setLocked(endpoint, P[726], true) end) end
if P[726] then task.spawn(function() setName(endpoint, P[726], "Part47") end) end
if P[1091] then task.spawn(function() setLocked(endpoint, P[1091], true) end) end
if P[1091] then task.spawn(function() setName(endpoint, P[1091], "MeshPart") end) end
if P[795] then task.spawn(function() setLocked(endpoint, P[795], true) end) end
if P[795] then task.spawn(function() setName(endpoint, P[795], "Part59") end) end
if P[548] then task.spawn(function() setLocked(endpoint, P[548], true) end) end
if P[548] then task.spawn(function() setName(endpoint, P[548], "Part4") end) end
if P[1078] then task.spawn(function() setLocked(endpoint, P[1078], true) end) end
if P[721] then task.spawn(function() setLocked(endpoint, P[721], true) end) end
if P[721] then task.spawn(function() setName(endpoint, P[721], "Part44") end) end
if P[119] then task.spawn(function() setName(endpoint, P[119], "Left Arm") end) end
if P[611] then task.spawn(function() setLocked(endpoint, P[611], true) end) end
if P[611] then task.spawn(function() setName(endpoint, P[611], "Dumpster") end) end
if P[530] then task.spawn(function() setLocked(endpoint, P[530], true) end) end
if P[530] then task.spawn(function() setName(endpoint, P[530], "Neon Sign") end) end
if P[1278] then task.spawn(function() setLocked(endpoint, P[1278], true) end) end
if P[1278] then task.spawn(function() setName(endpoint, P[1278], "MeshPart") end) end
if P[756] then task.spawn(function() setLocked(endpoint, P[756], true) end) end
if P[756] then task.spawn(function() setName(endpoint, P[756], "Part69") end) end
if P[947] then task.spawn(function() setLocked(endpoint, P[947], true) end) end
if P[947] then task.spawn(function() setName(endpoint, P[947], "Part7") end) end
if P[508] then task.spawn(function() setLocked(endpoint, P[508], true) end) end
if P[85] then task.spawn(function() setName(endpoint, P[85], "Left Arm") end) end
if P[163] then task.spawn(function() setLocked(endpoint, P[163], true) end) end
if P[163] then task.spawn(function() setName(endpoint, P[163], "RL") end) end
if P[746] then task.spawn(function() setLocked(endpoint, P[746], true) end) end
if P[746] then task.spawn(function() setName(endpoint, P[746], "Part14") end) end
if P[1072] then task.spawn(function() setLocked(endpoint, P[1072], true) end) end
if P[1072] then task.spawn(function() setName(endpoint, P[1072], "MeshPart") end) end
if P[622] then task.spawn(function() setLocked(endpoint, P[622], true) end) end
if P[622] then task.spawn(function() setName(endpoint, P[622], "Part8") end) end
if P[175] then task.spawn(function() setLocked(endpoint, P[175], true) end) end
if P[175] then task.spawn(function() setName(endpoint, P[175], "FL") end) end
if P[916] then task.spawn(function() setLocked(endpoint, P[916], true) end) end
if P[916] then task.spawn(function() setName(endpoint, P[916], "Part3") end) end
if P[1061] then task.spawn(function() setLocked(endpoint, P[1061], true) end) end
if P[1061] then task.spawn(function() setName(endpoint, P[1061], "Part2") end) end
if P[1034] then task.spawn(function() setLocked(endpoint, P[1034], true) end) end
if P[1034] then task.spawn(function() setName(endpoint, P[1034], "Seat") end) end
if P[810] then task.spawn(function() setLocked(endpoint, P[810], true) end) end
if P[810] then task.spawn(function() setName(endpoint, P[810], "Part4") end) end
if P[565] then task.spawn(function() setLocked(endpoint, P[565], true) end) end
if P[565] then task.spawn(function() setName(endpoint, P[565], "Part8") end) end
if P[920] then task.spawn(function() setLocked(endpoint, P[920], true) end) end
if P[920] then task.spawn(function() setName(endpoint, P[920], "Part6") end) end
if P[870] then task.spawn(function() setLocked(endpoint, P[870], true) end) end
if P[870] then task.spawn(function() setName(endpoint, P[870], "Part7") end) end
if P[1124] then task.spawn(function() setLocked(endpoint, P[1124], true) end) end
if P[1124] then task.spawn(function() setName(endpoint, P[1124], "Part2") end) end
if P[580] then task.spawn(function() setLocked(endpoint, P[580], true) end) end
if P[580] then task.spawn(function() setName(endpoint, P[580], "Part5") end) end
if P[261] then task.spawn(function() setName(endpoint, P[261], "Left Arm") end) end
if P[779] then task.spawn(function() setLocked(endpoint, P[779], true) end) end
if P[779] then task.spawn(function() setName(endpoint, P[779], "Part19") end) end
if P[876] then task.spawn(function() setLocked(endpoint, P[876], true) end) end
if P[876] then task.spawn(function() setName(endpoint, P[876], "Part7") end) end
if P[1032] then task.spawn(function() setLocked(endpoint, P[1032], true) end) end
if P[858] then task.spawn(function() setLocked(endpoint, P[858], true) end) end
if P[617] then task.spawn(function() setLocked(endpoint, P[617], true) end) end
if P[617] then task.spawn(function() setName(endpoint, P[617], "Part15") end) end
if P[1020] then task.spawn(function() setLocked(endpoint, P[1020], true) end) end
if P[1020] then task.spawn(function() setName(endpoint, P[1020], "Seat") end) end
if P[266] then task.spawn(function() setName(endpoint, P[266], "Left Leg") end) end
if P[1019] then task.spawn(function() setLocked(endpoint, P[1019], true) end) end
if P[1019] then task.spawn(function() setName(endpoint, P[1019], "Part2") end) end
if P[1016] then task.spawn(function() setLocked(endpoint, P[1016], true) end) end
if P[1016] then task.spawn(function() setName(endpoint, P[1016], "Part2") end) end
if P[158] then task.spawn(function() setName(endpoint, P[158], "Left Leg") end) end
if P[845] then task.spawn(function() setLocked(endpoint, P[845], true) end) end
if P[845] then task.spawn(function() setName(endpoint, P[845], "Part2") end) end
if P[731] then task.spawn(function() setLocked(endpoint, P[731], true) end) end
if P[731] then task.spawn(function() setName(endpoint, P[731], "Part19") end) end
if P[1011] then task.spawn(function() setLocked(endpoint, P[1011], true) end) end
if P[1011] then task.spawn(function() setName(endpoint, P[1011], "MeshPart") end) end
if P[1000] then task.spawn(function() setLocked(endpoint, P[1000], true) end) end
if P[1000] then task.spawn(function() setName(endpoint, P[1000], "Part2") end) end
if P[996] then task.spawn(function() setLocked(endpoint, P[996], true) end) end
if P[996] then task.spawn(function() setName(endpoint, P[996], "Part7") end) end
if P[884] then task.spawn(function() setLocked(endpoint, P[884], true) end) end
if P[884] then task.spawn(function() setName(endpoint, P[884], "Part42") end) end
if P[1141] then task.spawn(function() setLocked(endpoint, P[1141], true) end) end
if P[1141] then task.spawn(function() setName(endpoint, P[1141], "Part2") end) end
if P[958] then task.spawn(function() setLocked(endpoint, P[958], true) end) end
if P[958] then task.spawn(function() setName(endpoint, P[958], "Part6") end) end
if P[911] then task.spawn(function() setLocked(endpoint, P[911], true) end) end
if P[911] then task.spawn(function() setName(endpoint, P[911], "Part5") end) end
if P[511] then task.spawn(function() setLocked(endpoint, P[511], true) end) end
if P[511] then task.spawn(function() setName(endpoint, P[511], "Part2") end) end
if P[994] then task.spawn(function() setLocked(endpoint, P[994], true) end) end
if P[994] then task.spawn(function() setName(endpoint, P[994], "Part4") end) end
if P[993] then task.spawn(function() setLocked(endpoint, P[993], true) end) end
if P[993] then task.spawn(function() setName(endpoint, P[993], "Part8") end) end
if P[1074] then task.spawn(function() setLocked(endpoint, P[1074], true) end) end
if P[991] then task.spawn(function() setLocked(endpoint, P[991], true) end) end
if P[991] then task.spawn(function() setName(endpoint, P[991], "Part5") end) end
if P[844] then task.spawn(function() setLocked(endpoint, P[844], true) end) end
if P[844] then task.spawn(function() setName(endpoint, P[844], "Part3") end) end
if P[990] then task.spawn(function() setLocked(endpoint, P[990], true) end) end
if P[990] then task.spawn(function() setName(endpoint, P[990], "Part3") end) end
if P[987] then task.spawn(function() setLocked(endpoint, P[987], true) end) end
if P[987] then task.spawn(function() setName(endpoint, P[987], "Part12") end) end
if P[985] then task.spawn(function() setLocked(endpoint, P[985], true) end) end
if P[964] then task.spawn(function() setLocked(endpoint, P[964], true) end) end
if P[964] then task.spawn(function() setName(endpoint, P[964], "Part2") end) end
if P[975] then task.spawn(function() setLocked(endpoint, P[975], true) end) end
if P[975] then task.spawn(function() setName(endpoint, P[975], "Part6") end) end
if P[192] then task.spawn(function() setLocked(endpoint, P[192], true) end) end
if P[973] then task.spawn(function() setLocked(endpoint, P[973], true) end) end
if P[973] then task.spawn(function() setName(endpoint, P[973], "Part5") end) end
if P[1253] then task.spawn(function() setLocked(endpoint, P[1253], true) end) end
if P[1253] then task.spawn(function() setName(endpoint, P[1253], "Seat") end) end
if P[310] then task.spawn(function() setName(endpoint, P[310], "Right Arm") end) end
if P[809] then task.spawn(function() setLocked(endpoint, P[809], true) end) end
if P[809] then task.spawn(function() setName(endpoint, P[809], "Part6") end) end
if P[780] then task.spawn(function() setLocked(endpoint, P[780], true) end) end
if P[780] then task.spawn(function() setName(endpoint, P[780], "Part31") end) end
if P[595] then task.spawn(function() setLocked(endpoint, P[595], true) end) end
if P[595] then task.spawn(function() setName(endpoint, P[595], "Part3") end) end
if P[200] then task.spawn(function() setLocked(endpoint, P[200], true) end) end
if P[200] then task.spawn(function() setName(endpoint, P[200], "Part2") end) end
if P[966] then task.spawn(function() setLocked(endpoint, P[966], true) end) end
if P[966] then task.spawn(function() setName(endpoint, P[966], "Part7") end) end
if P[429] then task.spawn(function() setName(endpoint, P[429], "HumanoidRootPart") end) end
if P[776] then task.spawn(function() setLocked(endpoint, P[776], true) end) end
if P[776] then task.spawn(function() setName(endpoint, P[776], "Part18") end) end
if P[515] then task.spawn(function() setLocked(endpoint, P[515], true) end) end
if P[515] then task.spawn(function() setName(endpoint, P[515], "Seat") end) end
if P[461] then task.spawn(function() setLocked(endpoint, P[461], true) end) end
if P[461] then task.spawn(function() setName(endpoint, P[461], "Dumpster") end) end
if P[983] then task.spawn(function() setLocked(endpoint, P[983], true) end) end
if P[983] then task.spawn(function() setName(endpoint, P[983], "Part7") end) end
if P[669] then task.spawn(function() setLocked(endpoint, P[669], true) end) end
if P[669] then task.spawn(function() setName(endpoint, P[669], "Part54") end) end
if P[786] then task.spawn(function() setLocked(endpoint, P[786], true) end) end
if P[786] then task.spawn(function() setName(endpoint, P[786], "Part28") end) end
if P[960] then task.spawn(function() setLocked(endpoint, P[960], true) end) end
if P[960] then task.spawn(function() setName(endpoint, P[960], "Part8") end) end
if P[956] then task.spawn(function() setLocked(endpoint, P[956], true) end) end
if P[956] then task.spawn(function() setName(endpoint, P[956], "Part5") end) end
if P[72] then task.spawn(function() setName(endpoint, P[72], "Right Leg") end) end
if P[926] then task.spawn(function() setLocked(endpoint, P[926], true) end) end
if P[926] then task.spawn(function() setName(endpoint, P[926], "Part2") end) end
if P[514] then task.spawn(function() setLocked(endpoint, P[514], true) end) end
if P[514] then task.spawn(function() setName(endpoint, P[514], "Part2") end) end
if P[790] then task.spawn(function() setLocked(endpoint, P[790], true) end) end
if P[790] then task.spawn(function() setName(endpoint, P[790], "Part66") end) end
if P[703] then task.spawn(function() setLocked(endpoint, P[703], true) end) end
if P[703] then task.spawn(function() setName(endpoint, P[703], "Part56") end) end
if P[954] then task.spawn(function() setLocked(endpoint, P[954], true) end) end
if P[954] then task.spawn(function() setName(endpoint, P[954], "Part3") end) end
if P[714] then task.spawn(function() setLocked(endpoint, P[714], true) end) end
if P[714] then task.spawn(function() setName(endpoint, P[714], "Part41") end) end
if P[605] then task.spawn(function() setLocked(endpoint, P[605], true) end) end
if P[605] then task.spawn(function() setName(endpoint, P[605], "Part2") end) end
if P[436] then task.spawn(function() setName(endpoint, P[436], "Right Leg") end) end
if P[945] then task.spawn(function() setLocked(endpoint, P[945], true) end) end
if P[945] then task.spawn(function() setName(endpoint, P[945], "Part2") end) end
if P[941] then task.spawn(function() setLocked(endpoint, P[941], true) end) end
if P[941] then task.spawn(function() setName(endpoint, P[941], "Part8") end) end
if P[525] then task.spawn(function() setLocked(endpoint, P[525], true) end) end
if P[525] then task.spawn(function() setName(endpoint, P[525], "MeshPart") end) end
if P[939] then task.spawn(function() setLocked(endpoint, P[939], true) end) end
if P[939] then task.spawn(function() setName(endpoint, P[939], "Part6") end) end
if P[414] then task.spawn(function() setName(endpoint, P[414], "Torso") end) end
if P[77] then task.spawn(function() setName(endpoint, P[77], "Handle") end) end
if P[664] then task.spawn(function() setLocked(endpoint, P[664], true) end) end
if P[664] then task.spawn(function() setName(endpoint, P[664], "Part10") end) end
if P[1161] then task.spawn(function() setLocked(endpoint, P[1161], true) end) end
if P[1161] then task.spawn(function() setName(endpoint, P[1161], "Seat") end) end
if P[930] then task.spawn(function() setLocked(endpoint, P[930], true) end) end
if P[670] then task.spawn(function() setLocked(endpoint, P[670], true) end) end
if P[670] then task.spawn(function() setName(endpoint, P[670], "Light") end) end
if P[928] then task.spawn(function() setLocked(endpoint, P[928], true) end) end
if P[928] then task.spawn(function() setName(endpoint, P[928], "Part7") end) end
if P[573] then task.spawn(function() setLocked(endpoint, P[573], true) end) end
if P[924] then task.spawn(function() setLocked(endpoint, P[924], true) end) end
if P[924] then task.spawn(function() setName(endpoint, P[924], "Part4") end) end
if P[1047] then task.spawn(function() setLocked(endpoint, P[1047], true) end) end
if P[1047] then task.spawn(function() setName(endpoint, P[1047], "Seat") end) end
if P[307] then task.spawn(function() setName(endpoint, P[307], "Part3") end) end
if P[680] then task.spawn(function() setLocked(endpoint, P[680], true) end) end
if P[680] then task.spawn(function() setName(endpoint, P[680], "Part38") end) end
if P[913] then task.spawn(function() setLocked(endpoint, P[913], true) end) end
if P[909] then task.spawn(function() setLocked(endpoint, P[909], true) end) end
if P[909] then task.spawn(function() setName(endpoint, P[909], "Part3") end) end
if P[906] then task.spawn(function() setLocked(endpoint, P[906], true) end) end
if P[906] then task.spawn(function() setName(endpoint, P[906], "Light") end) end
if P[904] then task.spawn(function() setLocked(endpoint, P[904], true) end) end
if P[904] then task.spawn(function() setName(endpoint, P[904], "Light") end) end
if P[900] then task.spawn(function() setLocked(endpoint, P[900], true) end) end
if P[900] then task.spawn(function() setName(endpoint, P[900], "Light") end) end
if P[453] then task.spawn(function() setName(endpoint, P[453], "Part_12") end) end
if P[894] then task.spawn(function() setLocked(endpoint, P[894], true) end) end
if P[894] then task.spawn(function() setName(endpoint, P[894], "Light") end) end
if P[890] then task.spawn(function() setLocked(endpoint, P[890], true) end) end
if P[890] then task.spawn(function() setName(endpoint, P[890], "Light") end) end
if P[634] then task.spawn(function() setLocked(endpoint, P[634], true) end) end
if P[634] then task.spawn(function() setName(endpoint, P[634], "Seat") end) end
if P[886] then task.spawn(function() setLocked(endpoint, P[886], true) end) end
if P[886] then task.spawn(function() setName(endpoint, P[886], "Light") end) end
if P[463] then task.spawn(function() setLocked(endpoint, P[463], true) end) end
if P[1042] then task.spawn(function() setLocked(endpoint, P[1042], true) end) end
if P[1042] then task.spawn(function() setName(endpoint, P[1042], "Smooth Block Model") end) end
if P[196] then task.spawn(function() setLocked(endpoint, P[196], true) end) end
if P[196] then task.spawn(function() setName(endpoint, P[196], "Part3") end) end
if P[847] then task.spawn(function() setLocked(endpoint, P[847], true) end) end
if P[567] then task.spawn(function() setLocked(endpoint, P[567], true) end) end
if P[567] then task.spawn(function() setName(endpoint, P[567], "Part4") end) end
if P[554] then task.spawn(function() setLocked(endpoint, P[554], true) end) end
if P[487] then task.spawn(function() setLocked(endpoint, P[487], true) end) end
if P[487] then task.spawn(function() setName(endpoint, P[487], "MeshPart") end) end
if P[697] then task.spawn(function() setLocked(endpoint, P[697], true) end) end
if P[697] then task.spawn(function() setName(endpoint, P[697], "Part35") end) end
if P[187] then task.spawn(function() setLocked(endpoint, P[187], true) end) end
if P[187] then task.spawn(function() setName(endpoint, P[187], "Body") end) end
if P[937] then task.spawn(function() setLocked(endpoint, P[937], true) end) end
if P[937] then task.spawn(function() setName(endpoint, P[937], "Part5") end) end
if P[872] then task.spawn(function() setLocked(endpoint, P[872], true) end) end
if P[872] then task.spawn(function() setName(endpoint, P[872], "Part50") end) end
if P[867] then task.spawn(function() setLocked(endpoint, P[867], true) end) end
if P[867] then task.spawn(function() setName(endpoint, P[867], "Part6") end) end
if P[720] then task.spawn(function() setLocked(endpoint, P[720], true) end) end
if P[720] then task.spawn(function() setName(endpoint, P[720], "Part4") end) end
if P[592] then task.spawn(function() setLocked(endpoint, P[592], true) end) end
if P[813] then task.spawn(function() setLocked(endpoint, P[813], true) end) end
if P[355] then task.spawn(function() setName(endpoint, P[355], "Right Leg") end) end
if P[828] then task.spawn(function() setLocked(endpoint, P[828], true) end) end
if P[828] then task.spawn(function() setName(endpoint, P[828], "Part43") end) end
if P[370] then task.spawn(function() setName(endpoint, P[370], "Torso") end) end
if P[528] then task.spawn(function() setLocked(endpoint, P[528], true) end) end
if P[528] then task.spawn(function() setName(endpoint, P[528], "Part5") end) end
if P[481] then task.spawn(function() setLocked(endpoint, P[481], true) end) end
if P[481] then task.spawn(function() setName(endpoint, P[481], "Seat") end) end
if P[677] then task.spawn(function() setLocked(endpoint, P[677], true) end) end
if P[677] then task.spawn(function() setName(endpoint, P[677], "Part2") end) end
if P[1328] then task.spawn(function() setLocked(endpoint, P[1328], true) end) end
if P[1328] then task.spawn(function() setName(endpoint, P[1328], "Baseplate") end) end
if P[1313] then task.spawn(function() setLocked(endpoint, P[1313], true) end) end
if P[1313] then task.spawn(function() setName(endpoint, P[1313], "Part2") end) end
if P[859] then task.spawn(function() setLocked(endpoint, P[859], true) end) end
if P[859] then task.spawn(function() setName(endpoint, P[859], "Part51") end) end
if P[1030] then task.spawn(function() setLocked(endpoint, P[1030], true) end) end
if P[1030] then task.spawn(function() setName(endpoint, P[1030], "MeshPart") end) end
if P[1119] then task.spawn(function() setLocked(endpoint, P[1119], true) end) end
if P[1119] then task.spawn(function() setName(endpoint, P[1119], "MeshPart") end) end
if P[850] then task.spawn(function() setLocked(endpoint, P[850], true) end) end
if P[850] then task.spawn(function() setName(endpoint, P[850], "Part26") end) end
if P[1095] then task.spawn(function() setLocked(endpoint, P[1095], true) end) end
if P[1095] then task.spawn(function() setName(endpoint, P[1095], "Smooth Block Model") end) end
if P[57] then task.spawn(function() setName(endpoint, P[57], "Torso") end) end
if P[40] then task.spawn(function() setLocked(endpoint, P[40], true) end) end
if P[40] then task.spawn(function() setName(endpoint, P[40], "Handle") end) end
if P[1211] then task.spawn(function() setLocked(endpoint, P[1211], true) end) end
if P[1211] then task.spawn(function() setName(endpoint, P[1211], "Seat") end) end
if P[827] then task.spawn(function() setLocked(endpoint, P[827], true) end) end
if P[827] then task.spawn(function() setName(endpoint, P[827], "Touch") end) end
if P[563] then task.spawn(function() setLocked(endpoint, P[563], true) end) end
if P[563] then task.spawn(function() setName(endpoint, P[563], "Part6") end) end
if P[91] then task.spawn(function() setName(endpoint, P[91], "Left Leg") end) end
if P[896] then task.spawn(function() setLocked(endpoint, P[896], true) end) end
if P[896] then task.spawn(function() setName(endpoint, P[896], "Light") end) end
if P[705] then task.spawn(function() setLocked(endpoint, P[705], true) end) end
if P[705] then task.spawn(function() setName(endpoint, P[705], "Part45") end) end
if P[825] then task.spawn(function() setLocked(endpoint, P[825], true) end) end
if P[825] then task.spawn(function() setName(endpoint, P[825], "Part55") end) end
if P[1140] then task.spawn(function() setLocked(endpoint, P[1140], true) end) end
if P[599] then task.spawn(function() setLocked(endpoint, P[599], true) end) end
if P[599] then task.spawn(function() setName(endpoint, P[599], "Part6") end) end
if P[951] then task.spawn(function() setLocked(endpoint, P[951], true) end) end
if P[951] then task.spawn(function() setName(endpoint, P[951], "Part2") end) end
if P[465] then task.spawn(function() setLocked(endpoint, P[465], true) end) end
if P[465] then task.spawn(function() setName(endpoint, P[465], "MeshPart") end) end
if P[322] then task.spawn(function() setName(endpoint, P[322], "Torso") end) end
if P[586] then task.spawn(function() setLocked(endpoint, P[586], true) end) end
if P[586] then task.spawn(function() setName(endpoint, P[586], "Part4") end) end
if P[510] then task.spawn(function() setLocked(endpoint, P[510], true) end) end
if P[510] then task.spawn(function() setName(endpoint, P[510], "Part3") end) end
if P[438] then task.spawn(function() setName(endpoint, P[438], "Right Arm") end) end
if P[760] then task.spawn(function() setLocked(endpoint, P[760], true) end) end
if P[760] then task.spawn(function() setName(endpoint, P[760], "Part30") end) end
if P[171] then task.spawn(function() setLocked(endpoint, P[171], true) end) end
if P[171] then task.spawn(function() setName(endpoint, P[171], "RR") end) end
if P[544] then task.spawn(function() setLocked(endpoint, P[544], true) end) end
if P[544] then task.spawn(function() setName(endpoint, P[544], "Part6") end) end
if P[571] then task.spawn(function() setLocked(endpoint, P[571], true) end) end
if P[571] then task.spawn(function() setName(endpoint, P[571], "Part7") end) end
if P[584] then task.spawn(function() setLocked(endpoint, P[584], true) end) end
if P[584] then task.spawn(function() setName(endpoint, P[584], "Part8") end) end
if P[352] then task.spawn(function() setName(endpoint, P[352], "Left Leg") end) end
if P[469] then task.spawn(function() setLocked(endpoint, P[469], true) end) end
if P[469] then task.spawn(function() setName(endpoint, P[469], "Part10") end) end
if P[242] then task.spawn(function() setName(endpoint, P[242], "HumanoidRootPart") end) end
if P[180] then task.spawn(function() setLocked(endpoint, P[180], true) end) end
if P[180] then task.spawn(function() setName(endpoint, P[180], "Top") end) end
if P[819] then task.spawn(function() setLocked(endpoint, P[819], true) end) end
if P[819] then task.spawn(function() setName(endpoint, P[819], "Part3") end) end
if P[97] then task.spawn(function() setName(endpoint, P[97], "Head") end) end
if P[459] then task.spawn(function() setLocked(endpoint, P[459], true) end) end
if P[459] then task.spawn(function() setName(endpoint, P[459], "Smooth Block Model") end) end
if P[348] then task.spawn(function() setName(endpoint, P[348], "Left Arm") end) end
if P[875] then task.spawn(function() setLocked(endpoint, P[875], true) end) end
if P[875] then task.spawn(function() setName(endpoint, P[875], "Part53") end) end
if P[735] then task.spawn(function() setLocked(endpoint, P[735], true) end) end
if P[735] then task.spawn(function() setName(endpoint, P[735], "Part3") end) end
if P[491] then task.spawn(function() setLocked(endpoint, P[491], true) end) end
if P[491] then task.spawn(function() setName(endpoint, P[491], "Smooth Block Model") end) end
if P[360] then task.spawn(function() setName(endpoint, P[360], "Left Arm") end) end
if P[817] then task.spawn(function() setLocked(endpoint, P[817], true) end) end
if P[817] then task.spawn(function() setName(endpoint, P[817], "Part16") end) end
if P[814] then task.spawn(function() setLocked(endpoint, P[814], true) end) end
if P[814] then task.spawn(function() setName(endpoint, P[814], "Part74") end) end
if P[590] then task.spawn(function() setLocked(endpoint, P[590], true) end) end
if P[590] then task.spawn(function() setName(endpoint, P[590], "Part7") end) end
if P[753] then task.spawn(function() setLocked(endpoint, P[753], true) end) end
if P[1171] then task.spawn(function() setLocked(endpoint, P[1171], true) end) end
if P[1171] then task.spawn(function() setName(endpoint, P[1171], "MeshPart") end) end
if P[615] then task.spawn(function() setLocked(endpoint, P[615], true) end) end
if P[615] then task.spawn(function() setName(endpoint, P[615], "Smooth Block Model") end) end
if P[32] then task.spawn(function() setName(endpoint, P[32], "Right Leg") end) end
if P[808] then task.spawn(function() setLocked(endpoint, P[808], true) end) end
if P[808] then task.spawn(function() setName(endpoint, P[808], "Part5") end) end
if P[647] then task.spawn(function() setLocked(endpoint, P[647], true) end) end
if P[647] then task.spawn(function() setName(endpoint, P[647], "Part11") end) end
if P[16] then task.spawn(function() setName(endpoint, P[16], "Torso") end) end
if P[729] then task.spawn(function() setLocked(endpoint, P[729], true) end) end
if P[729] then task.spawn(function() setName(endpoint, P[729], "Part6") end) end
if P[445] then task.spawn(function() setName(endpoint, P[445], "Handle") end) end
if P[632] then task.spawn(function() setLocked(endpoint, P[632], true) end) end
if P[632] then task.spawn(function() setName(endpoint, P[632], "MeshPart") end) end
if P[741] then task.spawn(function() setLocked(endpoint, P[741], true) end) end
if P[741] then task.spawn(function() setName(endpoint, P[741], "Part9") end) end
if P[385] then task.spawn(function() setName(endpoint, P[385], "Left Leg") end) end
if P[655] then task.spawn(function() setLocked(endpoint, P[655], true) end) end
if P[655] then task.spawn(function() setName(endpoint, P[655], "Part64") end) end
if P[193] then task.spawn(function() setLocked(endpoint, P[193], true) end) end
if P[193] then task.spawn(function() setName(endpoint, P[193], "Part4") end) end
if P[774] then task.spawn(function() setLocked(endpoint, P[774], true) end) end
if P[774] then task.spawn(function() setName(endpoint, P[774], "Wedge") end) end
if P[629] then task.spawn(function() setLocked(endpoint, P[629], true) end) end
if P[629] then task.spawn(function() setName(endpoint, P[629], "Part9") end) end
if P[688] then task.spawn(function() setLocked(endpoint, P[688], true) end) end
if P[688] then task.spawn(function() setName(endpoint, P[688], "Part20") end) end
if P[962] then task.spawn(function() setLocked(endpoint, P[962], true) end) end
if P[962] then task.spawn(function() setName(endpoint, P[962], "Part4") end) end
if P[777] then task.spawn(function() setLocked(endpoint, P[777], true) end) end
if P[777] then task.spawn(function() setName(endpoint, P[777], "Part14") end) end
if P[822] then task.spawn(function() setLocked(endpoint, P[822], true) end) end
if P[829] then task.spawn(function() setLocked(endpoint, P[829], true) end) end
if P[829] then task.spawn(function() setName(endpoint, P[829], "Part52") end) end
if P[768] then task.spawn(function() setLocked(endpoint, P[768], true) end) end
if P[768] then task.spawn(function() setName(endpoint, P[768], "Part62") end) end
if P[668] then task.spawn(function() setLocked(endpoint, P[668], true) end) end
if P[668] then task.spawn(function() setName(endpoint, P[668], "Part68") end) end
if P[866] then task.spawn(function() setLocked(endpoint, P[866], true) end) end
if P[866] then task.spawn(function() setName(endpoint, P[866], "Part5") end) end
if P[778] then task.spawn(function() setLocked(endpoint, P[778], true) end) end
if P[778] then task.spawn(function() setName(endpoint, P[778], "Part15") end) end
if P[578] then task.spawn(function() setLocked(endpoint, P[578], true) end) end
if P[578] then task.spawn(function() setName(endpoint, P[578], "Part3") end) end
if P[1093] then task.spawn(function() setLocked(endpoint, P[1093], true) end) end
if P[1225] then task.spawn(function() setLocked(endpoint, P[1225], true) end) end
if P[1225] then task.spawn(function() setName(endpoint, P[1225], "Part3") end) end
if P[9] then task.spawn(function() setName(endpoint, P[9], "Head") end) end
if P[550] then task.spawn(function() setLocked(endpoint, P[550], true) end) end
if P[550] then task.spawn(function() setName(endpoint, P[550], "Part2") end) end
if P[271] then task.spawn(function() setLocked(endpoint, P[271], true) end) end
if P[271] then task.spawn(function() setName(endpoint, P[271], "Handle") end) end
if P[743] then task.spawn(function() setLocked(endpoint, P[743], true) end) end
if P[743] then task.spawn(function() setName(endpoint, P[743], "Part11") end) end
if P[787] then task.spawn(function() setLocked(endpoint, P[787], true) end) end
if P[787] then task.spawn(function() setName(endpoint, P[787], "Part11") end) end
if P[737] then task.spawn(function() setLocked(endpoint, P[737], true) end) end
if P[737] then task.spawn(function() setName(endpoint, P[737], "Part18") end) end
if P[888] then task.spawn(function() setLocked(endpoint, P[888], true) end) end
if P[888] then task.spawn(function() setName(endpoint, P[888], "Light") end) end
if P[296] then task.spawn(function() setName(endpoint, P[296], "HumanoidRootPart") end) end
if P[542] then task.spawn(function() setLocked(endpoint, P[542], true) end) end
if P[542] then task.spawn(function() setName(endpoint, P[542], "Part5") end) end
if P[552] then task.spawn(function() setLocked(endpoint, P[552], true) end) end
if P[552] then task.spawn(function() setName(endpoint, P[552], "Part7") end) end
if P[1267] then task.spawn(function() setLocked(endpoint, P[1267], true) end) end
if P[1267] then task.spawn(function() setName(endpoint, P[1267], "Part2") end) end
if P[559] then task.spawn(function() setLocked(endpoint, P[559], true) end) end
if P[559] then task.spawn(function() setName(endpoint, P[559], "Part3") end) end
if P[1268] then task.spawn(function() setLocked(endpoint, P[1268], true) end) end
if P[1268] then task.spawn(function() setName(endpoint, P[1268], "Seat") end) end
if P[537] then task.spawn(function() setLocked(endpoint, P[537], true) end) end
if P[704] then task.spawn(function() setLocked(endpoint, P[704], true) end) end
if P[704] then task.spawn(function() setName(endpoint, P[704], "Part72") end) end
if P[710] then task.spawn(function() setLocked(endpoint, P[710], true) end) end
if P[710] then task.spawn(function() setName(endpoint, P[710], "Part65") end) end
if P[1191] then task.spawn(function() setLocked(endpoint, P[1191], true) end) end
if P[1191] then task.spawn(function() setName(endpoint, P[1191], "Seat") end) end
if P[712] then task.spawn(function() setLocked(endpoint, P[712], true) end) end
if P[712] then task.spawn(function() setName(endpoint, P[712], "Part61") end) end
if P[533] then task.spawn(function() setLocked(endpoint, P[533], true) end) end
if P[533] then task.spawn(function() setName(endpoint, P[533], "Part3") end) end
if P[535] then task.spawn(function() setLocked(endpoint, P[535], true) end) end
if P[535] then task.spawn(function() setName(endpoint, P[535], "Part5") end) end
if P[918] then task.spawn(function() setLocked(endpoint, P[918], true) end) end
if P[918] then task.spawn(function() setName(endpoint, P[918], "Part5") end) end
if P[37] then task.spawn(function() setName(endpoint, P[37], "Left Leg") end) end
if P[74] then task.spawn(function() setName(endpoint, P[74], "Right Arm") end) end
if P[666] then task.spawn(function() setLocked(endpoint, P[666], true) end) end
if P[666] then task.spawn(function() setName(endpoint, P[666], "Part63") end) end
if P[601] then task.spawn(function() setLocked(endpoint, P[601], true) end) end
if P[601] then task.spawn(function() setName(endpoint, P[601], "Part8") end) end
if P[613] then task.spawn(function() setLocked(endpoint, P[613], true) end) end
if P[613] then task.spawn(function() setName(endpoint, P[613], "Part18") end) end
if P[387] then task.spawn(function() setLocked(endpoint, P[387], true) end) end
if P[387] then task.spawn(function() setName(endpoint, P[387], "FlyCameraFocus") end) end
if P[862] then task.spawn(function() setLocked(endpoint, P[862], true) end) end
if P[862] then task.spawn(function() setName(endpoint, P[862], "Part39") end) end
if P[693] then task.spawn(function() setLocked(endpoint, P[693], true) end) end
if P[693] then task.spawn(function() setName(endpoint, P[693], "Part40") end) end
if P[167] then task.spawn(function() setLocked(endpoint, P[167], true) end) end
if P[167] then task.spawn(function() setName(endpoint, P[167], "FR") end) end
if P[191] then task.spawn(function() setLocked(endpoint, P[191], true) end) end
if P[191] then task.spawn(function() setName(endpoint, P[191], "Part5") end) end
task.wait(0.2)
if P[9] then task.spawn(function()
    createMesh(endpoint, P[9])
    syncMesh(endpoint, P[9], Enum.MeshType.Head, Vector3.new(1.25,1.25,1.25), Vector3.new(0,0,0), nil, nil, nil)
end) end
if P[50] then task.spawn(function()
    createMesh(endpoint, P[50])
    syncMesh(endpoint, P[50], Enum.MeshType.Head, Vector3.new(1.25,1.25,1.25), Vector3.new(0,0,0), nil, nil, nil)
end) end
if P[77] then task.spawn(function()
    createMesh(endpoint, P[77])
    syncMesh(endpoint, P[77], Enum.MeshType.FileMesh, Vector3.new(1,1,1), Vector3.new(0,0,0), "rbxassetid://85388117939677", "rbxassetid://140669275370144", nil)
end) end
if P[97] then task.spawn(function()
    createMesh(endpoint, P[97])
    syncMesh(endpoint, P[97], Enum.MeshType.Head, Vector3.new(1.25,1.25,1.25), Vector3.new(0,0,0), nil, nil, nil)
end) end
if P[124] then task.spawn(function()
    createMesh(endpoint, P[124])
    syncMesh(endpoint, P[124], Enum.MeshType.FileMesh, Vector3.new(2.4444451332092285,2.4444451332092285,2.4444451332092285), Vector3.new(0,0,0), "rbxassetid://17693708435", "rbxassetid://17693729465", nil)
end) end
if P[180] then task.spawn(function()
    createMesh(endpoint, P[180])
    syncMesh(endpoint, P[180], Enum.MeshType.FileMesh, Vector3.new(1.1487640142440796,1.14876389503479,1.1487641334533691), Vector3.new(0,0,0), "rbxassetid://7112788338", "rbxassetid://5837852654", nil)
end) end
if P[182] then task.spawn(function()
    createMesh(endpoint, P[182])
    syncMesh(endpoint, P[182], Enum.MeshType.FileMesh, Vector3.new(1.1487640142440796,1.14876389503479,1.1487640142440796), Vector3.new(0,0,0), "rbxassetid://7112790077", "rbxassetid://5837852654", nil)
end) end
if P[185] then task.spawn(function()
    createMesh(endpoint, P[185])
    syncMesh(endpoint, P[185], Enum.MeshType.FileMesh, Vector3.new(1.1487640142440796,1.1487640142440796,1.1487640142440796), Vector3.new(0,0,0), "rbxassetid://7112791601", "rbxassetid://5837852654", nil)
end) end
if P[187] then task.spawn(function()
    createMesh(endpoint, P[187])
    syncMesh(endpoint, P[187], Enum.MeshType.FileMesh, Vector3.new(1,1,0.9999999403953552), Vector3.new(0,0,0), "rbxassetid://7112813522", "rbxassetid://5837852654", nil)
end) end
if P[248] then task.spawn(function()
    createMesh(endpoint, P[248])
    syncMesh(endpoint, P[248], Enum.MeshType.FileMesh, Vector3.new(1,1,1), Vector3.new(0,0,0), "rbxassetid://129044769889449", "rbxassetid://84904487324523", nil)
end) end
if P[271] then task.spawn(function()
    createMesh(endpoint, P[271])
    syncMesh(endpoint, P[271], Enum.MeshType.FileMesh, Vector3.new(1.100000023841858,1.100000023841858,1.100000023841858), Vector3.new(0,0,0), "http://www.roblox.com/asset/?id=1286427", "http://www.roblox.com/asset/?id=1309894", nil)
end) end
if P[279] then task.spawn(function()
    createMesh(endpoint, P[279])
    syncMesh(endpoint, P[279], Enum.MeshType.FileMesh, Vector3.new(1,1,1), Vector3.new(0,0,0), "rbxassetid://17693708435", "rbxassetid://17693729465", nil)
end) end
if P[288] then task.spawn(function()
    createMesh(endpoint, P[288])
    syncMesh(endpoint, P[288], Enum.MeshType.FileMesh, Vector3.new(0.8727008700370789,0.8727009296417236,0.8727009296417236), Vector3.new(0,0,0), "rbxassetid://93252612543015", "rbxassetid://83711766618454", nil)
end) end
if P[313] then task.spawn(function()
    createMesh(endpoint, P[313])
    syncMesh(endpoint, P[313], Enum.MeshType.Head, Vector3.new(1.25,1.25,1.25), Vector3.new(0,0,0), nil, nil, nil)
end) end
if P[338] then task.spawn(function()
    createMesh(endpoint, P[338])
    syncMesh(endpoint, P[338], Enum.MeshType.FileMesh, Vector3.new(0.5199999809265137,0.5199999809265137,0.5199999809265137), Vector3.new(0,0,0), "http://www.roblox.com/asset/?id=417373422 ", "http://www.roblox.com/asset/?id=417371021", nil)
end) end
if P[363] then task.spawn(function()
    createMesh(endpoint, P[363])
    syncMesh(endpoint, P[363], Enum.MeshType.Head, Vector3.new(1.25,1.25,1.25), Vector3.new(0,0,0), nil, nil, nil)
end) end
if P[402] then task.spawn(function()
    createMesh(endpoint, P[402])
    syncMesh(endpoint, P[402], Enum.MeshType.FileMesh, Vector3.new(1,1,1), Vector3.new(0,0,0), "rbxassetid://94083479354865", "rbxassetid://88420780783403", nil)
end) end
if P[445] then task.spawn(function()
    createMesh(endpoint, P[445])
    syncMesh(endpoint, P[445], Enum.MeshType.FileMesh, Vector3.new(1,1,1), Vector3.new(0,0,0), "rbxassetid://103850638124095", "rbxassetid://108128208117354", nil)
end) end
if P[453] then task.spawn(function()
    createMesh(endpoint, P[453])
    syncMesh(endpoint, P[453], Enum.MeshType.FileMesh, Vector3.new(5500,5500,5500), Vector3.new(0,0,0), "rbxassetid://111891702759441", "rbxassetid://81335862348761", Vector3.new(6,6,6))
end) end
if P[456] then task.spawn(function()
    createMesh(endpoint, P[456])
    syncMesh(endpoint, P[456], Enum.MeshType.FileMesh, Vector3.new(1,1,1), Vector3.new(0,0,0), "rbxassetid://139101666430333", "rbxassetid://138255391073014", nil)
end) end
if P[461] then task.spawn(function()
    createMesh(endpoint, P[461])
    syncMesh(endpoint, P[461], Enum.MeshType.FileMesh, Vector3.new(1,0.800000011920929,0.800000011920929), Vector3.new(0,0,0), "http://www.roblox.com/asset/?id=93054682", "http://www.roblox.com/asset/?id=93054830", nil)
end) end
if P[465] then task.spawn(function()
    createMesh(endpoint, P[465])
    syncMesh(endpoint, P[465], Enum.MeshType.FileMesh, Vector3.new(0.6533881425857544,0.6533880233764648,0.6533880829811096), Vector3.new(0,0,0), "rbxassetid://448193601", "rbxassetid://4012287099", nil)
end) end
if P[478] then task.spawn(function()
    createMesh(endpoint, P[478])
    syncMesh(endpoint, P[478], Enum.MeshType.FileMesh, Vector3.new(0.9999999403953552,0.9999999403953552,1), Vector3.new(0,0,0), "rbxassetid://440985523", "rbxassetid://4012275781", nil)
end) end
if P[487] then task.spawn(function()
    createMesh(endpoint, P[487])
    syncMesh(endpoint, P[487], Enum.MeshType.FileMesh, Vector3.new(0.9999999403953552,0.9999999403953552,1), Vector3.new(0,0,0), "rbxassetid://440985523", "rbxassetid://4012275781", nil)
end) end
if P[506] then task.spawn(function()
    createMesh(endpoint, P[506])
    syncMesh(endpoint, P[506], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[525] then task.spawn(function()
    createMesh(endpoint, P[525])
    syncMesh(endpoint, P[525], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[611] then task.spawn(function()
    createMesh(endpoint, P[611])
    syncMesh(endpoint, P[611], Enum.MeshType.FileMesh, Vector3.new(1,0.800000011920929,0.800000011920929), Vector3.new(0,0,0), "http://www.roblox.com/asset/?id=93054682", "http://www.roblox.com/asset/?id=93054830", nil)
end) end
if P[632] then task.spawn(function()
    createMesh(endpoint, P[632])
    syncMesh(endpoint, P[632], Enum.MeshType.FileMesh, Vector3.new(0.9999999403953552,0.9999999403953552,1), Vector3.new(0,0,0), "rbxassetid://440985523", "rbxassetid://4012275781", nil)
end) end
if P[1011] then task.spawn(function()
    createMesh(endpoint, P[1011])
    syncMesh(endpoint, P[1011], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[1030] then task.spawn(function()
    createMesh(endpoint, P[1030])
    syncMesh(endpoint, P[1030], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[1040] then task.spawn(function()
    createMesh(endpoint, P[1040])
    syncMesh(endpoint, P[1040], Enum.MeshType.FileMesh, Vector3.new(0.9999999403953552,0.9999999403953552,1), Vector3.new(0,0,0), "rbxassetid://440985523", "rbxassetid://4012275781", nil)
end) end
if P[1057] then task.spawn(function()
    createMesh(endpoint, P[1057])
    syncMesh(endpoint, P[1057], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[1072] then task.spawn(function()
    createMesh(endpoint, P[1072])
    syncMesh(endpoint, P[1072], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[1091] then task.spawn(function()
    createMesh(endpoint, P[1091])
    syncMesh(endpoint, P[1091], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[1119] then task.spawn(function()
    createMesh(endpoint, P[1119])
    syncMesh(endpoint, P[1119], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[1138] then task.spawn(function()
    createMesh(endpoint, P[1138])
    syncMesh(endpoint, P[1138], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[1156] then task.spawn(function()
    createMesh(endpoint, P[1156])
    syncMesh(endpoint, P[1156], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[1171] then task.spawn(function()
    createMesh(endpoint, P[1171])
    syncMesh(endpoint, P[1171], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[1186] then task.spawn(function()
    createMesh(endpoint, P[1186])
    syncMesh(endpoint, P[1186], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[1201] then task.spawn(function()
    createMesh(endpoint, P[1201])
    syncMesh(endpoint, P[1201], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[1217] then task.spawn(function()
    createMesh(endpoint, P[1217])
    syncMesh(endpoint, P[1217], Enum.MeshType.FileMesh, Vector3.new(0.9999999403953552,0.9999999403953552,1), Vector3.new(0,0,0), "rbxassetid://440985523", "rbxassetid://4012275781", nil)
end) end
if P[1237] then task.spawn(function()
    createMesh(endpoint, P[1237])
    syncMesh(endpoint, P[1237], Enum.MeshType.FileMesh, Vector3.new(0.6533881425857544,0.6533880233764648,0.6533880829811096), Vector3.new(0,0,0), "rbxassetid://448193601", "rbxassetid://4012287099", nil)
end) end
if P[1248] then task.spawn(function()
    createMesh(endpoint, P[1248])
    syncMesh(endpoint, P[1248], Enum.MeshType.FileMesh, Vector3.new(0.9999999403953552,0.9999999403953552,1), Vector3.new(0,0,0), "rbxassetid://440985523", "rbxassetid://4012275781", nil)
end) end
if P[1263] then task.spawn(function()
    createMesh(endpoint, P[1263])
    syncMesh(endpoint, P[1263], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[1278] then task.spawn(function()
    createMesh(endpoint, P[1278])
    syncMesh(endpoint, P[1278], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[1293] then task.spawn(function()
    createMesh(endpoint, P[1293])
    syncMesh(endpoint, P[1293], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[1308] then task.spawn(function()
    createMesh(endpoint, P[1308])
    syncMesh(endpoint, P[1308], Enum.MeshType.FileMesh, Vector3.new(0.8659809231758118,0.8659809231758118,0.8659809827804565), Vector3.new(0,0,0), "rbxassetid://2368532765", nil, nil)
end) end
if P[1329] then task.spawn(function()
    createMesh(endpoint, P[1329])
    syncMesh(endpoint, P[1329], Enum.MeshType.FileMesh, Vector3.new(1,1,1), Vector3.new(0,0,0), "rbxassetid://139101666430333", "rbxassetid://138255391073014", nil)
end) end
if P[40] then task.spawn(function()
    createMesh(endpoint, P[40])
    syncMesh(endpoint, P[40], Enum.MeshType.FileMesh, Vector3.new(1.100000023841858,1.100000023841858,1.100000023841858), Vector3.new(0,0,0), "http://www.roblox.com/asset/?id=1286427", "http://www.roblox.com/asset/?id=1309894", nil)
end) end
if P[41] then task.spawn(function()
    createMesh(endpoint, P[41])
    syncMesh(endpoint, P[41], Enum.MeshType.FileMesh, Vector3.new(1,1,1), Vector3.new(0,0,0), "rbxassetid://17693708435", "rbxassetid://17693729465", nil)
end) end
if P[42] then task.spawn(function()
    createMesh(endpoint, P[42])
    syncMesh(endpoint, P[42], Enum.MeshType.FileMesh, Vector3.new(0.8727008700370789,0.8727009296417236,0.8727009296417236), Vector3.new(0,0,0), "rbxassetid://93252612543015", "rbxassetid://83711766618454", nil)
end) end
if P[43] then task.spawn(function()
    createMesh(endpoint, P[43])
    syncMesh(endpoint, P[43], Enum.MeshType.FileMesh, Vector3.new(0.5199999809265137,0.5199999809265137,0.5199999809265137), Vector3.new(0,0,0), "http://www.roblox.com/asset/?id=417373422 ", "http://www.roblox.com/asset/?id=417371021", nil)
end) end
if P[212] then task.spawn(function()
    createMesh(endpoint, P[212])
    syncMesh(endpoint, P[212], Enum.MeshType.FileMesh, Vector3.new(1.100000023841858,1.100000023841858,1.100000023841858), Vector3.new(0,0,0), "http://www.roblox.com/asset/?id=1286427", "http://www.roblox.com/asset/?id=1309894", nil)
end) end
if P[213] then task.spawn(function()
    createMesh(endpoint, P[213])
    syncMesh(endpoint, P[213], Enum.MeshType.FileMesh, Vector3.new(1,1,1), Vector3.new(0,0,0), "rbxassetid://17693708435", "rbxassetid://17693729465", nil)
end) end
if P[214] then task.spawn(function()
    createMesh(endpoint, P[214])
    syncMesh(endpoint, P[214], Enum.MeshType.FileMesh, Vector3.new(0.8727008700370789,0.8727009296417236,0.8727009296417236), Vector3.new(0,0,0), "rbxassetid://93252612543015", "rbxassetid://83711766618454", nil)
end) end
if P[309] then task.spawn(function()
    createMesh(endpoint, P[309])
    syncMesh(endpoint, P[309], Enum.MeshType.FileMesh, Vector3.new(0.5199999809265137,0.5199999809265137,0.5199999809265137), Vector3.new(0,0,0), "http://www.roblox.com/asset/?id=417373422 ", "http://www.roblox.com/asset/?id=417371021", nil)
end) end
if P[391] then task.spawn(function()
    createMesh(endpoint, P[391])
    syncMesh(endpoint, P[391], Enum.MeshType.FileMesh, Vector3.new(1,1,1), Vector3.new(0,0,0), "rbxassetid://103850638124095", "rbxassetid://108128208117354", nil)
end) end
task.wait(0.3)
if P[9] then task.spawn(function()
    createDecal(endpoint, P[9], Enum.NormalId.Front)
    setDecalTex(endpoint, P[9], "rbxasset://textures/face.png", Enum.NormalId.Front)
end) end
if P[16] then task.spawn(function()
    createDecal(endpoint, P[16], Enum.NormalId.Front)
end) end
if P[50] then task.spawn(function()
    createDecal(endpoint, P[50], Enum.NormalId.Front)
    setDecalTex(endpoint, P[50], "rbxasset://textures/face.png", Enum.NormalId.Front)
end) end
if P[57] then task.spawn(function()
    createDecal(endpoint, P[57], Enum.NormalId.Front)
    setDecalTex(endpoint, P[57], "rbxassetid://103785275268293", Enum.NormalId.Front)
end) end
if P[97] then task.spawn(function()
    createDecal(endpoint, P[97], Enum.NormalId.Front)
    setDecalTex(endpoint, P[97], "rbxthumb://type=Asset&id=25321744&w=420&h=420", Enum.NormalId.Front)
end) end
if P[104] then task.spawn(function()
    createDecal(endpoint, P[104], Enum.NormalId.Front)
    setDecalTex(endpoint, P[104], "rbxassetid://12900655353", Enum.NormalId.Front)
end) end
if P[196] then task.spawn(function()
    createDecal(endpoint, P[196], Enum.NormalId.Top)
    setDecalTex(endpoint, P[196], "rbxthumb://type=Asset&id=96852595721988&w=420&h=420", Enum.NormalId.Top)
end) end
if P[204] then task.spawn(function()
    createDecal(endpoint, P[204], Enum.NormalId.Front)
    setDecalTex(endpoint, P[204], "rbxassetid://29095508", Enum.NormalId.Front)
end) end
if P[204] then task.spawn(function()
    createDecal(endpoint, P[204], Enum.NormalId.Right)
    setDecalTex(endpoint, P[204], "rbxassetid://70983855", Enum.NormalId.Right)
end) end
if P[204] then task.spawn(function()
    createDecal(endpoint, P[204], Enum.NormalId.Back)
    setDecalTex(endpoint, P[204], "rbxassetid://29095508", Enum.NormalId.Back)
end) end
if P[204] then task.spawn(function()
    createDecal(endpoint, P[204], Enum.NormalId.Bottom)
    setDecalTex(endpoint, P[204], "rbxassetid://70983855", Enum.NormalId.Bottom)
end) end
if P[204] then task.spawn(function()
    createDecal(endpoint, P[204], Enum.NormalId.Left)
    setDecalTex(endpoint, P[204], "rbxassetid://29095508", Enum.NormalId.Left)
end) end
if P[204] then task.spawn(function()
    createDecal(endpoint, P[204], Enum.NormalId.Top)
    setDecalTex(endpoint, P[204], "rbxassetid://70983855", Enum.NormalId.Top)
end) end
if P[227] then task.spawn(function()
    createDecal(endpoint, P[227], Enum.NormalId.Front)
end) end
if P[248] then task.spawn(function()
    createDecal(endpoint, P[248], Enum.NormalId.Front)
    setDecalTex(endpoint, P[248], "rbxasset://textures/face.png", Enum.NormalId.Front)
end) end
if P[300] then task.spawn(function()
    createDecal(endpoint, P[300], Enum.NormalId.Front)
    setDecalTex(endpoint, P[300], "rbxassetid://29095508", Enum.NormalId.Front)
end) end
if P[300] then task.spawn(function()
    createDecal(endpoint, P[300], Enum.NormalId.Right)
    setDecalTex(endpoint, P[300], "rbxassetid://70983855", Enum.NormalId.Right)
end) end
if P[300] then task.spawn(function()
    createDecal(endpoint, P[300], Enum.NormalId.Back)
    setDecalTex(endpoint, P[300], "rbxassetid://29095508", Enum.NormalId.Back)
end) end
if P[300] then task.spawn(function()
    createDecal(endpoint, P[300], Enum.NormalId.Bottom)
    setDecalTex(endpoint, P[300], "rbxassetid://70983855", Enum.NormalId.Bottom)
end) end
if P[300] then task.spawn(function()
    createDecal(endpoint, P[300], Enum.NormalId.Left)
    setDecalTex(endpoint, P[300], "rbxassetid://29095508", Enum.NormalId.Left)
end) end
if P[300] then task.spawn(function()
    createDecal(endpoint, P[300], Enum.NormalId.Top)
    setDecalTex(endpoint, P[300], "rbxassetid://70983855", Enum.NormalId.Top)
end) end
if P[313] then task.spawn(function()
    createDecal(endpoint, P[313], Enum.NormalId.Front)
    setDecalTex(endpoint, P[313], "rbxasset://textures/face.png", Enum.NormalId.Front)
end) end
if P[322] then task.spawn(function()
    createDecal(endpoint, P[322], Enum.NormalId.Front)
end) end
if P[363] then task.spawn(function()
    createDecal(endpoint, P[363], Enum.NormalId.Front)
    setDecalTex(endpoint, P[363], "rbxthumb://type=Asset&id=5799739939&w=420&h=420", Enum.NormalId.Front)
end) end
if P[370] then task.spawn(function()
    createDecal(endpoint, P[370], Enum.NormalId.Front)
end) end
if P[402] then task.spawn(function()
    createDecal(endpoint, P[402], Enum.NormalId.Front)
    setDecalTex(endpoint, P[402], "rbxasset://textures/face.png", Enum.NormalId.Front)
end) end
if P[414] then task.spawn(function()
    createDecal(endpoint, P[414], Enum.NormalId.Front)
    setDecalTex(endpoint, P[414], "rbxassetid://1603624", Enum.NormalId.Front)
end) end
if P[463] then task.spawn(function()
    createDecal(endpoint, P[463], Enum.NormalId.Left)
    setDecalTex(endpoint, P[463], "rbxassetid://43479241", Enum.NormalId.Left)
    setDecalTr(endpoint, P[463], 0.800000011920929, Enum.NormalId.Left)
end) end
if P[469] then task.spawn(function()
    createDecal(endpoint, P[469], Enum.NormalId.Left)
    setDecalTex(endpoint, P[469], "rbxassetid://43479241", Enum.NormalId.Left)
    setDecalTr(endpoint, P[469], 0.800000011920929, Enum.NormalId.Left)
end) end
if P[528] then task.spawn(function()
    createDecal(endpoint, P[528], Enum.NormalId.Top)
    setDecalTex(endpoint, P[528], "rbxassetid://321235183", Enum.NormalId.Top)
end) end
if P[533] then task.spawn(function()
    createDecal(endpoint, P[533], Enum.NormalId.Front)
    setDecalTex(endpoint, P[533], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[533], 0.8999999761581421, Enum.NormalId.Front)
end) end
if P[535] then task.spawn(function()
    createDecal(endpoint, P[535], Enum.NormalId.Top)
    setDecalTex(endpoint, P[535], "rbxassetid://4753420342", Enum.NormalId.Top)
    setDecalTr(endpoint, P[535], 0.5, Enum.NormalId.Top)
end) end
if P[537] then task.spawn(function()
    createDecal(endpoint, P[537], Enum.NormalId.Back)
    setDecalTex(endpoint, P[537], "rbxassetid://147149580", Enum.NormalId.Back)
    setDecalTr(endpoint, P[537], 0.8999999761581421, Enum.NormalId.Back)
end) end
if P[540] then task.spawn(function()
    createDecal(endpoint, P[540], Enum.NormalId.Back)
    setDecalTex(endpoint, P[540], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[542] then task.spawn(function()
    createDecal(endpoint, P[542], Enum.NormalId.Back)
    setDecalTex(endpoint, P[542], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[544] then task.spawn(function()
    createDecal(endpoint, P[544], Enum.NormalId.Front)
    setDecalTex(endpoint, P[544], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[546] then task.spawn(function()
    createDecal(endpoint, P[546], Enum.NormalId.Front)
    setDecalTex(endpoint, P[546], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[548] then task.spawn(function()
    createDecal(endpoint, P[548], Enum.NormalId.Back)
    setDecalTex(endpoint, P[548], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[550] then task.spawn(function()
    createDecal(endpoint, P[550], Enum.NormalId.Back)
    setDecalTex(endpoint, P[550], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[552] then task.spawn(function()
    createDecal(endpoint, P[552], Enum.NormalId.Front)
    setDecalTex(endpoint, P[552], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[554] then task.spawn(function()
    createDecal(endpoint, P[554], Enum.NormalId.Front)
    setDecalTex(endpoint, P[554], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[556] then task.spawn(function()
    createDecal(endpoint, P[556], Enum.NormalId.Left)
    setDecalTex(endpoint, P[556], "rbxassetid://147149580", Enum.NormalId.Left)
    setDecalTr(endpoint, P[556], 0.8999999761581421, Enum.NormalId.Left)
end) end
if P[559] then task.spawn(function()
    createDecal(endpoint, P[559], Enum.NormalId.Front)
    setDecalTex(endpoint, P[559], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[561] then task.spawn(function()
    createDecal(endpoint, P[561], Enum.NormalId.Front)
    setDecalTex(endpoint, P[561], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[563] then task.spawn(function()
    createDecal(endpoint, P[563], Enum.NormalId.Back)
    setDecalTex(endpoint, P[563], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[565] then task.spawn(function()
    createDecal(endpoint, P[565], Enum.NormalId.Back)
    setDecalTex(endpoint, P[565], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[567] then task.spawn(function()
    createDecal(endpoint, P[567], Enum.NormalId.Front)
    setDecalTex(endpoint, P[567], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[569] then task.spawn(function()
    createDecal(endpoint, P[569], Enum.NormalId.Back)
    setDecalTex(endpoint, P[569], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[571] then task.spawn(function()
    createDecal(endpoint, P[571], Enum.NormalId.Front)
    setDecalTex(endpoint, P[571], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[573] then task.spawn(function()
    createDecal(endpoint, P[573], Enum.NormalId.Back)
    setDecalTex(endpoint, P[573], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[575] then task.spawn(function()
    createDecal(endpoint, P[575], Enum.NormalId.Right)
    setDecalTex(endpoint, P[575], "rbxassetid://147149580", Enum.NormalId.Right)
    setDecalTr(endpoint, P[575], 0.8999999761581421, Enum.NormalId.Right)
end) end
if P[578] then task.spawn(function()
    createDecal(endpoint, P[578], Enum.NormalId.Back)
    setDecalTex(endpoint, P[578], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[580] then task.spawn(function()
    createDecal(endpoint, P[580], Enum.NormalId.Front)
    setDecalTex(endpoint, P[580], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[582] then task.spawn(function()
    createDecal(endpoint, P[582], Enum.NormalId.Back)
    setDecalTex(endpoint, P[582], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[584] then task.spawn(function()
    createDecal(endpoint, P[584], Enum.NormalId.Front)
    setDecalTex(endpoint, P[584], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[586] then task.spawn(function()
    createDecal(endpoint, P[586], Enum.NormalId.Back)
    setDecalTex(endpoint, P[586], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[588] then task.spawn(function()
    createDecal(endpoint, P[588], Enum.NormalId.Front)
    setDecalTex(endpoint, P[588], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[590] then task.spawn(function()
    createDecal(endpoint, P[590], Enum.NormalId.Front)
    setDecalTex(endpoint, P[590], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[592] then task.spawn(function()
    createDecal(endpoint, P[592], Enum.NormalId.Back)
    setDecalTex(endpoint, P[592], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[595] then task.spawn(function()
    createDecal(endpoint, P[595], Enum.NormalId.Back)
    setDecalTex(endpoint, P[595], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[597] then task.spawn(function()
    createDecal(endpoint, P[597], Enum.NormalId.Front)
    setDecalTex(endpoint, P[597], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[599] then task.spawn(function()
    createDecal(endpoint, P[599], Enum.NormalId.Front)
    setDecalTex(endpoint, P[599], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[601] then task.spawn(function()
    createDecal(endpoint, P[601], Enum.NormalId.Front)
    setDecalTex(endpoint, P[601], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[603] then task.spawn(function()
    createDecal(endpoint, P[603], Enum.NormalId.Back)
    setDecalTex(endpoint, P[603], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[605] then task.spawn(function()
    createDecal(endpoint, P[605], Enum.NormalId.Back)
    setDecalTex(endpoint, P[605], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[607] then task.spawn(function()
    createDecal(endpoint, P[607], Enum.NormalId.Front)
    setDecalTex(endpoint, P[607], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[609] then task.spawn(function()
    createDecal(endpoint, P[609], Enum.NormalId.Back)
    setDecalTex(endpoint, P[609], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[613] then task.spawn(function()
    createDecal(endpoint, P[613], Enum.NormalId.Left)
    setDecalTex(endpoint, P[613], "rbxassetid://43479241", Enum.NormalId.Left)
    setDecalTr(endpoint, P[613], 0.800000011920929, Enum.NormalId.Left)
end) end
if P[617] then task.spawn(function()
    createDecal(endpoint, P[617], Enum.NormalId.Left)
    setDecalTex(endpoint, P[617], "rbxassetid://43479241", Enum.NormalId.Left)
    setDecalTr(endpoint, P[617], 0.800000011920929, Enum.NormalId.Left)
end) end
if P[619] then task.spawn(function()
    createDecal(endpoint, P[619], Enum.NormalId.Right)
    setDecalTex(endpoint, P[619], "rbxassetid://1469219653", Enum.NormalId.Right)
    setDecalTr(endpoint, P[619], 0.20000000298023224, Enum.NormalId.Right)
end) end
if P[619] then task.spawn(function()
    createDecal(endpoint, P[619], Enum.NormalId.Left)
    setDecalTex(endpoint, P[619], "rbxassetid://126939754", Enum.NormalId.Left)
    setDecalTr(endpoint, P[619], 0.5, Enum.NormalId.Left)
end) end
if P[622] then task.spawn(function()
    createDecal(endpoint, P[622], Enum.NormalId.Back)
    setDecalTex(endpoint, P[622], "rbxassetid://220114868", Enum.NormalId.Back)
end) end
if P[622] then task.spawn(function()
    createDecal(endpoint, P[622], Enum.NormalId.Top)
    setDecalTex(endpoint, P[622], "rbxassetid://220114868", Enum.NormalId.Top)
end) end
if P[622] then task.spawn(function()
    createDecal(endpoint, P[622], Enum.NormalId.Bottom)
    setDecalTex(endpoint, P[622], "rbxassetid://220114868", Enum.NormalId.Bottom)
end) end
if P[622] then task.spawn(function()
    createDecal(endpoint, P[622], Enum.NormalId.Front)
    setDecalTex(endpoint, P[622], "rbxassetid://220114868", Enum.NormalId.Front)
end) end
if P[622] then task.spawn(function()
    createDecal(endpoint, P[622], Enum.NormalId.Front)
    setDecalTex(endpoint, P[622], "rbxassetid://220114868", Enum.NormalId.Front)
end) end
if P[622] then task.spawn(function()
    createDecal(endpoint, P[622], Enum.NormalId.Left)
    setDecalTex(endpoint, P[622], "rbxassetid://220114868", Enum.NormalId.Left)
end) end
if P[629] then task.spawn(function()
    createDecal(endpoint, P[629], Enum.NormalId.Left)
    setDecalTex(endpoint, P[629], "rbxassetid://0", Enum.NormalId.Left)
    setDecalTr(endpoint, P[629], 0.5, Enum.NormalId.Left)
end) end
if P[640] then task.spawn(function()
    createDecal(endpoint, P[640], Enum.NormalId.Bottom)
    setDecalTex(endpoint, P[640], "rbxassetid://220114868", Enum.NormalId.Bottom)
end) end
if P[640] then task.spawn(function()
    createDecal(endpoint, P[640], Enum.NormalId.Front)
    setDecalTex(endpoint, P[640], "rbxassetid://220114868", Enum.NormalId.Front)
end) end
if P[640] then task.spawn(function()
    createDecal(endpoint, P[640], Enum.NormalId.Right)
    setDecalTex(endpoint, P[640], "rbxassetid://220114868", Enum.NormalId.Right)
end) end
if P[640] then task.spawn(function()
    createDecal(endpoint, P[640], Enum.NormalId.Front)
    setDecalTex(endpoint, P[640], "rbxassetid://220114868", Enum.NormalId.Front)
end) end
if P[640] then task.spawn(function()
    createDecal(endpoint, P[640], Enum.NormalId.Top)
    setDecalTex(endpoint, P[640], "rbxassetid://220114868", Enum.NormalId.Top)
end) end
if P[640] then task.spawn(function()
    createDecal(endpoint, P[640], Enum.NormalId.Back)
    setDecalTex(endpoint, P[640], "rbxassetid://220114868", Enum.NormalId.Back)
end) end
if P[647] then task.spawn(function()
    createDecal(endpoint, P[647], Enum.NormalId.Front)
    setDecalTex(endpoint, P[647], "rbxassetid://220114868", Enum.NormalId.Front)
end) end
if P[647] then task.spawn(function()
    createDecal(endpoint, P[647], Enum.NormalId.Back)
    setDecalTex(endpoint, P[647], "rbxassetid://220114868", Enum.NormalId.Back)
end) end
if P[647] then task.spawn(function()
    createDecal(endpoint, P[647], Enum.NormalId.Front)
    setDecalTex(endpoint, P[647], "rbxassetid://220114868", Enum.NormalId.Front)
end) end
if P[647] then task.spawn(function()
    createDecal(endpoint, P[647], Enum.NormalId.Bottom)
    setDecalTex(endpoint, P[647], "rbxassetid://220114868", Enum.NormalId.Bottom)
end) end
if P[647] then task.spawn(function()
    createDecal(endpoint, P[647], Enum.NormalId.Top)
    setDecalTex(endpoint, P[647], "rbxassetid://220114868", Enum.NormalId.Top)
end) end
if P[647] then task.spawn(function()
    createDecal(endpoint, P[647], Enum.NormalId.Right)
    setDecalTex(endpoint, P[647], "rbxassetid://220114868", Enum.NormalId.Right)
end) end
if P[656] then task.spawn(function()
    createDecal(endpoint, P[656], Enum.NormalId.Left)
    setDecalTex(endpoint, P[656], "rbxassetid://147149580", Enum.NormalId.Left)
    setDecalTr(endpoint, P[656], 0.800000011920929, Enum.NormalId.Left)
end) end
if P[656] then task.spawn(function()
    createDecal(endpoint, P[656], Enum.NormalId.Front)
    setDecalTex(endpoint, P[656], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[656], 0.800000011920929, Enum.NormalId.Front)
end) end
if P[656] then task.spawn(function()
    createDecal(endpoint, P[656], Enum.NormalId.Right)
    setDecalTex(endpoint, P[656], "rbxassetid://94153618", Enum.NormalId.Right)
    setDecalTr(endpoint, P[656], 0.20000000298023224, Enum.NormalId.Right)
end) end
if P[660] then task.spawn(function()
    createDecal(endpoint, P[660], Enum.NormalId.Front)
    setDecalTex(endpoint, P[660], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[660], 0.800000011920929, Enum.NormalId.Front)
end) end
if P[660] then task.spawn(function()
    createDecal(endpoint, P[660], Enum.NormalId.Right)
    setDecalTex(endpoint, P[660], "rbxassetid://147149580", Enum.NormalId.Right)
    setDecalTr(endpoint, P[660], 0.800000011920929, Enum.NormalId.Right)
end) end
if P[660] then task.spawn(function()
    createDecal(endpoint, P[660], Enum.NormalId.Left)
    setDecalTex(endpoint, P[660], "rbxassetid://94153618", Enum.NormalId.Left)
    setDecalTr(endpoint, P[660], 0.20000000298023224, Enum.NormalId.Left)
end) end
if P[664] then task.spawn(function()
    createDecal(endpoint, P[664], Enum.NormalId.Back)
    setDecalTex(endpoint, P[664], "rbxassetid://147149580", Enum.NormalId.Back)
    setDecalTr(endpoint, P[664], 0.699999988079071, Enum.NormalId.Back)
end) end
if P[666] then task.spawn(function()
    createDecal(endpoint, P[666], Enum.NormalId.Top)
    setDecalTex(endpoint, P[666], "rbxassetid://96554931", Enum.NormalId.Top)
end) end
if P[681] then task.spawn(function()
    createDecal(endpoint, P[681], Enum.NormalId.Front)
    setDecalTex(endpoint, P[681], "rbxassetid://35905357", Enum.NormalId.Front)
end) end
if P[681] then task.spawn(function()
    createDecal(endpoint, P[681], Enum.NormalId.Left)
    setDecalTex(endpoint, P[681], "rbxassetid://35905357", Enum.NormalId.Left)
end) end
if P[681] then task.spawn(function()
    createDecal(endpoint, P[681], Enum.NormalId.Back)
    setDecalTex(endpoint, P[681], "rbxassetid://35905357", Enum.NormalId.Back)
end) end
if P[685] then task.spawn(function()
    createDecal(endpoint, P[685], Enum.NormalId.Front)
    setDecalTex(endpoint, P[685], "rbxassetid://94153618", Enum.NormalId.Front)
    setDecalTr(endpoint, P[685], 0.20000000298023224, Enum.NormalId.Front)
end) end
if P[688] then task.spawn(function()
    createDecal(endpoint, P[688], Enum.NormalId.Front)
    setDecalTex(endpoint, P[688], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[688], 0.800000011920929, Enum.NormalId.Front)
end) end
if P[688] then task.spawn(function()
    createDecal(endpoint, P[688], Enum.NormalId.Right)
    setDecalTex(endpoint, P[688], "rbxassetid://147149580", Enum.NormalId.Right)
    setDecalTr(endpoint, P[688], 0.800000011920929, Enum.NormalId.Right)
end) end
if P[688] then task.spawn(function()
    createDecal(endpoint, P[688], Enum.NormalId.Left)
    setDecalTex(endpoint, P[688], "rbxassetid://147149580", Enum.NormalId.Left)
    setDecalTr(endpoint, P[688], 0.800000011920929, Enum.NormalId.Left)
end) end
if P[688] then task.spawn(function()
    createDecal(endpoint, P[688], Enum.NormalId.Back)
    setDecalTex(endpoint, P[688], "rbxassetid://147149580", Enum.NormalId.Back)
    setDecalTr(endpoint, P[688], 0.800000011920929, Enum.NormalId.Back)
end) end
if P[693] then task.spawn(function()
    createDecal(endpoint, P[693], Enum.NormalId.Left)
    setDecalTex(endpoint, P[693], "rbxassetid://35905357", Enum.NormalId.Left)
end) end
if P[693] then task.spawn(function()
    createDecal(endpoint, P[693], Enum.NormalId.Front)
    setDecalTex(endpoint, P[693], "rbxassetid://35905357", Enum.NormalId.Front)
end) end
if P[693] then task.spawn(function()
    createDecal(endpoint, P[693], Enum.NormalId.Back)
    setDecalTex(endpoint, P[693], "rbxassetid://35905357", Enum.NormalId.Back)
end) end
if P[698] then task.spawn(function()
    createDecal(endpoint, P[698], Enum.NormalId.Front)
    setDecalTex(endpoint, P[698], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[698], 0.800000011920929, Enum.NormalId.Front)
end) end
if P[698] then task.spawn(function()
    createDecal(endpoint, P[698], Enum.NormalId.Back)
    setDecalTex(endpoint, P[698], "rbxassetid://147149580", Enum.NormalId.Back)
    setDecalTr(endpoint, P[698], 0.800000011920929, Enum.NormalId.Back)
end) end
if P[698] then task.spawn(function()
    createDecal(endpoint, P[698], Enum.NormalId.Right)
    setDecalTex(endpoint, P[698], "rbxassetid://147149580", Enum.NormalId.Right)
    setDecalTr(endpoint, P[698], 0.800000011920929, Enum.NormalId.Right)
end) end
if P[698] then task.spawn(function()
    createDecal(endpoint, P[698], Enum.NormalId.Left)
    setDecalTex(endpoint, P[698], "rbxassetid://147149580", Enum.NormalId.Left)
    setDecalTr(endpoint, P[698], 0.800000011920929, Enum.NormalId.Left)
end) end
if P[705] then task.spawn(function()
    createDecal(endpoint, P[705], Enum.NormalId.Front)
    setDecalTex(endpoint, P[705], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[705], 0.800000011920929, Enum.NormalId.Front)
end) end
if P[705] then task.spawn(function()
    createDecal(endpoint, P[705], Enum.NormalId.Left)
    setDecalTex(endpoint, P[705], "rbxassetid://147149580", Enum.NormalId.Left)
    setDecalTr(endpoint, P[705], 0.800000011920929, Enum.NormalId.Left)
end) end
if P[705] then task.spawn(function()
    createDecal(endpoint, P[705], Enum.NormalId.Right)
    setDecalTex(endpoint, P[705], "rbxassetid://94153618", Enum.NormalId.Right)
    setDecalTr(endpoint, P[705], 0.20000000298023224, Enum.NormalId.Right)
end) end
if P[705] then task.spawn(function()
    createDecal(endpoint, P[705], Enum.NormalId.Front)
    setDecalTex(endpoint, P[705], "rbxassetid://94153618", Enum.NormalId.Front)
    setDecalTr(endpoint, P[705], 0.20000000298023224, Enum.NormalId.Front)
end) end
if P[710] then task.spawn(function()
    createDecal(endpoint, P[710], Enum.NormalId.Back)
    setDecalTex(endpoint, P[710], "rbxassetid://55420352", Enum.NormalId.Back)
end) end
if P[712] then task.spawn(function()
    createDecal(endpoint, P[712], Enum.NormalId.Front)
    setDecalTex(endpoint, P[712], "rbxassetid://94153618", Enum.NormalId.Front)
    setDecalTr(endpoint, P[712], 0.20000000298023224, Enum.NormalId.Front)
end) end
if P[715] then task.spawn(function()
    createDecal(endpoint, P[715], Enum.NormalId.Front)
    setDecalTex(endpoint, P[715], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[715], 0.800000011920929, Enum.NormalId.Front)
end) end
if P[715] then task.spawn(function()
    createDecal(endpoint, P[715], Enum.NormalId.Left)
    setDecalTex(endpoint, P[715], "rbxassetid://147149580", Enum.NormalId.Left)
    setDecalTr(endpoint, P[715], 0.800000011920929, Enum.NormalId.Left)
end) end
if P[715] then task.spawn(function()
    createDecal(endpoint, P[715], Enum.NormalId.Right)
    setDecalTex(endpoint, P[715], "rbxassetid://94153618", Enum.NormalId.Right)
    setDecalTr(endpoint, P[715], 0.20000000298023224, Enum.NormalId.Right)
end) end
if P[715] then task.spawn(function()
    createDecal(endpoint, P[715], Enum.NormalId.Front)
    setDecalTex(endpoint, P[715], "rbxassetid://94153618", Enum.NormalId.Front)
    setDecalTr(endpoint, P[715], 0.20000000298023224, Enum.NormalId.Front)
end) end
if P[722] then task.spawn(function()
    createDecal(endpoint, P[722], Enum.NormalId.Top)
    setDecalTex(endpoint, P[722], "rbxassetid://0", Enum.NormalId.Top)
    setDecalTr(endpoint, P[722], 0.5, Enum.NormalId.Top)
end) end
if P[748] then task.spawn(function()
    createDecal(endpoint, P[748], Enum.NormalId.Back)
    setDecalTex(endpoint, P[748], "rbxassetid://35905357", Enum.NormalId.Back)
end) end
if P[748] then task.spawn(function()
    createDecal(endpoint, P[748], Enum.NormalId.Left)
    setDecalTex(endpoint, P[748], "rbxassetid://35905357", Enum.NormalId.Left)
end) end
if P[748] then task.spawn(function()
    createDecal(endpoint, P[748], Enum.NormalId.Front)
    setDecalTex(endpoint, P[748], "rbxassetid://35905357", Enum.NormalId.Front)
end) end
if P[753] then task.spawn(function()
    createDecal(endpoint, P[753], Enum.NormalId.Front)
    setDecalTex(endpoint, P[753], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[753], 0.699999988079071, Enum.NormalId.Front)
end) end
if P[753] then task.spawn(function()
    createDecal(endpoint, P[753], Enum.NormalId.Back)
    setDecalTex(endpoint, P[753], "rbxassetid://147149580", Enum.NormalId.Back)
    setDecalTr(endpoint, P[753], 0.699999988079071, Enum.NormalId.Back)
end) end
if P[756] then task.spawn(function()
    createDecal(endpoint, P[756], Enum.NormalId.Top)
    setDecalTex(endpoint, P[756], "rbxassetid://147149580", Enum.NormalId.Top)
    setDecalTr(endpoint, P[756], 0.5, Enum.NormalId.Top)
end) end
if P[756] then task.spawn(function()
    createDecal(endpoint, P[756], Enum.NormalId.Top)
    setDecalTex(endpoint, P[756], "rbxassetid://18658531", Enum.NormalId.Top)
end) end
if P[756] then task.spawn(function()
    createDecal(endpoint, P[756], Enum.NormalId.Front)
    setDecalTex(endpoint, P[756], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[756], 0.699999988079071, Enum.NormalId.Front)
end) end
if P[760] then task.spawn(function()
    createDecal(endpoint, P[760], Enum.NormalId.Front)
    setDecalTex(endpoint, P[760], "rbxassetid://94153618", Enum.NormalId.Front)
    setDecalTr(endpoint, P[760], 0.20000000298023224, Enum.NormalId.Front)
end) end
if P[762] then task.spawn(function()
    createDecal(endpoint, P[762], Enum.NormalId.Top)
    setDecalTex(endpoint, P[762], "rbxassetid://96554931", Enum.NormalId.Top)
end) end
if P[764] then task.spawn(function()
    createDecal(endpoint, P[764], Enum.NormalId.Front)
    setDecalTex(endpoint, P[764], "rbxassetid://94153618", Enum.NormalId.Front)
    setDecalTr(endpoint, P[764], 0.20000000298023224, Enum.NormalId.Front)
end) end
if P[769] then task.spawn(function()
    createDecal(endpoint, P[769], Enum.NormalId.Front)
    setDecalTex(endpoint, P[769], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[769], 0.800000011920929, Enum.NormalId.Front)
end) end
if P[769] then task.spawn(function()
    createDecal(endpoint, P[769], Enum.NormalId.Right)
    setDecalTex(endpoint, P[769], "rbxassetid://147149580", Enum.NormalId.Right)
    setDecalTr(endpoint, P[769], 0.800000011920929, Enum.NormalId.Right)
end) end
if P[769] then task.spawn(function()
    createDecal(endpoint, P[769], Enum.NormalId.Left)
    setDecalTex(endpoint, P[769], "rbxassetid://147149580", Enum.NormalId.Left)
    setDecalTr(endpoint, P[769], 0.800000011920929, Enum.NormalId.Left)
end) end
if P[782] then task.spawn(function()
    createDecal(endpoint, P[782], Enum.NormalId.Left)
    setDecalTex(endpoint, P[782], "rbxassetid://35905357", Enum.NormalId.Left)
end) end
if P[782] then task.spawn(function()
    createDecal(endpoint, P[782], Enum.NormalId.Front)
    setDecalTex(endpoint, P[782], "rbxassetid://35905357", Enum.NormalId.Front)
end) end
if P[782] then task.spawn(function()
    createDecal(endpoint, P[782], Enum.NormalId.Back)
    setDecalTex(endpoint, P[782], "rbxassetid://35905357", Enum.NormalId.Back)
end) end
if P[791] then task.spawn(function()
    createDecal(endpoint, P[791], Enum.NormalId.Left)
    setDecalTex(endpoint, P[791], "rbxassetid://147149580", Enum.NormalId.Left)
    setDecalTr(endpoint, P[791], 0.800000011920929, Enum.NormalId.Left)
end) end
if P[791] then task.spawn(function()
    createDecal(endpoint, P[791], Enum.NormalId.Right)
    setDecalTex(endpoint, P[791], "rbxassetid://147149580", Enum.NormalId.Right)
    setDecalTr(endpoint, P[791], 0.800000011920929, Enum.NormalId.Right)
end) end
if P[791] then task.spawn(function()
    createDecal(endpoint, P[791], Enum.NormalId.Front)
    setDecalTex(endpoint, P[791], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[791], 0.800000011920929, Enum.NormalId.Front)
end) end
if P[795] then task.spawn(function()
    createDecal(endpoint, P[795], Enum.NormalId.Front)
    setDecalTex(endpoint, P[795], "rbxassetid://35905357", Enum.NormalId.Front)
end) end
if P[795] then task.spawn(function()
    createDecal(endpoint, P[795], Enum.NormalId.Left)
    setDecalTex(endpoint, P[795], "rbxassetid://35905357", Enum.NormalId.Left)
end) end
if P[795] then task.spawn(function()
    createDecal(endpoint, P[795], Enum.NormalId.Back)
    setDecalTex(endpoint, P[795], "rbxassetid://35905357", Enum.NormalId.Back)
end) end
if P[799] then task.spawn(function()
    createDecal(endpoint, P[799], Enum.NormalId.Back)
    setDecalTex(endpoint, P[799], "rbxassetid://147149580", Enum.NormalId.Back)
    setDecalTr(endpoint, P[799], 0.699999988079071, Enum.NormalId.Back)
end) end
if P[799] then task.spawn(function()
    createDecal(endpoint, P[799], Enum.NormalId.Front)
    setDecalTex(endpoint, P[799], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[799], 0.699999988079071, Enum.NormalId.Front)
end) end
if P[804] then task.spawn(function()
    createDecal(endpoint, P[804], Enum.NormalId.Back)
    setDecalTex(endpoint, P[804], "rbxassetid://147149580", Enum.NormalId.Back)
    setDecalTr(endpoint, P[804], 0.699999988079071, Enum.NormalId.Back)
end) end
if P[815] then task.spawn(function()
    createDecal(endpoint, P[815], Enum.NormalId.Back)
    setDecalTex(endpoint, P[815], "rbxassetid://2752483", Enum.NormalId.Back)
end) end
if P[819] then task.spawn(function()
    createDecal(endpoint, P[819], Enum.NormalId.Back)
    setDecalTex(endpoint, P[819], "rbxassetid://0", Enum.NormalId.Back)
    setDecalTr(endpoint, P[819], 0.5, Enum.NormalId.Back)
end) end
if P[823] then task.spawn(function()
    createDecal(endpoint, P[823], Enum.NormalId.Back)
    setDecalTex(endpoint, P[823], "rbxassetid://0", Enum.NormalId.Back)
    setDecalTr(endpoint, P[823], 0.5, Enum.NormalId.Back)
end) end
if P[825] then task.spawn(function()
    createDecal(endpoint, P[825], Enum.NormalId.Top)
    setDecalTex(endpoint, P[825], "rbxassetid://55420352", Enum.NormalId.Top)
    setDecalTr(endpoint, P[825], 0.5, Enum.NormalId.Top)
end) end
if P[830] then task.spawn(function()
    createDecal(endpoint, P[830], Enum.NormalId.Back)
    setDecalTex(endpoint, P[830], "rbxassetid://147149580", Enum.NormalId.Back)
    setDecalTr(endpoint, P[830], 0.800000011920929, Enum.NormalId.Back)
end) end
if P[830] then task.spawn(function()
    createDecal(endpoint, P[830], Enum.NormalId.Front)
    setDecalTex(endpoint, P[830], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[830], 0.800000011920929, Enum.NormalId.Front)
end) end
if P[834] then task.spawn(function()
    createDecal(endpoint, P[834], Enum.NormalId.Front)
    setDecalTex(endpoint, P[834], "rbxassetid://94153618", Enum.NormalId.Front)
    setDecalTr(endpoint, P[834], 0.20000000298023224, Enum.NormalId.Front)
end) end
if P[836] then task.spawn(function()
    createDecal(endpoint, P[836], Enum.NormalId.Front)
    setDecalTex(endpoint, P[836], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[836], 0.800000011920929, Enum.NormalId.Front)
end) end
if P[836] then task.spawn(function()
    createDecal(endpoint, P[836], Enum.NormalId.Left)
    setDecalTex(endpoint, P[836], "rbxassetid://147149580", Enum.NormalId.Left)
    setDecalTr(endpoint, P[836], 0.800000011920929, Enum.NormalId.Left)
end) end
if P[836] then task.spawn(function()
    createDecal(endpoint, P[836], Enum.NormalId.Right)
    setDecalTex(endpoint, P[836], "rbxassetid://94153618", Enum.NormalId.Right)
    setDecalTr(endpoint, P[836], 0.20000000298023224, Enum.NormalId.Right)
end) end
if P[836] then task.spawn(function()
    createDecal(endpoint, P[836], Enum.NormalId.Front)
    setDecalTex(endpoint, P[836], "rbxassetid://94153618", Enum.NormalId.Front)
    setDecalTr(endpoint, P[836], 0.20000000298023224, Enum.NormalId.Front)
end) end
if P[841] then task.spawn(function()
    createDecal(endpoint, P[841], Enum.NormalId.Front)
    setDecalTex(endpoint, P[841], "rbxassetid://94153618", Enum.NormalId.Front)
    setDecalTr(endpoint, P[841], 0.20000000298023224, Enum.NormalId.Front)
end) end
if P[845] then task.spawn(function()
    createDecal(endpoint, P[845], Enum.NormalId.Back)
    setDecalTex(endpoint, P[845], "rbxassetid://0", Enum.NormalId.Back)
    setDecalTr(endpoint, P[845], 0.5, Enum.NormalId.Back)
end) end
if P[848] then task.spawn(function()
    createDecal(endpoint, P[848], Enum.NormalId.Back)
    setDecalTex(endpoint, P[848], "rbxassetid://0", Enum.NormalId.Back)
    setDecalTr(endpoint, P[848], 0.5, Enum.NormalId.Back)
end) end
if P[859] then task.spawn(function()
    createDecal(endpoint, P[859], Enum.NormalId.Front)
    setDecalTex(endpoint, P[859], "rbxassetid://94153618", Enum.NormalId.Front)
    setDecalTr(endpoint, P[859], 0.20000000298023224, Enum.NormalId.Front)
end) end
if P[859] then task.spawn(function()
    createDecal(endpoint, P[859], Enum.NormalId.Left)
    setDecalTex(endpoint, P[859], "rbxassetid://94153618", Enum.NormalId.Left)
    setDecalTr(endpoint, P[859], 0.20000000298023224, Enum.NormalId.Left)
end) end
if P[862] then task.spawn(function()
    createDecal(endpoint, P[862], Enum.NormalId.Back)
    setDecalTex(endpoint, P[862], "rbxassetid://2752483", Enum.NormalId.Back)
end) end
if P[872] then task.spawn(function()
    createDecal(endpoint, P[872], Enum.NormalId.Left)
    setDecalTex(endpoint, P[872], "rbxassetid://147149580", Enum.NormalId.Left)
    setDecalTr(endpoint, P[872], 0.800000011920929, Enum.NormalId.Left)
end) end
if P[872] then task.spawn(function()
    createDecal(endpoint, P[872], Enum.NormalId.Front)
    setDecalTex(endpoint, P[872], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[872], 0.800000011920929, Enum.NormalId.Front)
end) end
if P[877] then task.spawn(function()
    createDecal(endpoint, P[877], Enum.NormalId.Left)
    setDecalTex(endpoint, P[877], "rbxassetid://147149580", Enum.NormalId.Left)
    setDecalTr(endpoint, P[877], 0.800000011920929, Enum.NormalId.Left)
end) end
if P[877] then task.spawn(function()
    createDecal(endpoint, P[877], Enum.NormalId.Front)
    setDecalTex(endpoint, P[877], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[877], 0.800000011920929, Enum.NormalId.Front)
end) end
if P[877] then task.spawn(function()
    createDecal(endpoint, P[877], Enum.NormalId.Right)
    setDecalTex(endpoint, P[877], "rbxassetid://147149580", Enum.NormalId.Right)
    setDecalTr(endpoint, P[877], 0.800000011920929, Enum.NormalId.Right)
end) end
if P[877] then task.spawn(function()
    createDecal(endpoint, P[877], Enum.NormalId.Back)
    setDecalTex(endpoint, P[877], "rbxassetid://147149580", Enum.NormalId.Back)
    setDecalTr(endpoint, P[877], 0.800000011920929, Enum.NormalId.Back)
end) end
if P[882] then task.spawn(function()
    createDecal(endpoint, P[882], Enum.NormalId.Front)
    setDecalTex(endpoint, P[882], "rbxassetid://94153618", Enum.NormalId.Front)
    setDecalTr(endpoint, P[882], 0.20000000298023224, Enum.NormalId.Front)
end) end
if P[909] then task.spawn(function()
    createDecal(endpoint, P[909], Enum.NormalId.Front)
    setDecalTex(endpoint, P[909], "rbxassetid://147149580", Enum.NormalId.Front)
    setDecalTr(endpoint, P[909], 0.8999999761581421, Enum.NormalId.Front)
end) end
if P[911] then task.spawn(function()
    createDecal(endpoint, P[911], Enum.NormalId.Top)
    setDecalTex(endpoint, P[911], "rbxassetid://4753420342", Enum.NormalId.Top)
    setDecalTr(endpoint, P[911], 0.5, Enum.NormalId.Top)
end) end
if P[913] then task.spawn(function()
    createDecal(endpoint, P[913], Enum.NormalId.Left)
    setDecalTex(endpoint, P[913], "rbxassetid://147149580", Enum.NormalId.Left)
    setDecalTr(endpoint, P[913], 0.8999999761581421, Enum.NormalId.Left)
end) end
if P[916] then task.spawn(function()
    createDecal(endpoint, P[916], Enum.NormalId.Front)
    setDecalTex(endpoint, P[916], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[918] then task.spawn(function()
    createDecal(endpoint, P[918], Enum.NormalId.Back)
    setDecalTex(endpoint, P[918], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[920] then task.spawn(function()
    createDecal(endpoint, P[920], Enum.NormalId.Back)
    setDecalTex(endpoint, P[920], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[922] then task.spawn(function()
    createDecal(endpoint, P[922], Enum.NormalId.Back)
    setDecalTex(endpoint, P[922], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[924] then task.spawn(function()
    createDecal(endpoint, P[924], Enum.NormalId.Front)
    setDecalTex(endpoint, P[924], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[926] then task.spawn(function()
    createDecal(endpoint, P[926], Enum.NormalId.Front)
    setDecalTex(endpoint, P[926], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[928] then task.spawn(function()
    createDecal(endpoint, P[928], Enum.NormalId.Back)
    setDecalTex(endpoint, P[928], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[930] then task.spawn(function()
    createDecal(endpoint, P[930], Enum.NormalId.Front)
    setDecalTex(endpoint, P[930], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[932] then task.spawn(function()
    createDecal(endpoint, P[932], Enum.NormalId.Back)
    setDecalTex(endpoint, P[932], "rbxassetid://147149580", Enum.NormalId.Back)
    setDecalTr(endpoint, P[932], 0.8999999761581421, Enum.NormalId.Back)
end) end
if P[935] then task.spawn(function()
    createDecal(endpoint, P[935], Enum.NormalId.Front)
    setDecalTex(endpoint, P[935], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[937] then task.spawn(function()
    createDecal(endpoint, P[937], Enum.NormalId.Back)
    setDecalTex(endpoint, P[937], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[939] then task.spawn(function()
    createDecal(endpoint, P[939], Enum.NormalId.Back)
    setDecalTex(endpoint, P[939], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[941] then task.spawn(function()
    createDecal(endpoint, P[941], Enum.NormalId.Front)
    setDecalTex(endpoint, P[941], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[943] then task.spawn(function()
    createDecal(endpoint, P[943], Enum.NormalId.Back)
    setDecalTex(endpoint, P[943], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[945] then task.spawn(function()
    createDecal(endpoint, P[945], Enum.NormalId.Front)
    setDecalTex(endpoint, P[945], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[947] then task.spawn(function()
    createDecal(endpoint, P[947], Enum.NormalId.Back)
    setDecalTex(endpoint, P[947], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[949] then task.spawn(function()
    createDecal(endpoint, P[949], Enum.NormalId.Front)
    setDecalTex(endpoint, P[949], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[951] then task.spawn(function()
    createDecal(endpoint, P[951], Enum.NormalId.Right)
    setDecalTex(endpoint, P[951], "rbxassetid://147149580", Enum.NormalId.Right)
    setDecalTr(endpoint, P[951], 0.8999999761581421, Enum.NormalId.Right)
end) end
if P[954] then task.spawn(function()
    createDecal(endpoint, P[954], Enum.NormalId.Front)
    setDecalTex(endpoint, P[954], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[956] then task.spawn(function()
    createDecal(endpoint, P[956], Enum.NormalId.Back)
    setDecalTex(endpoint, P[956], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[958] then task.spawn(function()
    createDecal(endpoint, P[958], Enum.NormalId.Front)
    setDecalTex(endpoint, P[958], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[960] then task.spawn(function()
    createDecal(endpoint, P[960], Enum.NormalId.Front)
    setDecalTex(endpoint, P[960], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[962] then task.spawn(function()
    createDecal(endpoint, P[962], Enum.NormalId.Back)
    setDecalTex(endpoint, P[962], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[964] then task.spawn(function()
    createDecal(endpoint, P[964], Enum.NormalId.Front)
    setDecalTex(endpoint, P[964], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[966] then task.spawn(function()
    createDecal(endpoint, P[966], Enum.NormalId.Back)
    setDecalTex(endpoint, P[966], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[968] then task.spawn(function()
    createDecal(endpoint, P[968], Enum.NormalId.Back)
    setDecalTex(endpoint, P[968], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[971] then task.spawn(function()
    createDecal(endpoint, P[971], Enum.NormalId.Front)
    setDecalTex(endpoint, P[971], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[973] then task.spawn(function()
    createDecal(endpoint, P[973], Enum.NormalId.Back)
    setDecalTex(endpoint, P[973], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[975] then task.spawn(function()
    createDecal(endpoint, P[975], Enum.NormalId.Back)
    setDecalTex(endpoint, P[975], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[977] then task.spawn(function()
    createDecal(endpoint, P[977], Enum.NormalId.Front)
    setDecalTex(endpoint, P[977], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[979] then task.spawn(function()
    createDecal(endpoint, P[979], Enum.NormalId.Front)
    setDecalTex(endpoint, P[979], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[981] then task.spawn(function()
    createDecal(endpoint, P[981], Enum.NormalId.Front)
    setDecalTex(endpoint, P[981], "rbxassetid://3992651233", Enum.NormalId.Front)
end) end
if P[983] then task.spawn(function()
    createDecal(endpoint, P[983], Enum.NormalId.Back)
    setDecalTex(endpoint, P[983], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[985] then task.spawn(function()
    createDecal(endpoint, P[985], Enum.NormalId.Back)
    setDecalTex(endpoint, P[985], "rbxassetid://3992651233", Enum.NormalId.Back)
end) end
if P[987] then task.spawn(function()
    createDecal(endpoint, P[987], Enum.NormalId.Top)
    setDecalTex(endpoint, P[987], "rbxassetid://321235183", Enum.NormalId.Top)
end) end
if P[1099] then task.spawn(function()
    createDecal(endpoint, P[1099], Enum.NormalId.Front)
    setDecalTex(endpoint, P[1099], "rbxassetid://220114868", Enum.NormalId.Front)
end) end
if P[1099] then task.spawn(function()
    createDecal(endpoint, P[1099], Enum.NormalId.Back)
    setDecalTex(endpoint, P[1099], "rbxassetid://220114868", Enum.NormalId.Back)
end) end
if P[1099] then task.spawn(function()
    createDecal(endpoint, P[1099], Enum.NormalId.Left)
    setDecalTex(endpoint, P[1099], "rbxassetid://220114868", Enum.NormalId.Left)
end) end
if P[1099] then task.spawn(function()
    createDecal(endpoint, P[1099], Enum.NormalId.Top)
    setDecalTex(endpoint, P[1099], "rbxassetid://220114868", Enum.NormalId.Top)
end) end
if P[1099] then task.spawn(function()
    createDecal(endpoint, P[1099], Enum.NormalId.Front)
    setDecalTex(endpoint, P[1099], "rbxassetid://220114868", Enum.NormalId.Front)
end) end
if P[1099] then task.spawn(function()
    createDecal(endpoint, P[1099], Enum.NormalId.Bottom)
    setDecalTex(endpoint, P[1099], "rbxassetid://220114868", Enum.NormalId.Bottom)
end) end
if P[1141] then task.spawn(function()
    createDecal(endpoint, P[1141], Enum.NormalId.Left)
    setDecalTex(endpoint, P[1141], "rbxthumb://type=Asset&id=120833786279619&w=420&h=420", Enum.NormalId.Left)
end) end
if P[1208] then task.spawn(function()
    createDecal(endpoint, P[1208], Enum.NormalId.Left)
    setDecalTex(endpoint, P[1208], "rbxassetid://0", Enum.NormalId.Left)
    setDecalTr(endpoint, P[1208], 0.5, Enum.NormalId.Left)
end) end
if P[1220] then task.spawn(function()
    createDecal(endpoint, P[1220], Enum.NormalId.Right)
    setDecalTex(endpoint, P[1220], "rbxassetid://1469219653", Enum.NormalId.Right)
    setDecalTr(endpoint, P[1220], 0.20000000298023224, Enum.NormalId.Right)
end) end
if P[1220] then task.spawn(function()
    createDecal(endpoint, P[1220], Enum.NormalId.Left)
    setDecalTex(endpoint, P[1220], "rbxassetid://126939754", Enum.NormalId.Left)
    setDecalTr(endpoint, P[1220], 0.5, Enum.NormalId.Left)
end) end
if P[1223] then task.spawn(function()
    createDecal(endpoint, P[1223], Enum.NormalId.Left)
    setDecalTex(endpoint, P[1223], "rbxassetid://43479241", Enum.NormalId.Left)
    setDecalTr(endpoint, P[1223], 0.800000011920929, Enum.NormalId.Left)
end) end
if P[1225] then task.spawn(function()
    createDecal(endpoint, P[1225], Enum.NormalId.Left)
    setDecalTex(endpoint, P[1225], "rbxthumb://type=Asset&id=81335862348761&w=420&h=420", Enum.NormalId.Left)
end) end
if P[1232] then task.spawn(function()
    createDecal(endpoint, P[1232], Enum.NormalId.Left)
    setDecalTex(endpoint, P[1232], "rbxassetid://0", Enum.NormalId.Left)
    setDecalTr(endpoint, P[1232], 0.5, Enum.NormalId.Left)
end) end
if P[1315] then task.spawn(function()
    createDecal(endpoint, P[1315], Enum.NormalId.Left)
    setDecalTex(endpoint, P[1315], "rbxassetid://43479241", Enum.NormalId.Left)
    setDecalTr(endpoint, P[1315], 0.800000011920929, Enum.NormalId.Left)
end) end
if P[1317] then task.spawn(function()
    createDecal(endpoint, P[1317], Enum.NormalId.Bottom)
    setDecalTex(endpoint, P[1317], "rbxassetid://4012608266", Enum.NormalId.Bottom)
end) end
if P[1317] then task.spawn(function()
    createDecal(endpoint, P[1317], Enum.NormalId.Back)
    setDecalTex(endpoint, P[1317], "rbxassetid://356104726", Enum.NormalId.Back)
    setDecalTr(endpoint, P[1317], 0.20000000298023224, Enum.NormalId.Back)
end) end
if P[1317] then task.spawn(function()
    createDecal(endpoint, P[1317], Enum.NormalId.Front)
    setDecalTex(endpoint, P[1317], "rbxassetid://356104726", Enum.NormalId.Front)
    setDecalTr(endpoint, P[1317], 0.20000000298023224, Enum.NormalId.Front)
end) end
if P[1317] then task.spawn(function()
    createDecal(endpoint, P[1317], Enum.NormalId.Left)
    setDecalTex(endpoint, P[1317], "rbxassetid://356104726", Enum.NormalId.Left)
    setDecalTr(endpoint, P[1317], 0.20000000298023224, Enum.NormalId.Left)
end) end
if P[1317] then task.spawn(function()
    createDecal(endpoint, P[1317], Enum.NormalId.Top)
    setDecalTex(endpoint, P[1317], "rbxassetid://356104726", Enum.NormalId.Top)
    setDecalTr(endpoint, P[1317], 0.20000000298023224, Enum.NormalId.Top)
end) end
if P[1317] then task.spawn(function()
    createDecal(endpoint, P[1317], Enum.NormalId.Right)
    setDecalTex(endpoint, P[1317], "rbxassetid://356104726", Enum.NormalId.Right)
    setDecalTr(endpoint, P[1317], 0.20000000298023224, Enum.NormalId.Right)
end) end
if P[1326] then task.spawn(function()
    createDecal(endpoint, P[1326], Enum.NormalId.Front)
    setDecalTex(endpoint, P[1326], "rbxthumb://type=Asset&id=106394355967874&w=420&h=420", Enum.NormalId.Front)
end) end
if P[1331] then task.spawn(function()
    createDecal(endpoint, P[1331], Enum.NormalId.Top)
    setDecalTex(endpoint, P[1331], "rbxasset://textures/SpawnLocation.png", Enum.NormalId.Top)
end) end
task.wait(0.3)
if P[196] then task.spawn(function()
    createLight(endpoint, P[196], "PointLight")
    syncLight(endpoint, P[196], "PointLight", 1, 8, Color3.new(1,1,1), false, nil, 90)
end) end
if P[530] then task.spawn(function()
    createLight(endpoint, P[530], "SurfaceLight")
    syncLight(endpoint, P[530], "SurfaceLight", 1, 16, Color3.new(0,1,0.9686274528503418), false, Enum.NormalId.Top, 90)
end) end
if P[670] then task.spawn(function()
    createLight(endpoint, P[670], "SurfaceLight")
    syncLight(endpoint, P[670], "SurfaceLight", 1, 12, Color3.new(0,0.09803921729326248,1), false, Enum.NormalId.Bottom, 90)
end) end
if P[886] then task.spawn(function()
    createLight(endpoint, P[886], "SpotLight")
    syncLight(endpoint, P[886], "SpotLight", 1, 21, Color3.new(1,0.9137254953384399,0.5960784554481506), true, nil, 160)
end) end
if P[888] then task.spawn(function()
    createLight(endpoint, P[888], "SpotLight")
    syncLight(endpoint, P[888], "SpotLight", 1, 21, Color3.new(1,0.9137254953384399,0.5960784554481506), true, nil, 160)
end) end
if P[890] then task.spawn(function()
    createLight(endpoint, P[890], "SpotLight")
    syncLight(endpoint, P[890], "SpotLight", 1, 21, Color3.new(1,0.9137254953384399,0.5960784554481506), true, nil, 160)
end) end
if P[892] then task.spawn(function()
    createLight(endpoint, P[892], "SpotLight")
    syncLight(endpoint, P[892], "SpotLight", 1, 21, Color3.new(1,0.9137254953384399,0.5960784554481506), true, nil, 160)
end) end
if P[894] then task.spawn(function()
    createLight(endpoint, P[894], "SpotLight")
    syncLight(endpoint, P[894], "SpotLight", 1, 21, Color3.new(1,0.9137254953384399,0.5960784554481506), true, nil, 160)
end) end
if P[896] then task.spawn(function()
    createLight(endpoint, P[896], "SpotLight")
    syncLight(endpoint, P[896], "SpotLight", 1, 21, Color3.new(1,0.9137254953384399,0.5960784554481506), true, nil, 160)
end) end
if P[898] then task.spawn(function()
    createLight(endpoint, P[898], "SpotLight")
    syncLight(endpoint, P[898], "SpotLight", 1, 21, Color3.new(1,0.9137254953384399,0.5960784554481506), true, nil, 160)
end) end
if P[900] then task.spawn(function()
    createLight(endpoint, P[900], "SpotLight")
    syncLight(endpoint, P[900], "SpotLight", 1, 21, Color3.new(1,0.9137254953384399,0.5960784554481506), true, nil, 160)
end) end
if P[902] then task.spawn(function()
    createLight(endpoint, P[902], "SpotLight")
    syncLight(endpoint, P[902], "SpotLight", 1, 21, Color3.new(1,0.9137254953384399,0.5960784554481506), true, nil, 160)
end) end
if P[904] then task.spawn(function()
    createLight(endpoint, P[904], "SpotLight")
    syncLight(endpoint, P[904], "SpotLight", 1, 21, Color3.new(1,0.9137254953384399,0.5960784554481506), true, nil, 160)
end) end
if P[906] then task.spawn(function()
    createLight(endpoint, P[906], "SpotLight")
    syncLight(endpoint, P[906], "SpotLight", 1, 21, Color3.new(1,0.9137254953384399,0.5960784554481506), true, nil, 160)
end) end
if P[1230] then task.spawn(function()
    createLight(endpoint, P[1230], "SurfaceLight")
    syncLight(endpoint, P[1230], "SurfaceLight", 1, 16, Color3.new(0,1,0.9686274528503418), false, Enum.NormalId.Top, 90)
end) end
task.wait(0.3)
local G = {}
task.spawn(function()
    G[1251] = createGroup(endpoint, "Model", workspace, {1252,1253,1263,1265})
    setName(endpoint, G[1251], "Chair")
end)
task.spawn(function()
    G[672] = createGroup(endpoint, "Model", workspace, {673,674,675,676,677,678,679})
    setName(endpoint, G[672], "Model3")
end)
task.spawn(function()
    G[195] = createGroup(endpoint, "Model", workspace, {196,200,202})
    setName(endpoint, G[195], "Model2")
end)
task.spawn(function()
    G[494] = createGroup(endpoint, "Model", workspace, {495,496,506,508})
    setName(endpoint, G[494], "Chair")
end)
task.spawn(function()
    G[577] = createGroup(endpoint, "Model", workspace, {578,580,582,584,586,588,590,592})
    setName(endpoint, G[577], "Model4")
end)
task.spawn(function()
    G[1033] = createGroup(endpoint, "Model", workspace, {1034,1040})
    setName(endpoint, G[1033], "Armchair")
end)
task.spawn(function()
    G[5] = createGroup(endpoint, "Model", workspace, {6,9,16,32,34,37})
    setName(endpoint, G[5], "R6n_Lovelivniixx")
end)
task.spawn(function()
    G[843] = createGroup(endpoint, "Model", workspace, {844,845,847,848})
    setName(endpoint, G[843], "Model4")
end)
task.spawn(function()
    G[509] = createGroup(endpoint, "Model", workspace, {510,511,512})
end)
task.spawn(function()
    G[162] = createGroup(endpoint, "Model", workspace, {163,167,171,175})
    setName(endpoint, G[162], "Wheels")
end)
task.spawn(function()
    G[1189] = createGroup(endpoint, "Model", workspace, {1190,1191,1201,1203})
    setName(endpoint, G[1189], "Chair")
end)
task.spawn(function()
    G[1311] = createGroup(endpoint, "Model", workspace, {1312,1313,1314})
end)
task.spawn(function()
    G[1296] = createGroup(endpoint, "Model", workspace, {1297,1298,1308,1310})
    setName(endpoint, G[1296], "Chair")
end)
task.spawn(function()
    G[999] = createGroup(endpoint, "Model", workspace, {1000,1001,1011,1013})
    setName(endpoint, G[999], "Chair")
end)
task.spawn(function()
    G[727] = createGroup(endpoint, "Model", workspace, {728,729,730,731,732,733,734,735,736,737,738,739,740,741,742,743,744,745,746,747})
end)
task.spawn(function()
    G[594] = createGroup(endpoint, "Model", workspace, {595,597,599,601,603,605,607,609})
    setName(endpoint, G[594], "Model2")
end)
task.spawn(function()
    G[989] = createGroup(endpoint, "Model", workspace, {990,991,992,993,994,995,996,997})
    setName(endpoint, G[989], "Model9")
end)
task.spawn(function()
    G[1266] = createGroup(endpoint, "Model", workspace, {1267,1268,1278,1280})
    setName(endpoint, G[1266], "Chair")
end)
task.spawn(function()
    G[654] = createGroup(endpoint, "Model", workspace, {655,656,660,664,666,668,669,670,680,681,685,687,688,693,697,698,703,704,705,710,712,714,715,720,721,722,724,725,726,748,752,753,756,760,762,764,766,767,768,769,773,774,775,776,777,778,779,780,781,782,786,787,788,789,790,791,795,799,802,803,804,814,815,817,825,827,828,829,830,833,834,836,841,850,859,862,872,875,876,877,882,884})
    setName(endpoint, G[654], "Cafe")
end)
task.spawn(function()
    G[1241] = createGroup(endpoint, "Model", workspace, {1242,1248})
    setName(endpoint, G[1241], "Armchair")
end)
task.spawn(function()
    G[851] = createGroup(endpoint, "Model", workspace, {852,853,854,855,856,857,858})
    setName(endpoint, G[851], "Model6")
end)
task.spawn(function()
    G[1075] = createGroup(endpoint, "Model", workspace, {1076,1077,1078})
end)
task.spawn(function()
    G[915] = createGroup(endpoint, "Model", workspace, {916,918,920,922,924,926,928,930})
    setName(endpoint, G[915], "Model3")
end)
task.spawn(function()
    G[1281] = createGroup(endpoint, "Model", workspace, {1282,1283,1293,1295})
    setName(endpoint, G[1281], "Chair")
end)
task.spawn(function()
    G[1174] = createGroup(endpoint, "Model", workspace, {1175,1176,1186,1188})
    setName(endpoint, G[1174], "Chair")
end)
task.spawn(function()
    G[1159] = createGroup(endpoint, "Model", workspace, {1160,1161,1171,1173})
    setName(endpoint, G[1159], "Chair")
end)
task.spawn(function()
    G[1204] = createGroup(endpoint, "Model", workspace, {1205,1206,1207})
end)
task.spawn(function()
    G[211] = createGroup(endpoint, "Model", workspace, {227,242,245,248,261,264,266})
    setName(endpoint, G[211], "SmileCatQuikScope")
end)
task.spawn(function()
    G[934] = createGroup(endpoint, "Model", workspace, {935,937,939,941,943,945,947,949})
end)
task.spawn(function()
    G[1126] = createGroup(endpoint, "Model", workspace, {1127,1128,1138,1140})
    setName(endpoint, G[1126], "Chair")
end)
task.spawn(function()
    G[1122] = createGroup(endpoint, "Model", workspace, {1123,1124,1125})
end)
task.spawn(function()
    G[1107] = createGroup(endpoint, "Model", workspace, {1108,1109,1119,1121})
    setName(endpoint, G[1107], "Chair")
end)
task.spawn(function()
    G[970] = createGroup(endpoint, "Model", workspace, {971,973,975,977,979,981,983,985})
    setName(endpoint, G[970], "Model2")
end)
task.spawn(function()
    G[1094] = createGroup(endpoint, "Model", workspace, {1095,1097})
    setName(endpoint, G[1094], "Model10")
end)
task.spawn(function()
    G[1079] = createGroup(endpoint, "Model", workspace, {1080,1081,1091,1093})
    setName(endpoint, G[1079], "Chair")
end)
task.spawn(function()
    G[1210] = createGroup(endpoint, "Model", workspace, {1211,1217})
    setName(endpoint, G[1210], "Armchair")
end)
task.spawn(function()
    G[1060] = createGroup(endpoint, "Model", workspace, {1061,1062,1072,1074})
    setName(endpoint, G[1060], "Chair")
end)
task.spawn(function()
    G[39] = createGroup(endpoint, "Model", workspace, {204,296,300,307})
end)
task.spawn(function()
    G[818] = createGroup(endpoint, "Model", workspace, {819,821,822,823})
    setName(endpoint, G[818], "Model7")
end)
task.spawn(function()
    G[953] = createGroup(endpoint, "Model", workspace, {954,956,958,960,962,964,966,968})
    setName(endpoint, G[953], "Model4")
end)
task.spawn(function()
    G[908] = createGroup(endpoint, "Model", workspace, {909,911,913,932,951})
    setName(endpoint, G[908], "Model2")
end)
task.spawn(function()
    G[179] = createGroup(endpoint, "Model", workspace, {180,182,185,187})
    setName(endpoint, G[179], "Body")
end)
task.spawn(function()
    G[539] = createGroup(endpoint, "Model", workspace, {540,542,544,546,548,550,552,554})
    setName(endpoint, G[539], "Model3")
end)
task.spawn(function()
    G[1018] = createGroup(endpoint, "Model", workspace, {1019,1020,1030,1032})
    setName(endpoint, G[1018], "Chair")
end)
task.spawn(function()
    G[480] = createGroup(endpoint, "Model", workspace, {481,487})
    setName(endpoint, G[480], "Armchair")
end)
task.spawn(function()
    G[1014] = createGroup(endpoint, "Model", workspace, {1015,1016,1017})
end)
task.spawn(function()
    G[1045] = createGroup(endpoint, "Model", workspace, {1046,1047,1057,1059})
    setName(endpoint, G[1045], "Chair")
end)
task.spawn(function()
    G[885] = createGroup(endpoint, "Model", workspace, {886,888,890,892,894,896,898,900,902,904,906})
    setName(endpoint, G[885], "CafeLights")
end)
task.spawn(function()
    G[864] = createGroup(endpoint, "Model", workspace, {865,866,867,868,869,870,871})
    setName(endpoint, G[864], "Model2")
end)
task.spawn(function()
    G[558] = createGroup(endpoint, "Model", workspace, {559,561,563,565,567,569,571,573})
end)
task.spawn(function()
    G[354] = createGroup(endpoint, "Folder", workspace, {355,357,360,363,370,385})
    setName(endpoint, G[354], "Texxy")
end)
task.spawn(function()
    G[631] = createGroup(endpoint, "Model", workspace, {632,634})
    setName(endpoint, G[631], "Armchair")
end)
task.spawn(function()
    G[189] = createGroup(endpoint, "Model", workspace, {190,191,192,193,194})
end)
task.spawn(function()
    G[455] = createGroup(endpoint, "Model", workspace, {456,1326,1328,1329,1331})
    setName(endpoint, G[455], "modelID-99779474214620")
end)
task.spawn(function()
    G[308] = createGroup(endpoint, "Model", workspace, {310,313,320,322,348,352})
    setName(endpoint, G[308], "R6n_matieser0")
end)
task.spawn(function()
    G[93] = createGroup(endpoint, "Folder", workspace, {94,97,104,119,122,124,158})
    setName(endpoint, G[93], "W2s")
end)
task.spawn(function()
    G[45] = createGroup(endpoint, "Folder", workspace, {47,50,57,72,74,77,85,88,91})
    setName(endpoint, G[45], "Rbd")
end)
task.spawn(function()
    G[471] = createGroup(endpoint, "Model", workspace, {472,478})
    setName(endpoint, G[471], "Armchair")
end)
task.spawn(function()
    G[532] = createGroup(endpoint, "Model", workspace, {533,535,537,556,575})
    setName(endpoint, G[532], "Model3")
end)
task.spawn(function()
    G[806] = createGroup(endpoint, "Model", workspace, {807,808,809,810,811,812,813})
    setName(endpoint, G[806], "Model5")
end)
task.spawn(function()
    G[513] = createGroup(endpoint, "Model", workspace, {514,515,525,527})
    setName(endpoint, G[513], "Chair")
end)
task.spawn(function()
    G[458] = createGroup(endpoint, "Model", workspace, {459,461,463,465,467,469,489,491,528,530,611,613,615,617,619,622,629,640,647,987,1042,1099,1141,1208,1219,1220,1223,1225,1227,1228,1230,1232,1234,1236,1237,1239,1315,1317,1324})
    setName(endpoint, G[458], "coffee shop")
end)
task.spawn(function()
    G[1144] = createGroup(endpoint, "Model", workspace, {1145,1146,1156,1158})
    setName(endpoint, G[1144], "Chair")
end)
task.spawn(function()
    G[390] = createGroup(endpoint, "Model", workspace, {402,414,429,433,436,438,441})
    setName(endpoint, G[390], "R6n_YandelSpooky")
end)
task.wait(0.3)
task.wait(0.5)
local missed = {}
for id, part in pairs(P) do
    if part and not part.Anchored then missed[#missed+1] = {Part = part, Anchored = true} end
end
if #missed > 0 then
    for i = 1, #missed, 100 do
        local chunk = {}
        for j = i, math.min(i+99, #missed) do chunk[#chunk+1] = missed[j] end
        endpoint:InvokeServer("SyncAnchor", chunk)
        task.wait()
    end
end
local player = game.Players.LocalPlayer
local tool

for _, v in pairs(player:GetDescendants()) do
    if v.Name == "SyncAPI" then
        tool = v.Parent
    end
end

for _, v in pairs(game.ReplicatedStorage:GetDescendants()) do
    if v.Name == "SyncAPI" then
        tool = v.Parent
    end
end

local remote = tool.SyncAPI.ServerEndpoint

function _(args)
    remote:InvokeServer(unpack(args))
end

for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") and v.Name == "Baseplate" then
        _( {
            [1] = "SyncSurface",
            [2] = {
                ["Part"] = v,
                ["Surfaces"] = {
                    ["Top"] = "Studs",
                    ["Bottom"] = "Studs",
                    ["Left"] = "Studs",
                    ["Right"] = "Studs",
                    ["Front"] = "Studs",
                    ["Back"] = "Studs"
                }
            }
        })
    end
end
