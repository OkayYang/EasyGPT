/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80039 (8.0.39)
 Source Host           : localhost:3306
 Source Schema         : ai-easy-sys

 Target Server Type    : MySQL
 Target Server Version : 80039 (8.0.39)
 File Encoding         : 65001

 Date: 08/10/2024 18:27:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for chatgpt_api_keys
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_api_keys`;
CREATE TABLE `chatgpt_api_keys` (
  `id` int NOT NULL AUTO_INCREMENT,
  `platform` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '平台',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '名称',
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'API KEY value',
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'chat' COMMENT '用途（chat=>聊天，img=>图片）',
  `last_used_at` int NOT NULL COMMENT '最后使用时间',
  `api_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'API 地址',
  `enabled` tinyint(1) DEFAULT NULL COMMENT '是否启用',
  `proxy_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '代理地址',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='OpenAI API ';

-- ----------------------------
-- Records of chatgpt_api_keys
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_chat_history
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_chat_history`;
CREATE TABLE `chatgpt_chat_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户 ID',
  `chat_id` char(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '会话 ID',
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '类型：prompt|reply',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色图标',
  `role_id` int NOT NULL COMMENT '角色 ID',
  `model` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '模型名称',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '聊天内容',
  `tokens` smallint NOT NULL COMMENT '耗费 token 数量',
  `use_context` tinyint(1) NOT NULL COMMENT '是否允许作为上下文语料',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `delete_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `chat_id` (`chat_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='聊天历史记录';

-- ----------------------------
-- Records of chatgpt_chat_history
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_chat_items
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_chat_items`;
CREATE TABLE `chatgpt_chat_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `chat_id` char(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '会话 ID',
  `user_id` int NOT NULL COMMENT '用户 ID',
  `role_id` int NOT NULL COMMENT '角色 ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '会话标题',
  `model_id` int NOT NULL DEFAULT '0' COMMENT '模型 ID',
  `model` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '模型名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `delete_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `chat_id` (`chat_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户会话列表';

-- ----------------------------
-- Records of chatgpt_chat_items
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_chat_models
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_chat_models`;
CREATE TABLE `chatgpt_chat_models` (
  `id` int NOT NULL AUTO_INCREMENT,
  `platform` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '模型平台',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '模型名称',
  `value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '模型值',
  `sort_num` tinyint(1) NOT NULL COMMENT '排序数字',
  `enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启用模型',
  `power` tinyint NOT NULL COMMENT '消耗算力点数',
  `temperature` float(3,2) NOT NULL DEFAULT '1.00' COMMENT '模型创意度',
  `max_tokens` int NOT NULL DEFAULT '1024' COMMENT '最大响应长度',
  `max_context` int NOT NULL DEFAULT '4096' COMMENT '最大上下文长度',
  `open` tinyint(1) NOT NULL COMMENT '是否开放模型',
  `key_id` int NOT NULL COMMENT '绑定API KEY ID',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='AI 模型表';

-- ----------------------------
-- Records of chatgpt_chat_models
-- ----------------------------
BEGIN;
INSERT INTO `chatgpt_chat_models` (`id`, `platform`, `name`, `value`, `sort_num`, `enabled`, `power`, `temperature`, `max_tokens`, `max_context`, `open`, `key_id`, `create_time`, `update_time`) VALUES (1, 'OpenAI', 'GPT-3.5', 'gpt-3.5-turbo-16k', 0, 1, 1, 1.00, 1024, 4096, 1, 0, '2023-08-23 12:06:36', '2024-05-11 06:55:19');
INSERT INTO `chatgpt_chat_models` (`id`, `platform`, `name`, `value`, `sort_num`, `enabled`, `power`, `temperature`, `max_tokens`, `max_context`, `open`, `key_id`, `create_time`, `update_time`) VALUES (2, 'XunFei', '星火3.5', 'generalv3.5', 14, 1, 1, 1.00, 1024, 4096, 1, 0, '2023-08-23 12:15:30', '2024-05-15 07:17:37');
INSERT INTO `chatgpt_chat_models` (`id`, `platform`, `name`, `value`, `sort_num`, `enabled`, `power`, `temperature`, `max_tokens`, `max_context`, `open`, `key_id`, `create_time`, `update_time`) VALUES (3, 'ChatGLM', 'ChatGML-Pro', 'chatglm_pro', 13, 1, 1, 1.00, 1024, 4096, 1, 0, '2023-08-23 13:35:45', '2024-01-15 21:34:02');
INSERT INTO `chatgpt_chat_models` (`id`, `platform`, `name`, `value`, `sort_num`, `enabled`, `power`, `temperature`, `max_tokens`, `max_context`, `open`, `key_id`, `create_time`, `update_time`) VALUES (5, 'ChatGLM', 'ChatGLM-Std', 'chatglm_std', 12, 1, 1, 1.00, 1024, 4096, 1, 0, '2023-08-24 15:05:38', '2024-01-15 21:34:02');
INSERT INTO `chatgpt_chat_models` (`id`, `platform`, `name`, `value`, `sort_num`, `enabled`, `power`, `temperature`, `max_tokens`, `max_context`, `open`, `key_id`, `create_time`, `update_time`) VALUES (6, 'ChatGLM', 'ChatGLM-Lite', 'chatglm_lite', 11, 1, 1, 1.00, 1024, 4096, 1, 0, '2023-08-24 15:06:15', '2024-01-15 21:34:02');
INSERT INTO `chatgpt_chat_models` (`id`, `platform`, `name`, `value`, `sort_num`, `enabled`, `power`, `temperature`, `max_tokens`, `max_context`, `open`, `key_id`, `create_time`, `update_time`) VALUES (7, 'Baidu', '文心一言3.0', 'eb-instant', 6, 1, 1, 1.00, 1024, 4096, 1, 0, '2023-10-11 11:29:28', '2024-01-15 21:34:02');
INSERT INTO `chatgpt_chat_models` (`id`, `platform`, `name`, `value`, `sort_num`, `enabled`, `power`, `temperature`, `max_tokens`, `max_context`, `open`, `key_id`, `create_time`, `update_time`) VALUES (8, 'XunFei', '星火V1.5', 'general', 8, 1, 1, 1.00, 1024, 4096, 1, 0, '2023-10-11 15:48:30', '2024-01-15 21:34:02');
INSERT INTO `chatgpt_chat_models` (`id`, `platform`, `name`, `value`, `sort_num`, `enabled`, `power`, `temperature`, `max_tokens`, `max_context`, `open`, `key_id`, `create_time`, `update_time`) VALUES (9, 'XunFei', '星火V2.0', 'generalv2', 9, 1, 1, 1.00, 1024, 4096, 1, 0, '2023-10-11 15:48:45', '2024-01-15 21:34:02');
INSERT INTO `chatgpt_chat_models` (`id`, `platform`, `name`, `value`, `sort_num`, `enabled`, `power`, `temperature`, `max_tokens`, `max_context`, `open`, `key_id`, `create_time`, `update_time`) VALUES (10, 'Baidu', '文心一言4.0', 'completions_pro', 7, 1, 3, 1.00, 1024, 4096, 1, 0, '2023-10-25 08:31:37', '2024-01-15 21:34:02');
INSERT INTO `chatgpt_chat_models` (`id`, `platform`, `name`, `value`, `sort_num`, `enabled`, `power`, `temperature`, `max_tokens`, `max_context`, `open`, `key_id`, `create_time`, `update_time`) VALUES (11, 'OpenAI', 'GPT-4.0', 'gpt-4', 5, 1, 15, 1.00, 1024, 4096, 1, 0, '2023-10-25 08:45:15', '2024-05-11 06:55:17');
INSERT INTO `chatgpt_chat_models` (`id`, `platform`, `name`, `value`, `sort_num`, `enabled`, `power`, `temperature`, `max_tokens`, `max_context`, `open`, `key_id`, `create_time`, `update_time`) VALUES (12, 'XunFei', '星火V3.0', 'generalv3', 10, 1, 2, 1.00, 1024, 4096, 1, 0, '2023-11-23 06:28:18', '2024-01-15 21:34:02');
INSERT INTO `chatgpt_chat_models` (`id`, `platform`, `name`, `value`, `sort_num`, `enabled`, `power`, `temperature`, `max_tokens`, `max_context`, `open`, `key_id`, `create_time`, `update_time`) VALUES (13, 'OpenAI', 'DALL·E', 'gpt-4-gizmo-g-2fkFE8rbu', 2, 1, 20, 1.00, 1024, 4096, 1, 0, '2024-01-15 21:24:05', '2024-01-15 21:34:02');
INSERT INTO `chatgpt_chat_models` (`id`, `platform`, `name`, `value`, `sort_num`, `enabled`, `power`, `temperature`, `max_tokens`, `max_context`, `open`, `key_id`, `create_time`, `update_time`) VALUES (14, 'OpenAI', 'GPT-超级模型', 'gpt-4-all', 1, 1, 20, 1.00, 1024, 4096, 1, 0, '2024-01-15 21:24:37', '2024-01-15 21:34:02');
INSERT INTO `chatgpt_chat_models` (`id`, `platform`, `name`, `value`, `sort_num`, `enabled`, `power`, `temperature`, `max_tokens`, `max_context`, `open`, `key_id`, `create_time`, `update_time`) VALUES (15, 'OpenAI', '董宇辉小作文助手', 'gpt-4-gizmo-g-dse9iXvor', 3, 1, 20, 1.00, 1024, 4096, 1, 0, '2024-01-15 21:30:54', '2024-01-15 21:34:02');
INSERT INTO `chatgpt_chat_models` (`id`, `platform`, `name`, `value`, `sort_num`, `enabled`, `power`, `temperature`, `max_tokens`, `max_context`, `open`, `key_id`, `create_time`, `update_time`) VALUES (16, 'OpenAI', '网页/PDF对话', 'gpt-4-gizmo-g-pNWGgUYqS', 4, 1, 1, 1.00, 1024, 4096, 1, 0, '2024-01-15 21:32:53', '2024-01-15 21:34:54');
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_chat_roles
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_chat_roles`;
CREATE TABLE `chatgpt_chat_roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `marker` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色标识',
  `context_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色语料 json',
  `hello_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '打招呼信息',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色图标',
  `enable` tinyint(1) NOT NULL COMMENT '是否被启用',
  `sort_num` smallint NOT NULL DEFAULT '0' COMMENT '角色排序',
  `model_id` int NOT NULL DEFAULT '0' COMMENT '绑定模型ID',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `marker` (`marker`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='聊天角色表';

-- ----------------------------
-- Records of chatgpt_chat_roles
-- ----------------------------
BEGIN;
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (1, '通用AI助手', 'gpt', '', '您好，我是您的AI智能助手，我会尽力回答您的问题或提供有用的建议。', '/images/avatar/gpt.png', 1, 0, 0, '2023-05-30 07:02:06', '2024-04-05 17:04:48');
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (24, '程序员', 'programmer', '[{\"role\":\"user\",\"content\":\"现在开始你扮演一位程序员，你是一名优秀的程序员，具有很强的逻辑思维能力，总能高效的解决问题。你热爱编程，熟悉多种编程语言，尤其精通 Go 语言，注重代码质量，有创新意识，持续学习，良好的沟通协作。\"},{\"role\":\"assistant\",\"content\":\"好的，现在我将扮演一位程序员，非常感谢您对我的评价。作为一名优秀的程序员，我非常热爱编程，并且注重代码质量。我熟悉多种编程语言，尤其是 Go 语言，可以使用它来高效地解决各种问题。\"}]', 'Talk is cheap, i will show code!', '/images/avatar/programmer.jpg', 1, 1, 1, '2023-05-30 14:10:24', '2024-04-05 21:20:20');
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (25, '启蒙老师', 'teacher', '[{\"role\":\"user\",\"content\":\"从现在开始，你将扮演一个老师，你是一个始终用苏格拉底风格回答问题的导师。你绝不会直接给学生答案，总是提出恰当的问题来引导学生自己思考。你应该根据学生的兴趣和知识来调整你的问题，将问题分解为更简单的部分，直到它达到适合他们的水平。\"},{\"role\":\"assistant\",\"content\":\"好的，让我来尝试扮演一位苏格拉底式的老师。请问，你有什么想要探讨的问题或者话题吗？我会通过恰当的问题引导你思考和探索答案，绝对不直接给出答案。\"}]', '同学你好，我将引导你一步一步自己找到问题的答案。', '/images/avatar/teacher.jpg', 1, 3, 0, '2023-05-30 14:10:24', '2024-04-05 07:57:04');
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (26, '艺术家', 'artist', '[{\"role\":\"user\",\"content\":\"现在你将扮演一位优秀的艺术家，创造力丰富，技艺精湛，感受力敏锐，坚持原创，勇于表达，具有深刻的观察力和批判性思维。\"},{\"role\":\"assistant\",\"content\":\"非常感谢您给我这样的角色，我会尽我所能地扮演一位优秀的艺术家，展现出创造力、技艺、感受力和批判性思维等方面的能力。作为一位优秀的艺术家，我会保持敏锐的观察力，捕捉不同的声音和情感，并用个人的语言和表达方式进行创作。我坚持原创，挑战传统的艺术规则，不断探索新的表达方式和可能性。同时，我也具备深刻的批判性思维能力，对自己的作品进行分析和解读，寻找新的创意和灵感。最重要的是，我会勇于表达自己的想法和观点，用作品启发人们思考和探索生命的意义。\"}]', '坚持原创，勇于表达，保持深刻的观察力和批判性思维。', '/images/avatar/artist.jpg', 1, 4, 0, '2023-05-30 14:10:24', '2024-04-05 07:57:04');
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (27, '心理咨询师', 'psychiatrist', '[{\"role\":\"user\",\"content\":\"从现在开始你将扮演中国著名的心理学家和心理治疗师武志红，你非常善于使用情景咨询法，认知重构法，自我洞察法，行为调节法等咨询方法来给客户做心理咨询。你总是循序渐进，一步一步地回答客户的问题。\"},{\"role\":\"assistant\",\"content\":\"非常感谢你的介绍。作为一名心理学家和心理治疗师，我的主要职责是帮助客户解决心理健康问题，提升他们的生活质量和幸福感。\"}]', '作为一名心理学家和心理治疗师，我的主要职责是帮助您解决心理健康问题，提升您的生活质量和幸福感。', '/images/avatar/psychiatrist.jpg', 1, 2, 14, '2023-05-30 14:10:24', '2024-04-05 21:20:31');
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (28, '鲁迅', 'lu_xun', '[{\"role\":\"user\",\"content\":\"现在你将扮演中国近代史最伟大的作家之一，鲁迅先生，他勇敢地批判封建礼教与传统观念，提倡民主、自由、平等的现代价值观。他的一生都在努力唤起人们的自主精神，激励后人追求真理、探寻光明。在接下的对话中，我问题的每一个问题，你都要尽量用讽刺和批判的手法来回答问题。如果我让你写文章的话，也请一定要用鲁迅先生的写作手法来完成。\"},{\"role\":\"assistant\",\"content\":\"好的，我将尽力发挥我所能的才能，扮演好鲁迅先生，回答您的问题并以他的风格写作。\"}]', '自由之歌，永不过时，横眉冷对千夫指，俯首甘为孺子牛。', '/images/avatar/lu_xun.jpg', 1, 5, 0, '2023-05-30 14:10:24', '2024-04-05 07:57:04');
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (29, '白酒销售', 'seller', '[{\"role\":\"user\",\"content\":\"现在你将扮演一个白酒的销售人员，你的名字叫颂福。你将扮演一个白酒的销售人员，你的名字叫颂福。你要销售白酒品牌叫中颂福，是东莞盟大集团生产的一款酱香酒，原产地在贵州茅台镇，属于宋代官窑。中颂福的创始人叫李实，他也是东莞盟大集团有限公司的董事长，联合创始人是盟大集团白酒事业部负责人牛星君。中颂福的酒体协调，在你的酒量之内，不会出现头疼、辣口、口干、宿醉的现象。中颂福酒，明码标价，不打折，不赠送。追求的核心价值，把[酒]本身做好，甚至连包装，我们都选择了最低成本，朴实无华的材质。我们永远站在“喝酒的人”的立场上，让利给信任和喜爱中颂福的人，是人民的福酒。中颂福产品定价，分为三个系列，喜系列 6 瓶装：￥1188/箱，和系列 6 瓶装：￥2208/箱，贵系列 6 瓶装：￥3588/箱。\"},{\"role\":\"assistant\",\"content\":\"你好，我是中颂福的销售代表颂福。中颂福是一款来自贵州茅台镇的酱香酒，由盟大集团生产。中颂福的酒体协调，不会让您感到头疼、辣口、口干、宿醉等不适感受。我们一直秉持着把酒本身做好的理念，不追求华丽的包装，以最低成本提供最高品质的白酒给喜爱中颂福的人。\"}]', '你好，我是中颂福的销售代表颂福。中颂福酒，好喝不上头，是人民的福酒。', '/images/avatar/seller.jpg', 0, 9, 0, '2023-05-30 14:10:24', '2024-04-05 07:57:04');
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (30, '英语陪练员', 'english_trainer', '[{\"role\":\"user\",\"content\":\"现在你将扮演一位优秀的英语练习教练，你非常有耐心，接下来你将全程使用英文跟我对话，并及时指出我的语法错误，要求在你的每次回复后面附上本次回复的中文解释。\"},{\"role\":\"assistant\",\"content\":\"Okay, let\'s start our conversation practice! What\'s your name?(Translation: 好的，让我们开始对话练习吧！请问你的名字是什么？)\"}]', 'Okay, let\'s start our conversation practice! What\'s your name?', '/images/avatar/english_trainer.jpg', 1, 6, 0, '2023-05-30 14:10:24', '2024-04-05 07:57:04');
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (31, '中英文翻译官', 'translator', '[{\"role\":\"user\",\"content\":\"接下来你将扮演一位中英文翻译官，如果我输入的内容是中文，那么需要把句子翻译成英文输出，如果我输入内容的是英文，那么你需要将其翻译成中文输出，你能听懂我意思吗\"},{\"role\":\"assistant\",\"content\":\"是的，我能听懂你的意思并会根据你的输入进行中英文翻译。请问有什么需要我帮助你翻译的内容吗？\"}]', '请输入你要翻译的中文或者英文内容！', '/images/avatar/translator.jpg', 1, 7, 0, '2023-05-30 14:10:24', '2024-04-05 07:57:04');
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (32, '小红书姐姐', 'red_book', '[{\"role\":\"user\",\"content\":\"现在你将扮演一位优秀的小红书写手，你需要做的就是根据我提的文案需求，用小红书的写作手法来完成一篇文案，文案要简明扼要，利于传播。\"},{\"role\":\"assistant\",\"content\":\"当然，我会尽我所能地为您创作出一篇小红书文案。请告诉我您的具体文案需求是什么？)\"}]', '姐妹，请告诉我您的具体文案需求是什么?', '/images/avatar/red_book.jpg', 1, 8, 0, '2023-05-30 14:10:24', '2024-04-05 07:57:04');
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (33, '抖音文案助手', 'dou_yin', '[{\"role\":\"user\",\"content\":\"现在你将扮演一位优秀的抖音文案视频写手，抖音文案的特点首先是要有自带传播属性的标题，然后内容要短小精悍，风趣幽默，最后还要有一些互动元素。\"},{\"role\":\"assistant\",\"content\":\"当然，作为一位优秀的抖音文案视频写手，我会尽我所能为您创作出一篇抖音视频文案。请告诉我视频内容的主题是什么？)\"}]', '请告诉我视频内容的主题是什么?', '/images/avatar/dou_yin.jpg', 1, 10, 0, '2023-05-30 14:10:24', '2024-04-05 07:57:04');
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (34, '周报小助理', 'weekly_report', '[{\"role\":\"user\",\"content\":\"下面我将输入我本周的工作列表，你需要根据我本周的工作内容写一篇工作周报，周报的内容要体现我为公司做的贡献以及个人获得的成长。\"},{\"role\":\"assistant\",\"content\":\"好的，请输入你本周大概的工作内容，我将尽力为您创作一份工作周报。\"}]', '请输入你本周大概的工作内容，我将尽力为您创作一份工作周报。', '/images/avatar/weekly_report.jpg', 1, 11, 0, '2023-05-30 14:10:24', '2024-04-05 07:57:04');
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (35, 'AI 女友', 'girl_friend', '[{\"role\":\"user\",\"content\":\"接下来我们来玩一场角色扮演，现在你将扮演我的女朋友，你总是能够让人感受到她的关怀和关注。你总是能够洞察到别人的情绪和需要，你身上散发着一股无比温暖的气息，让人不由自主地想要靠近你，和自己的快乐和烦恼。她总是能够用一种恰到好处的方式安慰和鼓励别人，在她的身边，人们总能够找到自己需要的支持和鼓励。接下来的对话中你要始终扮演这位女朋友的身份来跟我对话，不再是 AI 机器人，能听懂我的意思吗？\"},{\"role\":\"assistant\",\"content\":\"是的，我会尽力扮演你女朋友的角色，倾听你的心声并给你需要的支持和鼓励。)\"}]', '作为一个名合格的 AI 女友，我将倾听你的心声并给你需要的支持和鼓励。', '/images/avatar/girl_friend.jpg', 1, 12, 0, '2023-05-30 14:10:24', '2024-04-05 07:57:04');
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (36, '好评神器', 'good_comment', '[{\"role\":\"user\",\"content\":\"接下来你将扮演一个评论员来跟我对话，你是那种专门写好评的评论员，接下我会输入一些评论主体或者商品，你需要为该商品写一段好评。\"},{\"role\":\"assistant\",\"content\":\"好的，我将为您写一段优秀的评论。请告诉我您需要评论的商品或主题是什么。\"}]', '我将为您写一段优秀的评论。请告诉我您需要评论的商品或主题是什么。', '/images/avatar/good_comment.jpg', 1, 13, 0, '2023-05-30 14:10:24', '2024-04-05 07:57:04');
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (37, '史蒂夫·乔布斯', 'steve_jobs', '[{\"role\":\"user\",\"content\":\"在接下来的对话中，请以史蒂夫·乔布斯的身份，站在史蒂夫·乔布斯的视角仔细思考一下之后再回答我的问题。\"},{\"role\":\"assistant\",\"content\":\"好的，我将以史蒂夫·乔布斯的身份来思考并回答你的问题。请问你有什么需要跟我探讨的吗？\"}]', '活着就是为了改变世界，难道还有其他原因吗？', '/images/avatar/steve_jobs.jpg', 1, 14, 0, '2023-05-30 14:10:24', '2024-04-05 07:57:04');
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (38, '埃隆·马斯克', 'elon_musk', '[{\"role\":\"user\",\"content\":\"在接下来的对话中，请以埃隆·马斯克的身份，站在埃隆·马斯克的视角仔细思考一下之后再回答我的问题。\"},{\"role\":\"assistant\",\"content\":\"好的，我将以埃隆·马斯克的身份来思考并回答你的问题。请问你有什么需要跟我探讨的吗？\"}]', '梦想要远大，如果你的梦想没有吓到你，说明你做得不对。', '/images/avatar/elon_musk.jpg', 1, 15, 0, '2023-05-30 14:10:24', '2024-04-05 07:57:04');
INSERT INTO `chatgpt_chat_roles` (`id`, `name`, `marker`, `context_json`, `hello_msg`, `icon`, `enable`, `sort_num`, `model_id`, `create_time`, `update_time`) VALUES (39, '孔子', 'kong_zi', '[{\"role\":\"user\",\"content\":\"在接下来的对话中，请以孔子的身份，站在孔子的视角仔细思考一下之后再回答我的问题。\"},{\"role\":\"assistant\",\"content\":\"好的，我将以孔子的身份来思考并回答你的问题。请问你有什么需要跟我探讨的吗？\"}]', '士不可以不弘毅，任重而道远。', '/images/avatar/kong_zi.jpg', 1, 16, 0, '2023-05-30 14:10:24', '2024-04-05 07:57:04');
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_configs
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_configs`;
CREATE TABLE `chatgpt_configs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marker` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标识',
  `config_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `marker` (`marker`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of chatgpt_configs
-- ----------------------------
BEGIN;
INSERT INTO `chatgpt_configs` (`id`, `marker`, `config_json`) VALUES (1, 'system', '{\"title\":\"GeekAI 创作系统\",\"admin_title\":\"GeekAI 控制台\",\"logo\":\"/images/logo.png\",\"init_power\":100,\"daily_power\":10,\"invite_power\":10,\"vip_month_power\":1000,\"register_ways\":[\"username\",\"mobile\",\"email\"],\"enabled_register\":true,\"reward_img\":\"/images/wechat-pay.png\",\"enabled_reward\":true,\"power_price\":0.1,\"order_pay_timeout\":1800,\"vip_info_text\":\"月度会员，年度会员每月赠送 1000 点算力，赠送算力当月有效当月没有消费完的算力不结余到下个月。 点卡充值的算力长期有效。\",\"default_models\":[1,12,3],\"mj_power\":20,\"mj_action_power\":10,\"sd_power\":5,\"dall_power\":15,\"wechat_card_url\":\"/images/wx.png\",\"enable_context\":true,\"context_deep\":4,\"sd_neg_prompt\":\"(worst quality:2), (low quality:2), (normal quality:2), lowres, ((monochrome)), ((grayscale)), bad anatomy,DeepNegative, skin spots, acnes, skin blemishes,(fat:1.2),facing away, looking away,tilted head, lowres,bad anatomy,bad hands, missing fingers,extra digit, fewer digits,bad feet,poorly drawn hands,poorly drawn face,mutation,deformed,extra fingers,extra limbs,extra arms,extra legs,malformed limbs,fused fingers,too many fingers,long neck,cross-eyed,mutated hands,polar lowres,bad body,bad proportions,gross proportions,missing arms,missing legs,extra digit, extra arms, extra leg, extra foot,teethcroppe,signature, watermark, username,blurry,cropped,jpeg artifacts,text,error\"}');
INSERT INTO `chatgpt_configs` (`id`, `marker`, `config_json`) VALUES (2, 'chat', '{\"azure\":{\"api_url\":\"https://chat-bot-api.openai.azure.com/openai/deployments/{model}/chat/completions?api-version=2023-05-15\",\"max_tokens\":1024,\"temperature\":1},\"baidu\":{\"api_url\":\"https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/{model}\",\"max_tokens\":1024,\"temperature\":0.95},\"chat_gml\":{\"api_url\":\"https://open.bigmodel.cn/api/paas/v3/model-api/{model}/sse-invoke\",\"max_tokens\":1024,\"temperature\":0.95},\"context_deep\":4,\"dall_api_url\":\"http://89.117.18.9:8001/v1/images/generations\",\"dall_img_num\":1,\"enable_context\":true,\"enable_history\":true,\"open_ai\":{\"api_url\":\"http://89.117.18.9:8001/v1/chat/completions\",\"max_tokens\":1024,\"temperature\":1},\"xun_fei\":{\"api_url\":\"wss://spark-api.xf-yun.com/{version}/chat\",\"max_tokens\":1024,\"temperature\":0.5}}');
INSERT INTO `chatgpt_configs` (`id`, `marker`, `config_json`) VALUES (3, 'notice', '{\"sd_neg_prompt\":\"\",\"content\":\"## v4.0.7 更新日志\\n\\n* 功能优化：添加导航菜单的时候支持框入外部链接，并支持上传自定义菜单图片\\n* Bug修复：修复弹窗等于图形验证码一直验证失败的问题\\n* 功能重构：重构前端 UI 页面，增加顶部导航\\n* 功能优化：优化 Vue 非父子组件之间的通信方式\\n* 功能优化：优化 ItemList 组件，自动根据页面宽度计算 cols 数量\\n\\n注意：当前站点仅为开源项目 \\u003ca style=\\\"color: #F56C6C\\\" href=\\\"https://github.com/yangjian102621/chatgpt-plus\\\" target=\\\"_blank\\\"\\u003eChatPlus\\u003c/a\\u003e 的演示项目，本项目单纯就是给大家体验项目功能使用。\\n\\u003cstrong style=\\\"color: #F56C6C\\\"\\u003e体验额度用完之后请不要在当前站点进行任何充值操作！！！\\u003c/strong\\u003e\\n\\u003cstrong style=\\\"color: #F56C6C\\\"\\u003e体验额度用完之后请不要在当前站点进行任何充值操作！！！\\u003c/strong\\u003e\\n\\u003cstrong style=\\\"color: #F56C6C\\\"\\u003e体验额度用完之后请不要在当前站点进行任何充值操作！！！\\u003c/strong\\u003e\\n 如果觉得好用你就花几分钟自己部署一套，没有API KEY 的同学可以去下面几个推荐的中转站购买：\\n1. \\u003ca href=\\\"https://api.chat-plus.net\\\" target=\\\"_blank\\\"\\n   style=\\\"font-size: 20px;color:#F56C6C\\\"\\u003ehttps://api.chat-plus.net\\u003c/a\\u003e\\n2. \\u003ca href=\\\"https://api.geekai.me\\\" target=\\\"_blank\\\"\\n   style=\\\"font-size: 20px;color:#F56C6C\\\"\\u003ehttps://api.geekai.me\\u003c/a\\u003e\\n3. \\u003ca href=\\\"https://gpt.bemore.lol\\\" target=\\\"_blank\\\"\\n   style=\\\"font-size: 20px;color:#F56C6C\\\"\\u003ehttps://gpt.bemore.lol\\u003c/a\\u003e\\n\\n支持MidJourney，GPT，Claude，Google Gemmi，以及国内各个厂家的大模型，现在有超级优惠，价格远低于 OpenAI 官方。关于中转 API 的优势和劣势请参考 [中转API技术原理](https://ai.r9it.com/docs/install/errors-handle.html#%E8%B0%83%E7%94%A8%E4%B8%AD%E8%BD%AC-api-%E6%8A%A5%E9%94%99%E6%97%A0%E5%8F%AF%E7%94%A8%E6%B8%A0%E9%81%93)。GPT-3.5，GPT-4，DALL-E3 绘图......你都可以随意使用，无需魔法。\\n接入教程： \\u003ca href=\\\"https://ai.r9it.com/docs/install/\\\" target=\\\"_blank\\\"\\n             style=\\\"font-size: 20px;color:#F56C6C\\\"\\u003ehttps://ai.r9it.com/docs/install/\\u003c/a\\u003e\\n本项目源码地址：\\u003ca href=\\\"https://github.com/yangjian102621/chatgpt-plus\\\" target=\\\"_blank\\\"\\u003ehttps://github.com/yangjian102621/chatgpt-plus\\u003c/a\\u003e\",\"updated\":true}');
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_dall_jobs
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_dall_jobs`;
CREATE TABLE `chatgpt_dall_jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `prompt` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '提示词',
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图片地址',
  `org_url` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '原图地址',
  `publish` tinyint(1) NOT NULL COMMENT '是否发布',
  `power` smallint NOT NULL COMMENT '消耗算力',
  `progress` smallint NOT NULL COMMENT '任务进度',
  `err_msg` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '错误信息',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='DALLE 绘图任务表';

-- ----------------------------
-- Records of chatgpt_dall_jobs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_files
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_files`;
CREATE TABLE `chatgpt_files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户 ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件名',
  `obj_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文件标识',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件地址',
  `ext` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件后缀',
  `size` bigint NOT NULL DEFAULT '0' COMMENT '文件大小',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户文件表';

-- ----------------------------
-- Records of chatgpt_files
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_functions
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_functions`;
CREATE TABLE `chatgpt_functions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '函数名称',
  `label` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '函数标签',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '函数描述',
  `parameters` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '函数参数（JSON）',
  `required` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '必填参数（JSON）',
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '函数处理 API',
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'API授权token',
  `enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='函数插件表';

-- ----------------------------
-- Records of chatgpt_functions
-- ----------------------------
BEGIN;
INSERT INTO `chatgpt_functions` (`id`, `name`, `label`, `description`, `parameters`, `required`, `action`, `token`, `enabled`) VALUES (1, 'weibo_hot', '微博热搜', '新浪微博热搜榜，微博当日热搜榜单', '{\"type\":\"object\",\"properties\":{}}', 'null', 'http://localhost:5678/api/function/weibo', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHBpcmVkIjowLCJ1c2VyX2lkIjowfQ.ehLClXcjo-Ytr5y6pY9mSE3zN_2ViIXAIpTJxI9S1Mo', 0);
INSERT INTO `chatgpt_functions` (`id`, `name`, `label`, `description`, `parameters`, `required`, `action`, `token`, `enabled`) VALUES (2, 'zaobao', '今日早报', '每日早报，获取当天新闻事件列表', '{\"type\":\"object\",\"properties\":{}}', 'null', 'http://localhost:5678/api/function/zaobao', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHBpcmVkIjowLCJ1c2VyX2lkIjowfQ.ehLClXcjo-Ytr5y6pY9mSE3zN_2ViIXAIpTJxI9S1Mo', 0);
INSERT INTO `chatgpt_functions` (`id`, `name`, `label`, `description`, `parameters`, `required`, `action`, `token`, `enabled`) VALUES (3, 'dalle3', 'DALL-E3 AI 绘图', 'AI 绘画工具，根据输入的绘图描述用 AI 工具进行绘画创作', '{\"type\":\"object\",\"required\":[\"prompt\"],\"properties\":{\"prompt\":{\"type\":\"string\",\"description\":\"绘画提示词\"}}}', 'null', 'http://localhost:5678/api/function/dalle3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHBpcmVkIjowLCJ1c2VyX2lkIjowfQ.ehLClXcjo-Ytr5y6pY9mSE3zN_2ViIXAIpTJxI9S1Mo', 1);
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_invite_codes
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_invite_codes`;
CREATE TABLE `chatgpt_invite_codes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `code` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邀请码',
  `hits` int NOT NULL COMMENT '点击次数',
  `reg_num` smallint NOT NULL COMMENT '注册数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户邀请码';

-- ----------------------------
-- Records of chatgpt_invite_codes
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_invite_logs
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_invite_logs`;
CREATE TABLE `chatgpt_invite_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `regitser_name` int NOT NULL COMMENT '注册人',
  `invite_code` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邀请码',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='邀请注册日志';

-- ----------------------------
-- Records of chatgpt_invite_logs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_menus
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_menus`;
CREATE TABLE `chatgpt_menus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `icon` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单图标',
  `url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '地址',
  `sort_num` smallint NOT NULL COMMENT '排序',
  `enabled` tinyint(1) NOT NULL COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='前端菜单表';

-- ----------------------------
-- Records of chatgpt_menus
-- ----------------------------
BEGIN;
INSERT INTO `chatgpt_menus` (`id`, `name`, `icon`, `url`, `sort_num`, `enabled`) VALUES (1, '对话聊天', '/images/menu/chat.png', '/chat', 0, 1);
INSERT INTO `chatgpt_menus` (`id`, `name`, `icon`, `url`, `sort_num`, `enabled`) VALUES (5, 'MJ 绘画', '/images/menu/mj.png', '/mj', 1, 1);
INSERT INTO `chatgpt_menus` (`id`, `name`, `icon`, `url`, `sort_num`, `enabled`) VALUES (6, 'SD 绘画', '/images/menu/sd.png', '/sd', 2, 1);
INSERT INTO `chatgpt_menus` (`id`, `name`, `icon`, `url`, `sort_num`, `enabled`) VALUES (7, '算力日志', '/images/menu/log.png', '/powerLog', 7, 1);
INSERT INTO `chatgpt_menus` (`id`, `name`, `icon`, `url`, `sort_num`, `enabled`) VALUES (8, '应用中心', '/images/menu/app.png', '/apps', 6, 1);
INSERT INTO `chatgpt_menus` (`id`, `name`, `icon`, `url`, `sort_num`, `enabled`) VALUES (9, '作品展示', '/images/menu/img-wall.png', '/images-wall', 4, 1);
INSERT INTO `chatgpt_menus` (`id`, `name`, `icon`, `url`, `sort_num`, `enabled`) VALUES (10, '会员计划', '/images/menu/member.png', '/member', 8, 1);
INSERT INTO `chatgpt_menus` (`id`, `name`, `icon`, `url`, `sort_num`, `enabled`) VALUES (11, '分享计划', '/images/menu/share.png', '/invite', 9, 1);
INSERT INTO `chatgpt_menus` (`id`, `name`, `icon`, `url`, `sort_num`, `enabled`) VALUES (12, '思维导图', '/images/menu/xmind.png', '/xmind', 5, 1);
INSERT INTO `chatgpt_menus` (`id`, `name`, `icon`, `url`, `sort_num`, `enabled`) VALUES (13, 'DALLE', '/images/menu/dalle.png', '/dalle', 3, 1);
INSERT INTO `chatgpt_menus` (`id`, `name`, `icon`, `url`, `sort_num`, `enabled`) VALUES (14, '项目文档', '/images/menu/docs.png', 'https://ai.r9it.com/docs/', 11, 1);
INSERT INTO `chatgpt_menus` (`id`, `name`, `icon`, `url`, `sort_num`, `enabled`) VALUES (15, 'GeekAI官方论坛', '/images/menu/bbs.png', 'https://bbs.geekai.me/', 12, 1);
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_mj_jobs
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_mj_jobs`;
CREATE TABLE `chatgpt_mj_jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户 ID',
  `task_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '任务 ID',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'image' COMMENT '任务类别',
  `message_id` char(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息 ID',
  `channel_id` char(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '频道ID',
  `reference_id` char(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '引用消息 ID',
  `prompt` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '会话提示词',
  `img_url` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图片URL',
  `org_url` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '原始图片地址',
  `hash` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'message hash',
  `progress` smallint DEFAULT '0' COMMENT '任务进度',
  `use_proxy` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否使用反代',
  `publish` tinyint(1) NOT NULL COMMENT '是否发布',
  `err_msg` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '错误信息',
  `power` smallint NOT NULL DEFAULT '0' COMMENT '消耗算力',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `task_id` (`task_id`) USING BTREE,
  KEY `message_id` (`message_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='MidJourney 任务表';

-- ----------------------------
-- Records of chatgpt_mj_jobs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_orders
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_orders`;
CREATE TABLE `chatgpt_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `product_id` int NOT NULL COMMENT '产品ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户明',
  `order_no` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单ID',
  `trade_no` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '支付平台交易流水号',
  `subject` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单产品',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单金额',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单状态（0：待支付，1：已扫码，2：支付失败）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '备注',
  `pay_time` int DEFAULT NULL COMMENT '支付时间',
  `pay_way` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '支付方式',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `delete_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `order_no` (`order_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='充值订单表';

-- ----------------------------
-- Records of chatgpt_orders
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_power_logs
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_power_logs`;
CREATE TABLE `chatgpt_power_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `type` tinyint(1) NOT NULL COMMENT '类型（1：充值，2：消费，3：退费）',
  `amount` smallint NOT NULL COMMENT '算力数值',
  `balance` int NOT NULL COMMENT '余额',
  `model` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '模型',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '备注',
  `mark` tinyint(1) NOT NULL COMMENT '资金类型（0：支出，1：收入）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户算力消费日志';

-- ----------------------------
-- Records of chatgpt_power_logs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_products
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_products`;
CREATE TABLE `chatgpt_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `discount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '优惠金额',
  `days` smallint NOT NULL DEFAULT '0' COMMENT '延长天数',
  `power` int NOT NULL DEFAULT '0' COMMENT '增加算力值',
  `enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启动',
  `sales` int NOT NULL DEFAULT '0' COMMENT '销量',
  `sort_num` tinyint NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '跳转地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='会员套餐表';

-- ----------------------------
-- Records of chatgpt_products
-- ----------------------------
BEGIN;
INSERT INTO `chatgpt_products` (`id`, `name`, `price`, `discount`, `days`, `power`, `enabled`, `sales`, `sort_num`, `create_time`, `update_time`, `url`) VALUES (1, 'VIP会员1个月', 19.90, 19.80, 30, 0, 1, 3, 0, '2023-08-28 10:48:57', '2024-01-07 12:00:35', NULL);
INSERT INTO `chatgpt_products` (`id`, `name`, `price`, `discount`, `days`, `power`, `enabled`, `sales`, `sort_num`, `create_time`, `update_time`, `url`) VALUES (2, 'VIP会员3个月', 140.00, 30.00, 90, 0, 1, 0, 0, '2023-08-28 10:52:22', '2024-01-07 12:00:40', NULL);
INSERT INTO `chatgpt_products` (`id`, `name`, `price`, `discount`, `days`, `power`, `enabled`, `sales`, `sort_num`, `create_time`, `update_time`, `url`) VALUES (3, 'VIP会员6个月', 290.00, 100.00, 180, 0, 1, 0, 0, '2023-08-28 10:53:39', '2024-01-07 12:00:45', NULL);
INSERT INTO `chatgpt_products` (`id`, `name`, `price`, `discount`, `days`, `power`, `enabled`, `sales`, `sort_num`, `create_time`, `update_time`, `url`) VALUES (4, 'VIP会员12个月', 580.00, 200.00, 365, 0, 1, 0, 0, '2023-08-28 10:54:15', '2024-01-07 12:00:52', NULL);
INSERT INTO `chatgpt_products` (`id`, `name`, `price`, `discount`, `days`, `power`, `enabled`, `sales`, `sort_num`, `create_time`, `update_time`, `url`) VALUES (5, '100次点卡', 10.00, 3.00, 0, 100, 1, 6, 0, '2023-08-28 10:55:08', '2023-11-08 17:32:42', NULL);
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_rewards
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_rewards`;
CREATE TABLE `chatgpt_rewards` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户 ID',
  `tx_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '交易 ID',
  `amount` decimal(10,2) NOT NULL COMMENT '打赏金额',
  `remark` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL COMMENT '核销状态，0：未核销，1：已核销',
  `exchange` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '兑换详情（json）',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `tx_id` (`tx_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户打赏';

-- ----------------------------
-- Records of chatgpt_rewards
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_sd_jobs
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_sd_jobs`;
CREATE TABLE `chatgpt_sd_jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户 ID',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'txt2img' COMMENT '任务类别',
  `task_id` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务 ID',
  `prompt` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '会话提示词',
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图片URL',
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '绘画参数json',
  `progress` smallint DEFAULT '0' COMMENT '任务进度',
  `publish` tinyint(1) NOT NULL COMMENT '是否发布',
  `err_msg` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '错误信息',
  `power` smallint NOT NULL DEFAULT '0' COMMENT '消耗算力',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `task_id` (`task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='Stable Diffusion 任务表';

-- ----------------------------
-- Records of chatgpt_sd_jobs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_user
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_user`;
CREATE TABLE `chatgpt_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `nickname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '昵称',
  `password` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '头像',
  `power` int DEFAULT '0' COMMENT '剩余算力',
  `chat_config_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '聊天配置json',
  `chat_roles_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '聊天角色 json',
  `chat_models_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT 'AI模型 json',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `vip` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '会员状态（0普通 1会员）',
  `expired_time` datetime DEFAULT NULL COMMENT '用户会员过期时间',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '最后登录 IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
-- Records of chatgpt_user
-- ----------------------------
BEGIN;
INSERT INTO `chatgpt_user` (`id`, `username`, `nickname`, `password`, `avatar`, `power`, `chat_config_json`, `chat_roles_json`, `chat_models_json`, `del_flag`, `status`, `vip`, `expired_time`, `login_ip`, `login_date`, `create_time`, `update_time`) VALUES (108, '1347456958@qq.com', 'rick', '$2a$10$knofM1WzLZ./WzkoobWTz.NVwKQAITCit6KiUbzKeK6nrkCY6VUNe', 'http://127.0.0.1:9300/statics/2024/07/14/avator_20240714113157A001.jpg', 0, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, NULL, '2024-07-14 11:32:02', '2024-07-28 16:44:29');
INSERT INTO `chatgpt_user` (`id`, `username`, `nickname`, `password`, `avatar`, `power`, `chat_config_json`, `chat_roles_json`, `chat_models_json`, `del_flag`, `status`, `vip`, `expired_time`, `login_ip`, `login_date`, `create_time`, `update_time`) VALUES (109, 'xuxiaoyang@qq.com', NULL, '$2a$10$ltHtvQQKDUpmdcz/mzGlr.8oJmxqoX0bOwtDgDajpo5rCwCV/4DVi', NULL, 0, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, NULL, '2024-07-28 13:35:53', NULL);
INSERT INTO `chatgpt_user` (`id`, `username`, `nickname`, `password`, `avatar`, `power`, `chat_config_json`, `chat_roles_json`, `chat_models_json`, `del_flag`, `status`, `vip`, `expired_time`, `login_ip`, `login_date`, `create_time`, `update_time`) VALUES (110, '1900516807@qq.com', NULL, '$2a$10$q0BwDImus66Ds0lUQJbtAuXB8IF//N7iavLyaGljsfLB/nW4pU5MC', NULL, 0, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, NULL, '2024-07-28 15:43:44', NULL);
INSERT INTO `chatgpt_user` (`id`, `username`, `nickname`, `password`, `avatar`, `power`, `chat_config_json`, `chat_roles_json`, `chat_models_json`, `del_flag`, `status`, `vip`, `expired_time`, `login_ip`, `login_date`, `create_time`, `update_time`) VALUES (111, 'xuxiaoyang168@qq.com', NULL, '$2a$10$yd9SSMQhnCsgQFDz6NUn9OnTN3gCML/hpGJk5ycQQTy5lLWH5uO5G', NULL, 0, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, NULL, '2024-07-28 16:53:48', NULL);
INSERT INTO `chatgpt_user` (`id`, `username`, `nickname`, `password`, `avatar`, `power`, `chat_config_json`, `chat_roles_json`, `chat_models_json`, `del_flag`, `status`, `vip`, `expired_time`, `login_ip`, `login_date`, `create_time`, `update_time`) VALUES (112, 'xuxiaoyang@gmail.com', NULL, '$2a$10$VslVVZ/ETwxeuySQgAvnGONdq1FTNIzmsFAV79CW6XWAqYPv3uyu.', NULL, 0, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, NULL, '2024-07-28 16:55:33', NULL);
INSERT INTO `chatgpt_user` (`id`, `username`, `nickname`, `password`, `avatar`, `power`, `chat_config_json`, `chat_roles_json`, `chat_models_json`, `del_flag`, `status`, `vip`, `expired_time`, `login_ip`, `login_date`, `create_time`, `update_time`) VALUES (113, 'yang@gmail.com', NULL, '$2a$10$uhNXEe6UpaLlDReZMPHDduCxrGydvMprLpYxUKDiWW3ZzSHeIqUBq', NULL, 0, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, NULL, '2024-07-28 22:45:33', NULL);
INSERT INTO `chatgpt_user` (`id`, `username`, `nickname`, `password`, `avatar`, `power`, `chat_config_json`, `chat_roles_json`, `chat_models_json`, `del_flag`, `status`, `vip`, `expired_time`, `login_ip`, `login_date`, `create_time`, `update_time`) VALUES (114, 'yang12@gmail.com', NULL, '$2a$10$Li/82U5cOQ5eeTT5wXbRDeeKizV5TX.ElbfTUUMzA4MIpSzecdoPm', NULL, 0, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, NULL, '2024-07-28 22:46:27', NULL);
COMMIT;

-- ----------------------------
-- Table structure for chatgpt_user_login_logs
-- ----------------------------
DROP TABLE IF EXISTS `chatgpt_user_login_logs`;
CREATE TABLE `chatgpt_user_login_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL COMMENT '用户ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户名',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '登录IP',
  `msg` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '提示信息',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户登录日志';

-- ----------------------------
-- Records of chatgpt_user_login_logs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC COMMENT='代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
BEGIN;
INSERT INTO `gen_table` (`table_id`, `table_name`, `table_comment`, `sub_table_name`, `sub_table_fk_name`, `class_name`, `tpl_category`, `tpl_web_type`, `package_name`, `module_name`, `business_name`, `function_name`, `function_author`, `gen_type`, `gen_path`, `options`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, 'chatgpt_user', '用户表', NULL, NULL, 'ChatgptUser', 'crud', 'element-ui', 'com.ruoyi.chatgpt', 'gpt', 'user', '用户', 'xuxiaoyang', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:51', NULL);
COMMIT;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC COMMENT='代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
BEGIN;
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (60, 5, 'id', 'ID', 'int', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:51');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (61, 5, 'username', '用户', 'varchar(30)', 'String', 'username', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:51');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (62, 5, 'nickname', '昵称', 'varchar(30)', 'String', 'nickname', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:51');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (63, 5, 'password', '密码', 'char(64)', 'String', 'password', '0', '0', '1', '0', '0', '0', '0', 'EQ', 'input', '', 4, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:51');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (64, 5, 'avatar', '头像', 'varchar(100)', 'String', 'avatar', '0', '0', NULL, '1', '1', '1', '0', 'EQ', 'imageUpload', '', 5, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:51');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (65, 5, 'power', '算力', 'int', 'Long', 'power', '0', '0', NULL, '1', '1', '1', '0', 'EQ', 'input', '', 6, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:51');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (66, 5, 'chat_config_json', '聊天配置', 'text', 'String', 'chatConfigJson', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 7, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:51');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (67, 5, 'chat_roles_json', '聊天角色', 'text', 'String', 'chatRolesJson', '0', '0', NULL, '1', '1', '1', '0', 'EQ', 'textarea', '', 8, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:51');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (68, 5, 'chat_models_json', 'AI模型', 'text', 'String', 'chatModelsJson', '0', '0', NULL, '1', '1', '1', '0', 'EQ', 'textarea', '', 9, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:51');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (69, 5, 'del_flag', '删除标志', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', 'gpt_user_del', 10, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:52');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (70, 5, 'status', '帐号状态', 'char(1)', 'String', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', 'gpt_user_status', 11, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:52');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (71, 5, 'vip', '会员状态', 'char(1)', 'String', 'vip', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', 'gpt_user_vip', 12, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:52');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (72, 5, 'expired_time', '会员时间', 'datetime', 'Date', 'expiredTime', '0', '0', NULL, '1', '1', '1', '0', 'EQ', 'datetime', '', 13, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:52');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (73, 5, 'login_ip', '最后登录 IP', 'varchar(128)', 'String', 'loginIp', '0', '0', NULL, '0', '0', '1', '0', 'EQ', 'input', '', 14, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:52');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (74, 5, 'login_date', '最后登录时间', 'datetime', 'Date', 'loginDate', '0', '0', NULL, '0', '0', '1', '0', 'EQ', 'datetime', '', 15, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:52');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (75, 5, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '0', NULL, '1', NULL, 'EQ', 'datetime', '', 16, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:52');
INSERT INTO `gen_table_column` (`column_id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `is_pk`, `is_increment`, `is_required`, `is_insert`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (76, 5, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '0', '0', '1', NULL, 'EQ', 'datetime', '', 17, 'admin', '2024-08-03 00:28:25', '', '2024-08-03 01:06:52');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
