
create table BASE_UNIT
(
  auto_id VARCHAR2(36),
  code    VARCHAR2(3) not null,
  name    VARCHAR2(20),
  flag    VARCHAR2(36)
)
tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on table BASE_UNIT
  is '基础资料-计量单位代码';
comment on column BASE_UNIT.auto_id
  is '自动编号';
comment on column BASE_UNIT.code
  is '代码';
comment on column BASE_UNIT.name
  is '名称';
create index WA_SYS_NAME_4830B400 on BASE_UNIT (NAME)
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table BASE_UNIT
  add constraint PK_BASE_UNIT primary key (CODE)
  using index 
  tablespace LF_FTZ_PLAT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Disabling triggers for BASE_UNIT...
alter table BASE_UNIT disable all triggers;
prompt Loading BASE_UNIT...
insert into BASE_UNIT (auto_id, code, name, flag)
values ('200C9493-FA74-48AE-A7ED-8F8CF4EAA715', '001', '台', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('2515D569-8046-4458-82BB-FF6C945467EB', '002', '座', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('2E037E62-8BF6-457B-B01B-A0E645EF3EF7', '003', '辆', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('A1DEE683-2194-4FAD-9C56-EC5300E213E7', '004', '艘', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('8172EE6A-9F37-4BAC-B045-2B8657204824', '005', '架', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('1ED4C061-8B9C-495D-A794-7FE8886FF701', '006', '套', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('C4238D24-F18E-4F28-8CC1-4160EC917484', '007', '个', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('01868A95-9E04-426C-B433-8FA8ED227A50', '008', '只', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('E72E05FD-6FF4-4DF3-B118-AB338181A231', '009', '头', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('54012183-08D8-4DFF-B3AA-BEE13D68F663', '010', '张', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('B854A03C-1DB5-4083-BE33-591EF0E8F320', '011', '件', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('4FE020C4-560B-497D-86D0-6CE60C52E169', '012', '支', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('5944A4A5-113E-4881-AD72-52B64ECB1389', '013', '枝', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('2A9E6973-C0B5-4118-99C4-1A279380CA14', '014', '根', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('63F2C61E-554D-4AB6-9906-D9A291025001', '015', '条', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('746EBC22-1E63-49D4-B656-541AD560316A', '016', '把', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('CE4A60C1-F3C2-45C2-AF10-9092687B5065', '017', '块', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('DB2542B2-2450-4009-92FE-4B970602D9DC', '018', '卷', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('4617C019-79DF-4DE5-AB97-141B8BB3D2A2', '019', '副', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('F7B64EBA-D6AD-46B8-86F2-ECDAA05AC5D0', '020', '片', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('3A1744B3-EDB6-4D90-99CC-9B6916D23E45', '021', '组', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('AE58FB8E-42DF-4A2F-8D9E-ABB3BD292E54', '022', '份', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('94A6702F-0F50-4EAE-B3DB-7C09EBF1C026', '023', '幅', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('375C58AD-3F82-4D1E-A7D4-476609EFED1E', '025', '双', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('87146F72-F4DF-406E-AA28-5035703E33BB', '026', '对', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('03D95147-367D-4B98-8743-0518C97DD61B', '027', '棵', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('0E6B6375-C374-46A4-B291-66694DDE28A5', '028', '株', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('AF1E3773-5A33-42D0-823C-A23F35960DFD', '029', '井', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('0C46A914-261A-4455-92F2-1F980702B4A0', '030', '米', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('0828BCF5-B1BE-4573-945E-CBB9D7A7C6BB', '031', '盘', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('676E66D0-A4AB-4E0D-AC2A-E995FD130063', '032', '平方米', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('F0D3A8AA-653D-48B2-A160-A5B9470016D4', '033', '立方米', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('9EE57DE2-02BF-41D8-A393-D200E7CB185A', '034', '筒', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('B29A2A14-81DC-4D73-9385-5D79F3FC9812', '035', '千克', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('B6538A92-433D-48E0-AF7B-DBEC2FD34446', '036', '克', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('B29775A8-7E53-4D6E-BC73-C894ACC4EEF3', '037', '盆', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('85504514-1AB2-48ED-BC68-36D6038BF254', '038', '万个', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('77D18C42-6FFE-4E0B-A5AF-22EB5804BD88', '039', '具', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('5D4B0A26-93C3-44F9-91EF-284534849196', '040', '百副', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('C9769F98-EADA-4DB3-828E-1FDC5221784E', '041', '百支', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('9155A52E-A578-4589-BEAD-25446A8ACCBA', '042', '百把', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('9C7A76A0-2129-4756-9430-34062CD09A3A', '043', '百个', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('703C3BE8-5719-4B5A-955B-F405CD43DE04', '044', '百片', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('D2DC2596-80D4-417D-A4A6-5A1BBC23D36E', '045', '刀', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('ADD80624-4776-491D-AD69-D60B56A6959F', '046', '疋', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('E43BD646-84B1-4567-B672-B73DAF2B9346', '047', '公担', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('C1C591DB-96A1-4056-8612-27E4EBFC6A2F', '048', '扇', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('A5F36D8D-1E39-4A60-8B85-DC884A58492B', '049', '百枝', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('DC457722-9A88-4DA9-8911-4C5E807918FD', '050', '千只', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('5D48CC4F-A1E1-48BD-A01F-0CDBD63B488B', '051', '千块', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('48B5C987-AA63-4D87-B0AE-FAF307F6543E', '052', '千盒', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('08332F3B-F3A8-46A5-954F-A8F5A47B2DE0', '053', '千枝', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('3E4BEC51-DC34-4AD8-92F8-B028B3C015DF', '054', '千个', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('09AA4B30-AADA-435A-9651-8091D9C971A4', '055', '亿支', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('0801BA69-6A83-44FC-9380-4F3DCC217FE5', '056', '亿个', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('A0F1A12A-F53B-4185-B4E7-6EE1ADB928CE', '057', '万套', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('79F4F190-A6CB-4612-9566-8EA56A0CD7E3', '058', '千张', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('ABF9CEBC-2488-494B-B483-967E6EDD78EB', '059', '万张', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('548A4630-7F28-4939-A76D-3B990B9C9468', '060', '千伏安', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('8B441D24-F1F6-428C-B710-5BEBC01ABD5C', '061', '千瓦', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('3161C6DE-718F-4F8D-BAAB-BBE71CC56489', '062', '千瓦时', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('34EC4AC3-C02F-4B70-A317-667517A8C581', '063', '千升', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('1F31B0EC-4374-4B51-90CF-C376F0468DDB', '067', '英尺', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('FD8DAE0D-5DE0-460A-AD11-5E8380F49262', '070', '吨', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('3386F441-8083-48C4-A2B5-9F80221C8576', '071', '长吨', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('1DF55E11-D180-477B-B1E9-35A80DDF8835', '072', '短吨', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('0829BCBD-266B-4AE5-BA6E-F3D80890B296', '073', '司马担', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('173CF32A-FB8D-44AB-A47F-6BE441A23EF1', '074', '司马斤', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('75F03621-5F1B-4EFA-A614-9A41FD7A5EE5', '075', '斤', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('CD759C3D-E85F-4190-A075-7F1B0A2713B7', '076', '磅', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('2FE57676-7D19-4A13-A618-16ED7E60BE0A', '077', '担', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('3ACB19AF-9C65-4144-9951-CA00EC3410C9', '078', '英担', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('BE15F840-B2DF-4642-B686-F89E476C27F6', '079', '短担', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('C3020F97-709A-4A6A-B1B8-82319AF2057A', '080', '两', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('0263899C-255B-46E7-B3AA-20D0D5991D92', '081', '市担', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('20B9AAF2-25BC-4C46-952F-7F5A096E3BE5', '083', '盎司', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('E2332277-F309-4E0A-848B-8047C55673C1', '084', '克拉', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('43724331-5875-4AA0-A9F4-B5AA6998D577', '085', '市尺', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('DBA1ECB5-FD81-4B58-9D1B-607E88C0872E', '086', '码', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('427A36EB-B8FD-4F39-96C0-4492D9D1EA21', '088', '英寸', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('B723C054-B875-4AC9-9813-E89163E6588A', '089', '寸', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('1A30E517-69C2-4F37-B21D-B8DF9533E543', '095', '升', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('BD505370-3560-4A42-932B-2AFBEB6AA304', '096', '毫升', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('BA55A026-85A1-4DC2-BC31-E9FECA52E83C', '097', '英加仑', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('0D87171D-B2A5-4CFD-BE9C-062C781E187F', '098', '美加仑', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('54CE3587-6290-429D-8B72-3D64069E1649', '099', '立方英尺', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('D071E443-B5EE-4E09-B955-4904EC96725F', '101', '立方尺', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('98EE0EB4-6C48-42F6-9A1E-AFAC86828114', '110', '平方码', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('FC8C5E78-7578-4278-A356-41BEBC29A9D4', '111', '平方英尺', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('165CE1BA-396F-491D-9CE9-74DCC812DEF5', '112', '平方尺', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('B33DE7EF-7B81-4F25-892F-B4A233CC9B5C', '115', '英制马力', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('836889BB-EEE1-46CF-B43E-BF39D8643148', '116', '公制马力', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('A14CDEB1-2284-4B85-80D1-283E04DF3D3B', '118', '令', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('B96798F4-A304-4496-AAA8-71D18A480557', '120', '箱', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('5FC0B2CC-C851-42B7-9645-ECE3831A7B8B', '121', '批', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('E0A70A1F-6B6C-4B0E-89D8-F026A3183942', '122', '罐', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('5B3B1F07-0FA4-444E-A661-7B95203C98C5', '123', '桶', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('E0FD6CD3-F539-4592-9252-297268CFE503', '124', '扎', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('D67B58AE-5EBC-455B-B0DB-955C30100AC8', '125', '包', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('31811548-C8D1-4B9D-A9A3-A45E3889211D', '126', '箩', null);
commit;
prompt 100 records committed...
insert into BASE_UNIT (auto_id, code, name, flag)
values ('8D835115-F994-472F-92FF-3E902F865C0D', '127', '打', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('6D69A6C0-F082-48C6-8035-A2039C96D272', '128', '筐', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('C7E09CC3-4CD2-4D0D-AD99-79099ECF0C13', '129', '罗', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('58B92924-ADCA-420D-ACE3-81CD33640BDC', '130', '匹', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('C1915441-0AC7-4009-8F06-0541CB73ACD8', '131', '册', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('45E41629-9261-49FB-B22A-F569648CDA91', '132', '本', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('60DFA8EF-AC5B-4B9D-8B1F-BB59B6E30A36', '133', '发', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('A56E540B-DD35-472E-92AC-EAF2E77790A4', '134', '枚', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('219B0CC5-2BA6-44B5-A8D8-8CC1FCFD1CDF', '135', '捆', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('ABE256D5-D167-4149-9415-0A3ACBA0B048', '136', '袋', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('B246A875-BA05-4562-8E26-A76FF36F99DD', '139', '粒', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('B0143A93-75A8-4FCF-9583-D42CEC5D345E', '140', '盒', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('A12994E5-CFD8-4694-A407-D5304F13F5F6', '141', '合', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('6D34DC04-5B20-46D6-A34A-E72ACBC03B21', '142', '瓶', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('61840D24-64F7-40AD-B698-4654FEF3C6E6', '143', '千支', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('035B407B-CF14-478A-9794-49ED87C5A871', '144', '万双', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('A6D95064-9CD5-4E22-8A41-C1F0DA0D850C', '145', '万粒', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('210F980F-A605-426E-99A4-5AC764096063', '146', '千粒', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('8C5020EC-89A9-4E44-9BB2-1980CDE8309B', '147', '千米', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('71442E9B-D124-4778-BE7F-EF75E279C424', '148', '千英尺', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('DC6609F5-6AAC-49BC-B5D0-069E152FB93A', '149', '百万贝可', null);
insert into BASE_UNIT (auto_id, code, name, flag)
values ('CFE86D37-CFA9-4987-842F-3420E5B3FD73', '163', '部', null);
commit;
