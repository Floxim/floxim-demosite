-- phpMyAdmin SQL Dump
-- version 4.0.10
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1:3306
-- Время создания: Окт 21 2014 г., 20:27
-- Версия сервера: 5.5.38-log
-- Версия PHP: 5.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `fxpsr_loc`
--

-- --------------------------------------------------------

--
-- Структура таблицы `fx_component`
--

CREATE TABLE IF NOT EXISTS `fx_component` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) NOT NULL,
  `name_en` varchar(255) NOT NULL,
  `description_en` text COMMENT 'Описание компонента',
  `group` varchar(64) NOT NULL DEFAULT 'Main',
  `icon` varchar(255) NOT NULL,
  `store_id` text,
  `parent_id` int(11) DEFAULT NULL,
  `item_name_en` varchar(45) DEFAULT NULL,
  `name_ru` varchar(255) DEFAULT NULL,
  `item_name_ru` varchar(255) DEFAULT NULL,
  `description_ru` text,
  `vendor` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Class_Group` (`group`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=100 AUTO_INCREMENT=82 ;

--
-- Дамп данных таблицы `fx_component`
--

INSERT INTO `fx_component` (`id`, `keyword`, `name_en`, `description_en`, `group`, `icon`, `store_id`, `parent_id`, `item_name_en`, `name_ru`, `item_name_ru`, `description_ru`, `vendor`) VALUES
(1, 'user', 'Users', '', '', '', 'component.user', 36, 'User', 'Пользователи', 'Пользователь', '', ''),
(19, 'text', 'Text', '', '', '', 'component.text', 36, 'text', 'Текст', 'Текст', '', ''),
(23, 'page', 'Pages', '', '', '', NULL, 36, 'page', 'Страницы', 'Страница', '', ''),
(24, 'section', 'Sections', '', '', '', NULL, 23, 'Section', 'Разделы', 'Раздел', '', ''),
(36, 'content', 'Content', '', 'Basic', '', NULL, 0, 'Content', 'Контент', 'Контент', NULL, ''),
(48, 'photo', 'Photos', '', '', '', NULL, 36, 'Photo', 'Фото', 'Фото', '', ''),
(49, 'publication', 'Publications', NULL, '', '', NULL, 23, 'Publication', 'Публикации', 'Публикация', '', ''),
(50, 'comment', 'Comment', NULL, '', '', NULL, 36, 'comment', 'Комментарии', 'Комментарий', '', ''),
(59, 'video', 'Video', NULL, '', '', NULL, 36, 'Video', 'Видео', 'Видео', '', ''),
(62, 'project', 'Project', NULL, '', '', NULL, 23, 'Project', 'Проекты', 'Проект', '', ''),
(63, 'vacancy', 'Vacancy', NULL, '', '', NULL, 23, 'Vacancy', 'Вакансии', 'Вакансия', '', ''),
(64, 'classifier', 'Classifier', '', '', '', NULL, 23, 'Classifier', 'Классификаторы', 'Классификатор', '', ''),
(65, 'classifier_linker', 'Classifier Linker', NULL, '', '', NULL, 36, 'Classifier Linker', 'Привязка к классификатору', 'Привязка к классификатору', '', ''),
(68, 'news', 'News', NULL, '', '', NULL, 49, 'News', 'Новости', 'Новость', '', ''),
(69, 'person', 'Person', NULL, '', '', NULL, 23, 'Person', 'Персоналии', 'Персона', '', ''),
(70, 'contact', 'Contact', NULL, '', '', NULL, 36, 'Contact', 'Контакты', 'Контакт', '', ''),
(75, 'product', 'Product', NULL, '', '', NULL, 23, 'Product', 'Продукты', 'Продукт', '', ''),
(77, 'linker', 'Linker', NULL, '', '', NULL, 36, 'Linker', 'Привязка', 'Привязка', '', ''),
(78, 'tag', 'Tag', NULL, '', '', NULL, 64, 'Tag', 'Теги', 'Тег', '', ''),
(80, 'message_template', 'Message templates', NULL, 'Main', '', NULL, 36, 'Message template', 'Шаблоны сообщений', 'Шаблон сообщения', '', ''),
(81, 'mail_template', 'Mail templates', NULL, 'Main', '', NULL, 80, 'Mail template', 'Почтовые шаблоны', 'Почтовый шаблон', '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content`
--

CREATE TABLE IF NOT EXISTS `fx_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `priority` int(11) NOT NULL DEFAULT '0',
  `checked` tinyint(4) NOT NULL DEFAULT '1',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `type` varchar(45) NOT NULL,
  `infoblock_id` int(11) NOT NULL,
  `site_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `materialized_path` varchar(255) NOT NULL,
  `level` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `materialized_path` (`materialized_path`,`level`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=47 AUTO_INCREMENT=2770 ;

--
-- Дамп данных таблицы `fx_content`
--

INSERT INTO `fx_content` (`id`, `priority`, `checked`, `created`, `last_updated`, `user_id`, `type`, `infoblock_id`, `site_id`, `parent_id`, `materialized_path`, `level`) VALUES
(2367, 135, 1, '2013-10-21 15:21:23', '2014-04-14 14:53:26', 99, 'user', 0, NULL, NULL, '', 0),
(2635, 216, 1, '2014-01-28 11:39:50', '2014-01-28 07:39:50', 2367, 'page', 0, 18, NULL, '', 0),
(2636, 217, 1, '2014-01-28 11:39:50', '2014-04-15 08:42:07', 2367, 'page', 0, 18, 2635, '2635.', 1),
(2638, 3, 1, '2014-01-28 12:04:17', '2014-07-18 15:21:56', 2367, 'section', 346, 18, 2635, '2635.', 1),
(2639, 2, 1, '2014-01-28 12:04:33', '2014-07-18 15:21:56', 2367, 'section', 346, 18, 2635, '2635.', 1),
(2640, 1, 1, '2014-01-28 12:07:04', '2014-07-14 01:56:36', 2367, 'section', 346, 18, 2635, '2635.', 1),
(2641, 2, 1, '2014-01-28 12:07:17', '2014-07-18 21:45:40', 2367, 'section', 346, 18, 2640, '2635.2640.', 2),
(2652, 4, 1, '2014-01-30 13:34:21', '2014-07-14 13:23:53', 2367, 'section', 346, 18, 2638, '2635.2638.', 2),
(2654, 2, 1, '2014-01-30 13:34:34', '2014-07-21 16:37:11', 2367, 'section', 346, 18, 2638, '2635.2638.', 2),
(2655, 1, 1, '2014-01-30 13:38:14', '2014-07-18 21:43:19', 2367, 'section', 346, 18, 2640, '2635.2640.', 2),
(2656, 4, 1, '2014-01-30 13:38:26', '2014-07-18 21:42:56', 2367, 'section', 346, 18, 2640, '2635.2640.', 2),
(2657, 3, 1, '2014-01-30 13:38:46', '2014-07-18 21:45:40', 2367, 'section', 346, 18, 2640, '2635.2640.', 2),
(2658, 1, 1, '2014-01-30 14:00:50', '2014-07-18 16:03:34', 2367, 'section', 346, 18, 2638, '2635.2638.', 2),
(2659, 0, 1, '2014-01-30 14:07:10', '2014-09-12 13:26:11', 2367, 'linker', 362, 18, 2638, '2635.2638.', 2),
(2660, 230, 1, '2014-01-30 14:38:47', '2014-04-16 15:55:11', 2367, 'product', 364, 18, 2652, '2635.2638.2652.', 3),
(2661, 231, 1, '2014-01-30 14:40:14', '2014-04-16 15:55:11', 2367, 'product', 364, 18, 2652, '2635.2638.2652.', 3),
(2662, 232, 1, '2014-01-30 14:42:35', '2014-04-16 15:55:11', 2367, 'product', 364, 18, 2652, '2635.2638.2652.', 3),
(2668, 2, 1, '2014-01-30 15:08:08', '2014-09-12 13:26:11', 2367, 'linker', 370, 18, 2635, '2635.', 1),
(2671, 2, 1, '2014-02-13 15:14:27', '2014-10-15 07:30:50', 2367, 'person', 372, 18, 2655, '2635.2640.2655.', 3),
(2673, 3, 1, '2014-01-30 15:19:09', '2014-10-15 07:30:50', 2367, 'person', 372, 18, 2655, '2635.2640.2655.', 3),
(2675, 1, 1, '2014-01-30 15:19:48', '2014-10-15 07:30:50', 2367, 'person', 372, 18, 2655, '2635.2640.2655.', 3),
(2677, 15, 1, '2014-01-30 15:33:49', '2014-07-24 20:18:00', 2367, 'vacancy', 374, 18, 2656, '2635.2640.2656.', 3),
(2678, 237, 1, '2014-01-30 15:37:21', '2014-06-02 11:10:29', 2367, 'news', 379, 18, 2657, '2635.2640.2657.', 3),
(2679, 238, 1, '2014-01-30 15:38:00', '2014-06-02 11:10:29', 2367, 'news', 379, 18, 2657, '2635.2640.2657.', 3),
(2680, 239, 1, '2014-01-30 15:39:49', '2014-06-02 11:10:29', 2367, 'news', 379, 18, 2657, '2635.2640.2657.', 3),
(2681, 240, 1, '2014-01-30 15:40:08', '2014-06-02 11:10:29', 2367, 'news', 379, 18, 2657, '2635.2640.2657.', 3),
(2684, 1, 1, '2014-01-30 15:41:45', '2014-09-12 13:26:11', 2367, 'linker', 381, 18, 2635, '2635.', 1),
(2688, 4, 1, '2014-01-30 16:20:08', '2014-07-14 21:51:59', 2367, 'project', 385, 18, 2639, '2635.2639.', 2),
(2690, 2, 1, '2014-01-30 16:25:46', '2014-07-14 21:51:17', 2367, 'project', 385, 18, 2639, '2635.2639.', 2),
(2692, 1, 1, '2014-01-31 18:14:59', '2014-05-20 08:26:14', 2367, 'photo', 389, 18, 2688, '2635.2639.2688.', 3),
(2693, 3, 1, '2014-01-31 18:16:05', '2014-05-20 08:26:14', 2367, 'photo', 389, 18, 2688, '2635.2639.2688.', 3),
(2694, 0, 1, '2014-01-31 18:27:50', '2014-09-12 13:26:11', 2367, 'linker', 391, 18, 2640, '2635.2640.', 2),
(2701, 1, 1, '2014-01-31 19:09:46', '2014-04-21 10:23:45', 2367, 'text', 397, 18, 2641, '2635.2640.2641.', 3),
(2728, 260, 1, '2014-03-07 18:51:44', '2014-03-07 14:51:44', 2367, 'tag', 0, 18, NULL, '', 0),
(2729, 260, 1, '2014-03-07 18:51:44', '2014-06-02 11:10:29', 2367, 'classifier_linker', 0, 18, 2678, '2635.2640.2657.', 4),
(2730, 261, 1, '2014-03-08 07:08:29', '2014-06-02 11:10:29', 2367, 'classifier_linker', 0, 18, 2679, '2635.2640.2657.', 4),
(2731, 261, 1, '2014-03-08 07:08:29', '2014-03-08 03:08:30', 2367, 'tag', 0, 18, NULL, '', 0),
(2732, 261, 1, '2014-03-08 07:08:29', '2014-06-02 11:10:29', 2367, 'classifier_linker', 0, 18, 2679, '2635.2640.2657.', 4),
(2733, 262, 1, '2014-03-11 15:59:01', '2014-03-11 11:59:01', 2367, 'tag', 0, 18, NULL, '', 0),
(2734, 262, 1, '2014-03-11 15:59:01', '2014-06-02 11:10:29', 2367, 'classifier_linker', 0, 18, 2681, '2635.2640.2657.', 4),
(2735, 4, 1, '2014-03-11 16:15:11', '2014-10-15 07:30:50', 2367, 'person', 372, 18, 2655, '2635.2640.2655.', 3),
(2737, 1, 1, '2014-03-11 17:08:49', '2014-07-14 15:02:43', 2367, 'vacancy', 374, 18, 2656, '2635.2640.2656.', 3),
(2739, 265, 1, '2014-03-11 21:44:50', '2014-04-16 15:55:11', 2367, 'product', 364, 18, 2652, '2635.2638.2652.', 3),
(2740, 266, 1, '2014-03-11 21:49:15', '2014-04-15 08:42:09', 2367, 'product', 364, 18, 2654, '2635.2638.2654.', 3),
(2741, 267, 1, '2014-03-11 21:50:58', '2014-04-15 08:42:09', 2367, 'product', 364, 18, 2654, '2635.2638.2654.', 3),
(2742, 268, 1, '2014-03-11 21:56:32', '2014-04-15 08:42:09', 2367, 'product', 364, 18, 2658, '2635.2638.2658.', 3),
(2743, 269, 1, '2014-03-11 21:58:20', '2014-04-15 08:42:09', 2367, 'product', 364, 18, 2658, '2635.2638.2658.', 3),
(2744, 3, 1, '2014-03-11 21:59:51', '2014-07-21 16:37:11', 2367, 'section', 346, 18, 2638, '2635.2638.', 2),
(2745, 2, 1, '2014-03-11 22:01:34', '2014-07-10 13:02:43', 2367, 'product', 364, 18, 2744, '2635.2638.2744.', 3),
(2746, 1, 1, '2014-03-11 22:02:45', '2014-07-10 13:02:43', 2367, 'product', 364, 18, 2744, '2635.2638.2744.', 3),
(2747, 3, 1, '2014-03-12 05:01:05', '2014-09-12 13:26:11', 2367, 'linker', 370, 18, 2635, '2635.', 1),
(2748, 1, 1, '2014-03-12 05:01:05', '2014-09-12 13:26:11', 2367, 'linker', 370, 18, 2635, '2635.', 1),
(2749, 0, 1, '2014-03-12 05:02:10', '2014-09-12 13:26:11', 2367, 'linker', 369, 18, 2635, '2635.', 1),
(2750, 2, 1, '2014-03-14 14:09:54', '2014-05-20 08:26:14', 2367, 'photo', 389, 18, 2688, '2635.2639.2688.', 3),
(2751, 3, 1, '2014-03-14 18:24:30', '2014-07-14 21:51:59', 2367, 'project', 385, 18, 2639, '2635.2639.', 2),
(2752, 275, 1, '2014-03-14 18:26:57', '2014-04-15 08:42:09', 2367, 'photo', 389, 18, 2751, '2635.2639.2751.', 3),
(2753, 276, 1, '2014-03-14 18:27:36', '2014-04-15 08:42:09', 2367, 'photo', 389, 18, 2751, '2635.2639.2751.', 3),
(2754, 277, 1, '2014-03-14 18:28:13', '2014-04-15 08:42:09', 2367, 'photo', 389, 18, 2751, '2635.2639.2751.', 3),
(2755, 278, 1, '2014-03-14 18:31:09', '2014-04-15 08:42:09', 2367, 'photo', 389, 18, 2690, '2635.2639.2690.', 3),
(2756, 279, 1, '2014-03-14 18:31:52', '2014-04-15 08:42:09', 2367, 'photo', 389, 18, 2690, '2635.2639.2690.', 3),
(2757, 1, 1, '2014-03-14 18:34:09', '2014-07-14 21:51:17', 2367, 'project', 385, 18, 2639, '2635.2639.', 2),
(2762, 280, 1, '2014-05-04 13:43:11', '2014-05-04 09:43:11', 2367, 'mail_template', 0, 18, 0, '.', 1),
(2764, 0, 1, '2014-05-04 15:40:55', '2014-09-12 13:26:11', 2367, 'linker', 381, 18, 2635, '2635.', 1),
(2765, 0, 1, '2014-05-05 00:44:29', '2014-09-12 13:26:11', 2367, 'linker', 411, 18, 2635, '2635.', 1),
(2767, 2, 1, '2014-05-06 11:26:33', '2014-05-06 07:26:33', 2367, 'text', 397, 18, 2641, '2635.2640.2641.', 3),
(2768, 2, 1, '2014-07-18 12:28:52', '2014-09-12 13:26:11', 2367, 'linker', 381, 18, 2635, '2635.', 1),
(2769, 3, 1, '2014-07-18 12:31:17', '2014-09-12 13:26:11', 2367, 'linker', 381, 18, 2635, '2635.', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_classifier`
--

CREATE TABLE IF NOT EXISTS `fx_content_classifier` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `fx_content_classifier`
--

INSERT INTO `fx_content_classifier` (`id`) VALUES
(2728),
(2731),
(2733);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_classifier_linker`
--

CREATE TABLE IF NOT EXISTS `fx_content_classifier_linker` (
  `id` int(11) NOT NULL,
  `classifier_id` int(11) DEFAULT NULL,
  `content_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `fx_content_classifier_linker`
--

INSERT INTO `fx_content_classifier_linker` (`id`, `classifier_id`, `content_id`) VALUES
(2729, 2728, 2678),
(2730, 2728, 2679),
(2732, 2731, 2679),
(2734, 2733, 2681);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_comment`
--

CREATE TABLE IF NOT EXISTS `fx_content_comment` (
  `id` int(11) NOT NULL,
  `comment_text` text,
  `publish_date` datetime DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `is_moderated` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_contact`
--

CREATE TABLE IF NOT EXISTS `fx_content_contact` (
  `id` int(11) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `contact_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_linker`
--

CREATE TABLE IF NOT EXISTS `fx_content_linker` (
  `id` int(11) NOT NULL,
  `linked_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `fx_content_linker`
--

INSERT INTO `fx_content_linker` (`id`, `linked_id`) VALUES
(2659, 2652),
(2668, 2660),
(2684, 2680),
(2694, 2656),
(2747, 2746),
(2748, 2743),
(2749, 2740),
(2764, 2678),
(2765, 2638),
(2768, 2679),
(2769, 2681);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_mail_template`
--

CREATE TABLE IF NOT EXISTS `fx_content_mail_template` (
  `id` int(11) NOT NULL,
  `from` varchar(255) DEFAULT NULL,
  `bcc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `fx_content_mail_template`
--

INSERT INTO `fx_content_mail_template` (`id`, `from`, `bcc`) VALUES
(2762, 'Floxim Robot <robot@floxim.org>', 'dubr.cola@gmail.com, dubrowsky@yandex.ru');

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_message_template`
--

CREATE TABLE IF NOT EXISTS `fx_content_message_template` (
  `id` int(11) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text,
  `language_id` int(11) DEFAULT NULL,
  `keyword` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `fx_content_message_template`
--

INSERT INTO `fx_content_message_template` (`id`, `subject`, `message`, `language_id`, `keyword`) VALUES
(2762, 'Your new password on {$site.name}', '<p>\r\n	Hello, {$user.name}!\r\n</p>\r\n<p>\r\n	Your new password is <strong>{$password}</strong>\r\n</p>\r\n<hr>\r\n<p>\r\n	Best regards, {$site.name} administration.\r\n</p>', 1, 'user.password_recover');

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_news`
--

CREATE TABLE IF NOT EXISTS `fx_content_news` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `fx_content_news`
--

INSERT INTO `fx_content_news` (`id`) VALUES
(2678),
(2679),
(2680),
(2681);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_page`
--

CREATE TABLE IF NOT EXISTS `fx_content_page` (
  `id` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `comments_counter` int(11) DEFAULT NULL,
  `description` text,
  `h1` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `url` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=62;

--
-- Дамп данных таблицы `fx_content_page`
--

INSERT INTO `fx_content_page` (`id`, `url`, `name`, `title`, `comments_counter`, `description`, `h1`) VALUES
(2635, '/', 'Home', NULL, 0, NULL, NULL),
(2636, '/404', 'Page not found', NULL, 0, NULL, NULL),
(2638, '/Catalog', 'What we do', 'Catalog', 0, NULL, NULL),
(2639, '/Projects', 'Projects', 'Projects', 0, NULL, NULL),
(2640, '/About-Us-2', 'About', '', 0, NULL, NULL),
(2641, '/Contacts', 'Contacts', '', 0, NULL, NULL),
(2652, '/Sport-series', 'Sport OLOTORT', 'Sport series', 0, NULL, NULL),
(2654, '/people-photo', 'People', '', 0, NULL, NULL),
(2655, '/Team', 'The  team', 'People', 0, NULL, NULL),
(2656, '/Vacancies', 'Vacancies', 'Vacancies', 0, NULL, NULL),
(2657, '/News', 'News', 'News', 0, NULL, NULL),
(2658, '/Landscapes', 'Landscapes', '', 0, NULL, NULL),
(2660, '/Football-photo-report', 'Football photo report', '', 0, '<p>\r\n	Our photographers have been shooting Champion League matches since 2008, the finals of UEFA Euro 2008 and 2012. They are now getting ready for World Cup 2014 in Brazil.</p><p>\r\n	If you want the drama of football match captured by professionals, hire us. We’ve got all the skills, experience, and equipment needed to shot high-quality photo set for you.</p>', NULL),
(2661, '/Skiing', 'Skiing', '', 0, '<p>\n	Ken’s speaking:\n</p>\n<blockquote>\n	I love to shoot winter sports, especially skiing competitions. It’s dynamic, it’s graphic because skis and ski poles give the picture a great rhythm.\n</blockquote>\n<blockquote>\n	The crowd of skiers looks fantastic on the snow. And scenery is always beautiful. I love winter forest – perhaps that’s my Russian roots talking.\n</blockquote>\n<p>\n	Ken’s been shooting ski competitions around the world for several years. If you need a winter sports series he is your guy.\n</p>', NULL),
(2662, '/Swimming', 'Swimming', '', 0, '<p>\n	After all the time she spent in pools and seas, our photographer Leila is basically half-human half-dolphin. She knows all the details about shooting in water, and even has a couple of inventions of her own for underwater shooting.\n</p>\n<p>\n	Leila’s speaking:\n</p>\n<blockquote>\n	I love how water changes the light, shapes, and textures of things. It can be very expressive. I’m currently getting ready for European Aquatic Championship. A great photo report’s waiting to be made!\n</blockquote>', NULL),
(2671, '/Ken-Cold', 'Ken The Cold', '', 0, '<p>\r\n	Ken is romantics’ ideal – serene, sensitive, and a bit shy.</p><p>\r\n	When led into the wild, he blends into the nature to capture it beautifully.</p>', NULL),
(2673, '/Leila-Stoparsson', 'Leila Stoparsson', '', 0, '<p>\r\n	Leila is the best at shooting interiors.</p><p>\r\n	Her photographs always give you the sense of the place.</p>', NULL),
(2675, '/Nika-Lightman', 'Nika Lightman', '', 0, '<p>\r\n	Nika Lightman has a gift to shoot portraits.</p><p class="">\r\n	We all have pictures of ourselves made by Nika.</p><p>\r\n	Accurate yet flattering!</p>', NULL),
(2677, '/Maker-up', 'Maker up', '', 0, NULL, NULL),
(2678, '/Redecoration-in-our-new-studio', 'Redecoration in our new studio', '', 0, '<p>\n	 <span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;" class="">Last touches, and we are ready to move in!</span></p>', NULL),
(2679, '/Moscow-Streetshot-Contest', 'Moscow Streetshot Contest', '', 0, '<p>\r\n	<span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">Nika’s and Ken’s street series were shortlisted for Moscow Streetshot Contest.</span>\r\n</p>', NULL),
(2680, '/Free-ride-proof-pics', 'Free ride proof pics!', '', 0, '<p>\n	 <span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;" class="">The whole team went for free ride. Proof pics!</span></p>', NULL),
(2681, '/Moscow-Athletics-Championship', 'Moscow Athletics Championship', 'Moscow Athletics Championship', 0, '<p>\n	<span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;" class="">We made some great photo series during Moscow Athletics Championship.</span></p><p class="">\n	Check them out.</p>', NULL),
(2688, '/Carnival-of-miners', 'Carnival of miners', '', 0, '<p>\n	The patron of miners, the Devil, has combined both positive – Indian mythology – and negative – Catholic – roots. The miners attributed their good fortune directly with a grace of the devil, and thank him in their crazy carnival dances.\n</p>\n<p>\n	Leila went to Bolivia after Young Pathfinder offered her to do a series about miners’ life in Sought America. Leila came back with a beautiful photo report.\n</p>', NULL),
(2690, '/Cockfights', 'Cockfights', '', 0, '<p>\n	Cockfighting is a blood sport due in some part to the physical trauma the cocks inflict on each other. Advocates of the "age old sport" often list cultural and religious relevance as reasons for perpetuation of cockfighting as a sport.\n</p>\n<p>\n	Nika disapproves of the whole thing but she went to Cuba to document the fights, the true professional she is.\n</p>', NULL),
(2728, '/studio', 'studio', NULL, 0, NULL, NULL),
(2731, '/contest', 'contest', NULL, 0, NULL, NULL),
(2733, '/sport', 'sport', NULL, 0, NULL, NULL),
(2735, '/Sonya-Zoomer', 'Sonya Zoomer', '', 0, '<blockquote>\r\n	 “She is a genius, a philosopher, an abstract thinker. She has a brain of the first order. She sits motionless, like a spider in the center of its web, but that web has a thousand radiations, and she knows well every quiver of each of them. She does little himself. She only plans&hellip;”\r\n</blockquote><p>\r\n	 Meet Sonya, our manager.</p>', NULL),
(2737, '/Delivery-person', 'Delivery person', '', 0, NULL, NULL),
(2739, '/Athletics', 'Athletics', '', 0, '<p>\n	Athletics was the first competitions our team’s shot. Since our first series in 2007, we’ve become faster and stronger. Ken’s become bolder.\n</p>\n<p>\n	We are so good at shooting athletics partly because competitive running, jumping, and throwing things is something that happens in our studio daily.\n</p>\n<p>\n	We are fascinated with the sight of passion and human endeavor you see at the stadium during competitions. Sometimes, it’s pure heroism from the athletes. We always do our best to do them justice with our photo series.\n</p>', NULL),
(2740, '/Portrait', 'Portrait', '', 0, '<p>\n	Nika, our portraitist, is super good at catching person’s mood and character.\n</p>\n<p>\n	She’s inventive in studio photo shoot but is open to client’s suggestions.\n</p>', NULL),
(2741, '/Passport-photos', 'Passport photos', '', 0, '<p>\n	You know those passport pictures that are more suited for “Wanted” posters? None of that if you come to our studio.\n</p>\n<p>\n	We do all the necessary formats. We then can do all the necessary editing really quickly. You’ll look respectable and reliable individual – promise!\n</p>', NULL),
(2742, '/Cities', 'Cities', '', 0, '<p>\n	Ken is a poet of city jungles. He loves city dynamics and lights and noises. He also loves to travel and will be excited to go and shoot the city you want. High-quality pictures and unique view guaranteed.\n</p>\n<p>\n	We are also happy to take orders from city administrations to make a booklet with local sights. Tourists will rush to your city and spend their money around all those attractions.\n</p>', NULL),
(2743, '/Nature', 'Nature', '', 0, '<p>\n	Ken’s favorite book is Emerson’s Naturalistic Photography. Inspired by the book he later developed his own system of aesthetics that reflect nature in a beautiful and unique way.\n</p>\n<p>\n	Ken is armed with all necessary gear and is not afraid of using it. He is very patient – a must-have for a naturalistic artist – and can spend hour in the woods or on the beach waiting for the perfect sunset.\n</p>', NULL),
(2744, '/Events', 'Events', '', 0, NULL, NULL),
(2745, '/Birthday-parties', 'Birthday parties', '', 0, '<p>\n	We are ready to shoot the most exotic and extreme birthday parties. We have all the gear to shoot in the swimming pool or on the dance floor. Yes, you can put down your phone for once and enjoy celebrating.\n</p>\n<p>\n	By the way, our team came up with a great device. It includes wide-angle lens and some really technical stuff, like a stick, to make a massive selfie of you and all your party guests. Imagine the joy of tagging them all later on Instagram!\n</p>', NULL),
(2746, '/Corporate-events', 'Corporate events', '', 0, '<p>\n	We have a long experience in shooting corporate sessions, conferences, parties, and awards ceremonies. Your business rivals will be envious of how great your corporate events look.\n</p>\n<p>\n	With our digital team ready to work around the clock, all images are published on a password protected website within 48 hours.\n</p>', NULL),
(2751, '/Kupala-Night', 'Kupala Night', '', 0, '<p>\n	The fest has pagan roots. According to an ancient pagan belief, on the eve of Ivan Kupala is the only time of the year when ferns bloom. Prosperity, luck and power would befall whoever finds a fern flower. On that night village folks would roam through the forests in search of magical herbs and especially the elusive fern flower.\n</p>\n<p>\n	Traditionally, unmarried women would be the first to enter the forest. They are followed by young men. In 2010, they were also followed by Ken who made fantastic photo series.\n</p>', NULL),
(2757, '/Bull-Easter', 'Bull Easter', '', 0, '<p>\n	Pascua Toro is celebrated during Holy Saturday.</p><p>\n	This holiday is famous for colorful running of the bulls through the streets of the town.</p><p class="">\n	In 2011, our Ken took a huge risk and ran along with bulls. Fortunately, no bulls were harmed.</p>', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_person`
--

CREATE TABLE IF NOT EXISTS `fx_content_person` (
  `id` int(11) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `department` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `short_description` varchar(255) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `fx_content_person`
--

INSERT INTO `fx_content_person` (`id`, `full_name`, `department`, `photo`, `short_description`, `birthday`) VALUES
(2671, 'Ken Cold', '', '/floxim_files/content/person/photo/3b_3_0.jpg', 'romantics’ ideal', '1946-01-09 00:00:00'),
(2673, 'Leila Stoparsson', '', '/floxim_files/content/person/photo/3a_2_0.JPG', 'the sense of the place', '1962-02-28 00:00:00'),
(2675, 'Nika Lightman', '', '/floxim_files/content/person/photo/2b_0.JPG', 'cool portraits', '1986-02-13 00:00:00'),
(2735, 'Sonya Zoomer', 'Client support', '/floxim_files/content/person/photo/3g_2_0.JPG', '“she sits motionless, like a spider”', '1975-11-13 00:00:00');

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_photo`
--

CREATE TABLE IF NOT EXISTS `fx_content_photo` (
  `id` int(11) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `description` text,
  `copy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `fx_content_photo`
--

INSERT INTO `fx_content_photo` (`id`, `photo`, `description`, `copy`) VALUES
(2692, '/floxim_files/content/photo/photo/6_Carnival_of_miners_13_0.jpg', '', ''),
(2693, '/floxim_files/content/photo/photo/6_Carnival_of_miners_15_0.jpg', '', ''),
(2750, '/floxim_files/content/photo/photo/6_Carnival_of_miners_8_0.jpg', '', ''),
(2752, '/floxim_files/content/photo/photo/6_kupala_8_0.JPG', '', ''),
(2753, '/floxim_files/content/photo/photo/6_kupala_1_0.JPG', '', ''),
(2754, '/floxim_files/content/photo/photo/6_kupala_17_0.JPG', '', ''),
(2755, '/floxim_files/content/photo/photo/6_cockfights_5_0.jpg', '', ''),
(2756, '/floxim_files/content/photo/photo/6_cockfights_8_0.JPG', '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_product`
--

CREATE TABLE IF NOT EXISTS `fx_content_product` (
  `id` int(11) NOT NULL,
  `short_description` text,
  `image` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `fx_content_product`
--

INSERT INTO `fx_content_product` (`id`, `short_description`, `image`, `price`) VALUES
(2660, '<p>\r\n	<span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">We capture the emotions of players and fans during the match like no one else.</span></p>', '/floxim_files/content/product/image/5_football_4_0.jpg', 1299),
(2661, '<p>\r\n	<span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">We are not scary of getting cold on the ski run as we usually run twice as much </span><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">as the skiers to catch the most interesting moments.</span>\r\n</p>', '/floxim_files/content/product/image/5_ski_5_0.JPG', 1500),
(2662, '<p>\r\n	We love to shoot water sports so much that we attend all the events we can –  <span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">from Olympics to school competition in our local pool.</span><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;"></span>\r\n</p>', '/floxim_files/content/product/image/5_birthday_2_0.JPG', 1500),
(2739, '<p>\r\n	<span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">“Faster - Higher – Stronger” – our shooting motto.</span>\r\n</p>', '/floxim_files/content/product/image/5_athlet_2_0.JPG', 2100),
(2740, '<p>\r\n	<span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">We shoot portraits with love to subject. Welcome, beautiful client!</span>\r\n</p>', '/floxim_files/content/product/image/3a_1_0.JPG', 800),
(2741, '<p>\r\n	<span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">High-quality representation of you for docs and visas.</span>\r\n</p>', '/floxim_files/content/product/image/5_portrait_passport_5_0.JPG', 1000),
(2742, '<p>\r\n	<span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">We all are in love with street photography. That’s handy if you need an urban </span><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">photo series.</span>\r\n</p>', '/floxim_files/content/product/image/5_city_4_0.jpg', 900),
(2743, '<p>\n	 Our photographers teamed up with major naturalistic magazines.\n</p>\n<p>\n	<span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">We are so ready to start a new expedition.</span>\n</p>\n<p>\n	<span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;"></span>\n</p>', '/floxim_files/content/product/image/5_nature_2_0.JPG', 1600),
(2745, '<p>\r\n	<span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">We’ll do our best to abstain from drinks and capture you and your friends in </span><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">the gorgeous way.</span>\r\n</p>', '/floxim_files/content/product/image/5_birthday_9_0.jpg', 200),
(2746, '<p>\r\n	<span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">Among our clients are the biggest companies in the country. Most of them </span><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">keep re-booking our photographers year after year.</span>\r\n</p>', '/floxim_files/content/product/image/1_2_0.JPG', 2900);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_project`
--

CREATE TABLE IF NOT EXISTS `fx_content_project` (
  `id` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `client` varchar(255) DEFAULT NULL,
  `short_description` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `fx_content_project`
--

INSERT INTO `fx_content_project` (`id`, `image`, `client`, `short_description`, `date`) VALUES
(2688, '/floxim_files/content/project/image/6_Carnival_of_miners_7_0.jpg', '', 'The carnival of Potosi in Bolivia is the traditional feast of miners who live and work in one of the highest mines in the world.', '2014-01-09 00:00:00'),
(2690, '/floxim_files/content/project/image/6_cockfights_3_0.JPG', '', 'A cockfight is a blood sport between two gamecocks, held in a ring called a cockpit.', '2014-01-16 00:00:00'),
(2751, '/floxim_files/content/project/image/6_kupala_7_0.jpg', '', 'Kupala Night, also known as Ivan Kupala Day (Feast of St. John the Baptist) is celebrated in Ukraine, Belarus and Russia currently on the night of 6/7 July in the Gregorian calendar.', '0000-00-00 00:00:00'),
(2757, '/floxim_files/content/project/image/6_pascua_toro_3_0.jpg', '', 'Pascua Toro (Bull Easter) is the traditional holiday of the inhabitants of the Peruvian town of Ayacucho.', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_publication`
--

CREATE TABLE IF NOT EXISTS `fx_content_publication` (
  `id` int(11) NOT NULL,
  `publish_date` datetime DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `text` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `fx_content_publication`
--

INSERT INTO `fx_content_publication` (`id`, `publish_date`, `image`, `text`) VALUES
(2678, '2014-04-17 00:00:00', '/floxim_files/content/news/image/2a_0.jpg', '<p>\n	We say goodbye to our old studio.\n</p>\n<p>\n	The new one is almost ready for us to move in.\n</p>\n<p>\n	It’s bigger, lighter, and there is a small garden to throw a studio-warming party.\n</p>'),
(2679, '2013-01-12 15:37:34', '/floxim_files/content/news/image/5_city_6_0.jpg', '<p>\r\n	   Guys didn’t win this time but we’ll be back next year.\r\n</p>\r\n<p>\r\n	   For now, have Nika and her crazy hair having fun in Russia.\r\n</p>'),
(2680, '2014-02-21 15:19:29', '/floxim_files/content/news/image/2v_10_0.jpg', '<p>\n	We are back from Sheregesh, a small village in Syberia.\n</p>\n<p>\n	The place is perfect for free ride and Russian snow is the fluffiest.\n</p>'),
(2681, '2014-08-07 15:39:50', '/floxim_files/content/news/image/5_athlet_5_0.jpg', '<p>\n	We made a photo report about Moscow Athletics Championship.\n</p>\n<p>\n	In other news - Nika lost her voice while cheering for a cute runner.\n</p>');

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_section`
--

CREATE TABLE IF NOT EXISTS `fx_content_section` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=7;

--
-- Дамп данных таблицы `fx_content_section`
--

INSERT INTO `fx_content_section` (`id`) VALUES
(2638),
(2639),
(2640),
(2641),
(2652),
(2654),
(2655),
(2656),
(2657),
(2658),
(2744);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_tag`
--

CREATE TABLE IF NOT EXISTS `fx_content_tag` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `fx_content_tag`
--

INSERT INTO `fx_content_tag` (`id`) VALUES
(2728),
(2731),
(2733);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_text`
--

CREATE TABLE IF NOT EXISTS `fx_content_text` (
  `id` int(11) NOT NULL,
  `text` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1199;

--
-- Дамп данных таблицы `fx_content_text`
--

INSERT INTO `fx_content_text` (`id`, `text`) VALUES
(2701, '<h4><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">Sanctus sea sed takimata</span></h4>\r\n<p>\r\n	<span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">Sanctus sea sed takimata</span>\r\n</p>'),
(2767, '<p>\n	  This is regular text, and it is so regular...\n</p>\n<p>\n	 Ok regularrr\n</p>\n<p>\n	 Yeah.\n</p>');

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_user`
--

CREATE TABLE IF NOT EXISTS `fx_content_user` (
  `id` int(11) NOT NULL,
  `email` char(255) NOT NULL,
  `login` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `registration_code` varchar(45) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `forum_messages` int(11) NOT NULL DEFAULT '0',
  `pa_balance` double NOT NULL DEFAULT '0',
  `auth_hash` varchar(50) NOT NULL DEFAULT '',
  `is_admin` tinyint(4) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `User_ID` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=104;

--
-- Дамп данных таблицы `fx_content_user`
--

INSERT INTO `fx_content_user` (`id`, `email`, `login`, `name`, `registration_code`, `avatar`, `forum_messages`, `pa_balance`, `auth_hash`, `is_admin`, `password`) VALUES
(2367, 'dubr.cola@gmail.com', '', 'Admin', NULL, NULL, 0, 0, '', 1, '196TFkN9J57UY');

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_vacancy`
--

CREATE TABLE IF NOT EXISTS `fx_content_vacancy` (
  `id` int(11) NOT NULL,
  `salary_from` int(11) DEFAULT NULL,
  `salary_to` int(11) DEFAULT NULL,
  `requirements` text,
  `responsibilities` text,
  `work_conditions` text,
  `currency` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `fx_content_vacancy`
--

INSERT INTO `fx_content_vacancy` (`id`, `salary_from`, `salary_to`, `requirements`, `responsibilities`, `work_conditions`, `currency`, `image`) VALUES
(2677, 0, 0, '<ul><li class="">Knowlede of QuarkXPress, Illustrator plus the standard Adobe Photoshop, Dreamweaver and Microsoft programs;</li><li class="">Professional experience of at least three years;</li><li class="">Creativity, energy and enthusiasm;</li><li class="">Language skills in both Russian and English.</li></ul>', '<ul>\r\n	\r\n<li><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">assisting with the production of presentations;</span></li>	\r\n<li><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;"></span><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">organising digital photography;</span></li>	\r\n<li><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;"></span><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">drawing graphs and diagrams in Illustrator;</span></li>	\r\n<li><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">u</span><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">pdating photo libraries.</span></li></ul>', '<p>\r\n	  We are working on our first photo album and need someone with experience of <span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">making up a page.</span></p><p>\r\n	<span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">If you are good we’ll love you to bits.</span></p>', '$', '/floxim_files/content/vacancy/image/4SPS_0.jpg'),
(2737, 0, 0, '<p class="">\n	 Walk, ride bicycles, drive vehicles, or use public conveyances in order to <span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;" class="">reach destinations to deliver our newspaper</span><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;" class="">.</span></p>', '<ul>\r\n	<li>Receive the newspapers or the materials for our clients to be delivered, <span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">and information on recipients, such as names, addresses, telephone </span><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">numbers, and delivery instructions, communicated via telephone, two-</span><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">way radio, or in person;</span></li>\r\n	<li><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">Plan and follow the most efficient routes for delivering our precious </span><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">newpaper;</span></li>\r\n	<li><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;"></span><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">Obtain signatures and payments, or arrange for recipients to make </span><span style="font-family: Arial, Helvetica, Verdana, Tahoma, sans-serif;">payments.</span></li>\r\n</ul>', '', '$', '/floxim_files/content/vacancy/image/5_birthday_1_0.JPG');

-- --------------------------------------------------------

--
-- Структура таблицы `fx_content_video`
--

CREATE TABLE IF NOT EXISTS `fx_content_video` (
  `id` int(11) NOT NULL,
  `embed_html` text,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `fx_datatype`
--

CREATE TABLE IF NOT EXISTS `fx_datatype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(64) NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `not_null` tinyint(1) NOT NULL DEFAULT '1',
  `default` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=204 AUTO_INCREMENT=15 ;

--
-- Дамп данных таблицы `fx_datatype`
--

INSERT INTO `fx_datatype` (`id`, `name`, `priority`, `searchable`, `not_null`, `default`) VALUES
(1, 'string', 1, 1, 1, 1),
(2, 'int', 2, 1, 1, 1),
(3, 'text', 3, 1, 1, 0),
(4, 'select', 4, 1, 1, 1),
(5, 'bool', 5, 1, 1, 1),
(6, 'file', 6, 0, 1, 0),
(7, 'float', 7, 1, 1, 1),
(8, 'datetime', 8, 1, 1, 1),
(9, 'color', 9, 1, 1, 1),
(11, 'image', 11, 0, 1, 0),
(13, 'link', 13, 1, 1, 0),
(14, 'multilink', 14, 0, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_field`
--

CREATE TABLE IF NOT EXISTS `fx_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `component_id` int(11) NOT NULL DEFAULT '0',
  `keyword` char(64) NOT NULL,
  `name_en` varchar(255) NOT NULL,
  `name_ru` varchar(255) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '1',
  `format` text NOT NULL,
  `not_null` smallint(6) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  `searchable` smallint(6) NOT NULL DEFAULT '1',
  `default` char(255) DEFAULT NULL,
  `type_of_edit` int(11) NOT NULL DEFAULT '1',
  `checked` tinyint(1) NOT NULL DEFAULT '1',
  `form_tab` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Checked` (`checked`),
  KEY `component_id` (`component_id`),
  KEY `TypeOfData_ID` (`type`),
  KEY `TypeOfEdit_ID` (`type_of_edit`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=95 AUTO_INCREMENT=320 ;

--
-- Дамп данных таблицы `fx_field`
--

INSERT INTO `fx_field` (`id`, `component_id`, `keyword`, `name_en`, `name_ru`, `type`, `format`, `not_null`, `priority`, `searchable`, `default`, `type_of_edit`, `checked`, `form_tab`) VALUES
(1, 1, 'name', 'Screen name', 'Отображаемое имя', 1, '', 0, 0, 1, '', 1, 1, 0),
(2, 1, 'avatar', 'Userpic', 'Аватар', 11, '', 0, 0, 0, '', 1, 1, 0),
(118, 19, 'text', 'Text', 'Текст', 3, 'a:2:{s:4:"html";s:1:"1";s:5:"nl2br";s:1:"0";}', 0, 0, 1, '', 1, 1, 0),
(153, 1, 'email', 'E-mail', '', 1, '', 0, 142, 1, NULL, 1, 1, 0),
(165, 23, 'url', 'URL', '', 1, '', 0, 2, 0, '', 1, 1, 0),
(190, 23, 'name', 'Name', 'Название', 1, '', 1, 1, 1, '', 1, 1, 0),
(191, 23, 'title', 'Title', 'Заголовок (title)', 1, '', 0, 158, 0, '', 1, 1, 0),
(196, 36, 'parent_id', 'Parent', 'Родитель', 13, 'a:4:{s:6:"target";s:2:"36";s:9:"prop_name";s:6:"parent";s:9:"is_parent";s:1:"0";s:11:"render_type";s:6:"select";}', 0, 0, 0, '', 2, 1, 0),
(203, 48, 'photo', 'Image', '', 11, '', 1, 168, 0, '', 1, 1, 0),
(204, 48, 'description', 'Description', '', 3, 'a:2:{s:4:"html";s:1:"1";s:5:"nl2br";s:1:"0";}', 0, 169, 0, '', 1, 1, 0),
(205, 48, 'copy', 'Copy', '', 1, '', 0, 170, 0, '', 1, 1, 0),
(212, 49, 'publish_date', 'Publish date', 'Дата публикации', 8, '', 0, 174, 0, 'now', 1, 1, 1),
(214, 49, 'image', 'Image', 'Изображение', 11, '', 0, 176, 0, '', 1, 1, 2),
(215, 49, 'text', 'Text', 'Текст', 3, 'a:2:{s:4:"html";s:1:"1";s:5:"nl2br";s:1:"0";}', 0, 177, 0, '', 1, 1, 3),
(216, 1, 'is_admin', 'Is admin?', 'Админ?', 5, '', 0, 178, 0, '0', 2, 1, 0),
(218, 50, 'comment_text', 'Comment Text', '', 3, 'a:1:{s:5:"nl2br";s:1:"1";}', 1, 180, 0, '', 2, 1, 0),
(219, 50, 'publish_date', 'Publish Date', '', 8, '', 1, 181, 0, '', 2, 1, 0),
(220, 50, 'user_name', 'User Name', '', 1, '', 1, 182, 0, '', 2, 1, 0),
(221, 23, 'comments_counter', 'Comments counter', 'Число комментариев', 2, '', 0, 183, 0, '0', 3, 1, 0),
(222, 50, 'is_moderated', 'Moderated flag', '', 5, '', 0, 184, 0, '0', 2, 1, 0),
(230, 59, 'embed_html', 'Embed code or link', '', 3, 'a:2:{s:4:"html";s:1:"0";s:5:"nl2br";s:1:"0";}', 0, 187, 0, '', 1, 1, 0),
(231, 59, 'description', 'Description', '', 3, 'a:2:{s:4:"html";s:1:"1";s:5:"nl2br";s:1:"0";}', 0, 188, 0, '', 1, 1, 0),
(238, 62, 'image', 'Image', 'Изображение', 11, '', 0, 195, 0, '', 1, 1, 0),
(239, 62, 'client', 'Client', 'Клиент', 1, '', 0, 196, 0, '', 1, 1, 0),
(240, 62, 'short_description', 'Short Description', 'Короткое описание', 1, '', 0, 197, 0, '', 1, 1, 0),
(242, 62, 'date', 'Date', 'Дата', 8, '', 0, 199, 0, '', 1, 1, 0),
(244, 63, 'salary_from', 'Salary from', '', 2, '', 0, 201, 0, '', 1, 1, 0),
(245, 63, 'salary_to', 'Salary To', '', 2, '', 0, 202, 0, '', 1, 1, 0),
(246, 63, 'requirements', 'Requirements', '', 3, 'a:2:{s:4:"html";s:1:"1";s:5:"nl2br";s:1:"0";}', 0, 203, 0, '', 1, 1, 0),
(247, 63, 'responsibilities', 'Responsibilities', '', 3, 'a:2:{s:4:"html";s:1:"1";s:5:"nl2br";s:1:"0";}', 0, 204, 0, '', 1, 1, 0),
(248, 63, 'work_conditions', 'Work conditions', '', 3, 'a:2:{s:4:"html";s:1:"1";s:5:"nl2br";s:1:"0";}', 0, 205, 0, '', 1, 1, 0),
(253, 64, 'counter', 'Counter', '', 2, '', 0, 210, 0, '0', 3, 1, 0),
(254, 65, 'classifier_id', 'Classifier ID', '', 13, 'a:4:{s:6:"target";s:2:"64";s:9:"prop_name";s:10:"classifier";s:9:"is_parent";s:1:"0";s:11:"render_type";s:10:"livesearch";}', 0, 211, 0, '', 1, 1, 0),
(255, 65, 'content_id', 'Content ID', '', 13, 'a:4:{s:6:"target";s:2:"36";s:9:"prop_name";s:7:"content";s:9:"is_parent";s:1:"1";s:11:"render_type";s:10:"livesearch";}', 0, 212, 0, '', 1, 1, 0),
(257, 69, 'full_name', 'Full Name', '', 1, '', 0, 214, 0, '', 1, 1, 0),
(259, 69, 'department', 'Department', '', 1, '', 0, 216, 0, '', 1, 1, 0),
(260, 69, 'photo', 'Photo', '', 11, '', 0, 217, 0, '', 1, 1, 3),
(261, 69, 'short_description', 'Short Description', '', 1, '', 0, 218, 0, '', 1, 1, 0),
(263, 69, 'birthday', 'Birthday', '', 8, '', 0, 220, 0, '', 1, 1, 3),
(264, 70, 'value', 'Value', '', 1, '', 0, 222, 0, '', 1, 1, 0),
(265, 70, 'contact_type', 'Type', '', 1, '', 0, 221, 0, '', 1, 1, 0),
(269, 69, 'contacts', 'Contacts', '', 14, 'a:3:{s:11:"render_type";s:5:"table";s:13:"linking_field";s:3:"196";s:16:"linking_datatype";s:2:"70";}', 0, 223, 0, '', 1, 1, 3),
(278, 75, 'short_description', 'Short Description', '', 3, 'a:2:{s:4:"html";s:1:"1";s:5:"nl2br";s:1:"0";}', 0, 232, 0, '', 1, 1, 0),
(279, 75, 'image', 'Image', '', 11, '', 0, 233, 0, '', 1, 1, 0),
(280, 75, 'price', 'Price', '', 2, '', 0, 234, 0, '', 1, 1, 0),
(289, 1, 'password', 'Password', 'Пароль', 1, '', 0, 243, 0, '', 1, 1, 0),
(290, 36, 'created', 'Creation date', 'Дата создания', 8, '', 0, 1, 0, '', 3, 1, 0),
(291, 36, 'user_id', 'User', 'Пользователь', 13, 'a:4:{s:6:"target";s:1:"1";s:9:"prop_name";s:4:"user";s:9:"is_parent";s:1:"0";s:11:"render_type";s:10:"livesearch";}', 0, 2, 0, '', 3, 1, 0),
(292, 36, 'site_id', 'Site', 'Сайт', 13, 'a:4:{s:6:"target";s:4:"site";s:9:"prop_name";s:4:"site";s:9:"is_parent";s:1:"0";s:11:"render_type";s:10:"livesearch";}', 0, 3, 0, '', 3, 1, 0),
(294, 77, 'linked_id', 'Linked content id', '', 13, 'a:4:{s:6:"target";s:2:"36";s:9:"prop_name";s:7:"content";s:9:"is_parent";s:1:"0";s:11:"render_type";s:10:"livesearch";}', 0, 247, 0, '', 1, 1, 0),
(295, 49, 'tags', 'Tags', 'Теги', 14, 'a:5:{s:11:"render_type";s:10:"livesearch";s:13:"linking_field";s:3:"255";s:16:"linking_datatype";s:2:"65";s:8:"mm_field";s:3:"254";s:11:"mm_datatype";s:2:"78";}', 0, 248, 0, '', 1, 1, 0),
(300, 63, 'currency', 'Currency', '', 1, '', 0, 253, 0, 'USD', 1, 1, 0),
(304, 23, 'children', 'Children', 'Потомки', 14, 'a:3:{s:11:"render_type";s:10:"livesearch";s:13:"linking_field";s:3:"196";s:16:"linking_datatype";s:2:"36";}', 0, 257, 0, '', 3, 1, 0),
(305, 63, 'image', 'Image', 'Изображение', 11, '', 0, 258, 0, '', 1, 1, 4),
(306, 23, 'description', 'Description', 'Описание', 3, 'a:2:{s:4:"html";s:1:"1";s:5:"nl2br";s:1:"0";}', 0, 259, 0, '', 1, 1, 2),
(307, 23, 'h1', 'H1', '', 1, '', 0, 260, 0, '', 1, 1, 0),
(314, 80, 'subject', 'Subject', 'Заголовок', 1, '', 0, 6, 0, '', 1, 1, 0),
(315, 80, 'message', 'Message', 'Сообщение', 3, 'a:2:{s:4:"html";s:1:"1";s:5:"nl2br";s:1:"0";}', 0, 7, 0, '', 1, 1, 0),
(316, 80, 'language_id', 'Language', 'Язык', 13, 'a:4:{s:6:"target";s:4:"lang";s:9:"prop_name";s:8:"language";s:9:"is_parent";s:1:"0";s:11:"render_type";s:6:"select";}', 0, 5, 0, '', 1, 1, 0),
(317, 80, 'keyword', 'Keyword', 'Ключевое слово', 1, '', 0, 4, 0, '', 1, 1, 0),
(318, 81, 'from', 'From', 'От кого', 1, '', 0, 265, 0, '', 1, 1, 0),
(319, 81, 'bcc', 'BCC', 'Скрытая копия', 1, '', 0, 266, 0, '', 1, 1, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_filetable`
--

CREATE TABLE IF NOT EXISTS `fx_filetable` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `real_name` char(128) NOT NULL,
  `path` text NOT NULL,
  `type` char(64) DEFAULT NULL,
  `size` int(10) unsigned NOT NULL DEFAULT '0',
  `to_delete` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=56 AUTO_INCREMENT=633 ;

--
-- Дамп данных таблицы `fx_filetable`
--

INSERT INTO `fx_filetable` (`id`, `real_name`, `path`, `type`, `size`, `to_delete`) VALUES
(56, 'bg-portfolio.jpg', 'content/bg-portfolio_1.jpg', 'image/jpeg', 235261, 0),
(60, 'bg-portfolio.jpg', 'content/bg-portfolio_3.jpg', 'image/jpeg', 235261, 0),
(164, 'гроза.jpg', 'content/groza_1.jpg', 'image/jpeg', 172197, 0),
(345, 'img01.jpg', 'content/img01_1.jpg', 'image/jpeg', 219265, 0),
(356, '_logo.png', 'content/logo_3.png', 'image/png', 2627, 0),
(357, 'bg-portfolio.jpg', 'content/bg-portfolio_6.jpg', 'image/jpeg', 235261, 0),
(358, 'bg-company.jpg', 'content/bg-company_2.jpg', 'image/jpeg', 68376, 0),
(378, 'logo.png', 'content/logo_6.png', 'image/png', 5735, 0),
(379, 'img05.jpg', 'content/img05_1.jpg', 'image/jpeg', 5717, 0),
(389, 'bg-portfolio.jpg', 'content/bg-portfolio_0.jpg', 'image/jpeg', 235261, 0),
(390, '7394.jpg', 'content/7394_0.jpg', 'image/jpeg', 8988, 0),
(391, 'patch_0.1.1.zip', 'patches/patch_0.1.1_0.zip', 'Image', 696, 0),
(392, 'patch_0.1.1.zip', 'patches/patch_0.1.1_1.zip', 'Image', 696, 0),
(393, 'patch_0.1.1.zip', 'patches/patch_0.1.1_2.zip', 'Image', 696, 0),
(394, 'patch_0.1.1.zip', 'patches/patch_0.1.1_3.zip', 'Image', 696, 0),
(395, 'patch_0.1.1.zip', 'patches/patch_0.1.1_4.zip', 'Image', 696, 0),
(396, 'patch_0.1.1.zip', 'patches/patch_0.1.1_5.zip', 'Image', 696, 0),
(397, 'patch_0.1.1.zip', 'patches/patch_0.1.1_0.zip', 'Image', 696, 0),
(398, 'patch_0.1.1.zip', 'patches/patch_0.1.1_1.zip', 'Image', 696, 0),
(399, 'patch_0.1.1.zip', 'patches/patch_0.1.1_2.zip', 'Image', 696, 0),
(400, 'patch_0.1.1.zip', 'patches/patch_0.1.1_0.zip', 'Image', 696, 0),
(401, 'patch_0.1.1.zip', 'patches/patch_0.1.1_1.zip', 'Image', 696, 0),
(402, 'patch_0.1.1.zip', 'patches/patch_0.1.1_1.zip', 'Image', 696, 0),
(403, 'patch_0.1.1.zip', 'patches/patch_0.1.1_1.zip', 'Image', 696, 0),
(404, 'patch_0.1.1.zip', 'patches/patch_0.1.1_0.zip', 'Image', 696, 0),
(405, 'patch_0.1.1.zip', 'patches/patch_0.1.1_0.zip', 'Image', 696, 0),
(406, 'patch_0.1.2.zip', 'patches/patch_0.1.2_0.zip', 'Image', 124, 0),
(407, 'patch_0.1.5.zip', 'patches/patch_0.1.5_0.zip', 'Image', 124, 0),
(408, 'patch_0.2.0.zip', 'patches/patch_0.2.0_0.zip', 'Image', 3697131, 0),
(409, 'patch_0.2.0.zip', 'patches/patch_0.2.0_0.zip', 'Image', 124, 0),
(410, 'patch_0.1.1.zip', 'patches/patch_0.1.1_0.zip', 'Image', 696, 0),
(411, 'patch_0.1.2.zip', 'patches/patch_0.1.2_0.zip', 'Image', 124, 0),
(412, 'patch_0.1.5.zip', 'patches/patch_0.1.5_0.zip', 'Image', 124, 0),
(413, 'patch_0.2.0.zip', 'patches/patch_0.2.0_0.zip', 'Image', 124, 0),
(414, 'patch_0.1.1.zip', 'patches/patch_0.1.1_0.zip', 'Image', 696, 0),
(415, 'me.jpg', 'content/me_0.jpg', 'image/jpeg', 11149, 0),
(416, 'me.jpg', 'content/me_1.jpg', 'image/jpeg', 11149, 0),
(417, 'me.jpg', 'content/me_2.jpg', 'image/jpeg', 11149, 0),
(418, 'img06.jpg', 'content/img06_0.jpg', 'image/jpeg', 5396, 0),
(419, 'arrow_right_red.gif', 'content/arrow_right_red_0.gif', 'image/gif', 868, 0),
(420, 'slider_stub.jpg', 'content/slider_stub_0.jpg', 'image/jpeg', 71404, 0),
(421, 'art_stub_3.jpg', 'content/art_stub_3_0.jpg', 'image/jpeg', 26120, 0),
(422, 'oblako_edit.png', 'content/oblako_edit_0.png', 'image/png', 17575, 0),
(423, 'pic_cf234a6d1cee7008e148c859472470e8.jpg', 'content/pic_cf234a6d1cee7008e148c859472470e8_0.jpg', 'image/jpeg', 41026, 0),
(429, 'pic_cf234a6d1cee7008e148c859472470e8.jpg', 'content/pic_cf234a6d1cee7008e148c859472470e8_2.jpg', 'image/jpeg', 41026, 0),
(432, 'pic_cf234a6d1cee7008e148c859472470e8.jpg', 'content/pic_cf234a6d1cee7008e148c859472470e8_5.jpg', 'image/jpeg', 41026, 0),
(433, 'pic_cf234a6d1cee7008e148c859472470e8.jpg', 'content/pic_cf234a6d1cee7008e148c859472470e8_6.jpg', 'image/jpeg', 41026, 0),
(434, 'pic_cf234a6d1cee7008e148c859472470e8.jpg', 'content/pic_cf234a6d1cee7008e148c859472470e8_7.jpg', 'image/jpeg', 41026, 0),
(435, 'pic_cf234a6d1cee7008e148c859472470e8.jpg', 'content/pic_cf234a6d1cee7008e148c859472470e8_8.jpg', 'image/jpeg', 41026, 0),
(436, 'top7_5bc1e924e748f5ae47b8ad0db7f1e096.jpg', 'content/top7_5bc1e924e748f5ae47b8ad0db7f1e096_0.jpg', 'image/jpeg', 16552, 0),
(437, 'top7_99c6e04ab50912c4c8faa3dfa0d78189.jpg', 'content/top7_99c6e04ab50912c4c8faa3dfa0d78189_0.jpg', 'image/jpeg', 24689, 0),
(438, 'top7_99c6e04ab50912c4c8faa3dfa0d78189.jpg', 'content/top7_99c6e04ab50912c4c8faa3dfa0d78189_1.jpg', 'image/jpeg', 24689, 0),
(445, 'anyday-00113348.jpg', 'content/anyday-00113348_1.jpg', 'image/jpeg', 10281, 0),
(450, 'top7_99c6e04ab50912c4c8faa3dfa0d78189.jpg', 'content/top7_99c6e04ab50912c4c8faa3dfa0d78189_4.jpg', 'image/jpeg', 24689, 0),
(452, 'top7_5bc1e924e748f5ae47b8ad0db7f1e096.jpg', 'content/top7_5bc1e924e748f5ae47b8ad0db7f1e096_4.jpg', 'image/jpeg', 16552, 0),
(453, 'pic_cf234a6d1cee7008e148c859472470e8.jpg', 'content/pic_cf234a6d1cee7008e148c859472470e8_3.jpg', 'image/jpeg', 41026, 0),
(456, 'awards-2007.png', 'content/awards-2007_4.png', 'image/png', 12875, 0),
(457, 'awards-2007.png', 'content/awards-2007_0.png', 'image/png', 12875, 0),
(459, 'awards-2007.png', 'content/awards-2007_3.png', 'image/png', 12875, 0),
(461, 'pic_cf234a6d1cee7008e148c859472470e8.jpg', 'content/pic_cf234a6d1cee7008e148c859472470e8_9.jpg', 'image/jpeg', 41026, 0),
(462, 'anyday-00113601.jpg', 'content/anyday-00113601_1.jpg', 'image/jpeg', 13461, 0),
(463, 'anyday-00113599.jpg', 'content/anyday-00113599_1.jpg', 'image/jpeg', 11259, 0),
(464, 'anyday-00113599.jpg', 'content/anyday-00113599_2.jpg', 'image/jpeg', 11259, 0),
(465, 'anyday-00113601.jpg', 'content/anyday-00113601_2.jpg', 'image/jpeg', 13461, 0),
(467, 'awards-2007.png', 'content/awards-2007_2.png', 'image/png', 12875, 0),
(469, 'eleganzza-00119360.jpg', 'content/eleganzza-00119360_0.jpg', 'image/jpeg', 9239, 0),
(470, 'logo_es.jpg', 'content/logo_es_0.jpg', 'image/jpeg', 23597, 0),
(471, 'logo_es.jpg', 'content/logo_es_1.jpg', 'image/jpeg', 23597, 0),
(472, 'logos.jpg', 'content/logos_0.jpg', 'image/jpeg', 5070, 0),
(473, 'logo_es.jpg', 'content/logo_es_2.jpg', 'image/jpeg', 23597, 0),
(475, 'awards-2007.png', 'content/awards-2007_5.png', 'image/png', 12875, 0),
(476, 'eleganzza-00116508.jpg', 'content/eleganzza-00116508_0.jpg', 'image/jpeg', 11737, 0),
(478, 'img06_0.jpg', 'content/img06_0.jpg', 'image/jpeg', 5396, 0),
(479, 'Screenshot from 2013-11-20 13:34:13.png', 'content/Screenshot_from_2013-11-20_13_34_13_2.png', 'image/png', 129489, 0),
(482, 'slide.jpg', 'content/slide_0.jpg', 'image/jpeg', 469679, 0),
(483, 'slide2.png', 'content/slide2_0.png', 'image/png', 1532079, 0),
(484, 'slide2.png', 'content/slide2_1.png', 'image/png', 1532079, 0),
(487, 'feature-item2.png', 'content/feature-item2_2.png', 'image/png', 83479, 0),
(495, 'slide2.png', 'content/slide2_2.png', 'image/png', 1532079, 0),
(496, 'slide2.png', 'content/slide2_3.png', 'image/png', 1532079, 0),
(500, 'slide.jpg', 'content/slide_1.jpg', 'image/jpeg', 469679, 0),
(501, 'slide.jpg', 'content/slide_2.jpg', 'image/jpeg', 469679, 0),
(504, 'feature-item2.png', 'content/feature-item2_4.png', 'image/png', 83479, 0),
(505, 'feature-item2.png', 'content/feature-item2_5.png', 'image/png', 83479, 0),
(506, 'feature-item.png', 'content/feature-item_3.png', 'image/png', 49569, 0),
(507, 'feature-item2.png', 'content/feature-item2_6.png', 'image/png', 83479, 0),
(508, 'slide.jpg', 'content/slide_3.jpg', 'image/jpeg', 469679, 0),
(509, 'slide.jpg', 'content/slide_4.jpg', 'image/jpeg', 469679, 0),
(513, 'slide2.png', 'content/slide2_4.png', 'image/png', 1532079, 0),
(514, 'slide2.png', 'content/slide2_5.png', 'image/png', 1532079, 0),
(515, 'attack02.jpeg', 'content/attack02_0.jpeg', 'image/jpeg', 58475, 0),
(516, 'feature-item2.png', 'content/feature-item2_7.png', 'image/png', 83479, 0),
(517, 'feature-item.png', 'content/feature-item_7.png', 'image/png', 49569, 0),
(520, 'banner.png', 'content/banner_0.png', 'image/png', 225331, 0),
(521, '1280px-Sortie_de_l_op_ra_en_l_an_2000-2_1.jpg', 'content/1280px-Sortie_de_l_op_ra_en_l_an_2000-2_1_0.jpg', 'image/jpeg', 426225, 0),
(522, 'Screenshot from 2014-01-10 16:51:51.png', 'content/Screenshot_from_2014-01-10_16_51_51_0.png', 'image/png', 260371, 0),
(523, '1280px-Sortie_de_l_op_ra_en_l_an_2000-2_1.jpg', 'content/1280px-Sortie_de_l_op_ra_en_l_an_2000-2_1_1.jpg', 'image/jpeg', 426225, 0),
(524, '1280px-Sortie_de_l_op_ra_en_l_an_2000-2_1.jpg', 'content/1280px-Sortie_de_l_op_ra_en_l_an_2000-2_1_2.jpg', 'image/jpeg', 426225, 0),
(525, '1280px-Sortie_de_l_op_ra_en_l_an_2000-2_1.jpg', 'content/1280px-Sortie_de_l_op_ra_en_l_an_2000-2_1_3.jpg', 'image/jpeg', 426225, 0),
(526, 'slide.jpg', 'content/slide_5.jpg', 'image/jpeg', 469679, 0),
(527, 'feature-item.png', 'content/feature-item_4.png', 'image/png', 49569, 0),
(528, 'slide.jpg', 'content/slide_6.jpg', 'image/jpeg', 469679, 0),
(529, 'feature-item2.png', 'content/feature-item2_8.png', 'image/png', 83479, 0),
(530, 'feature-item2.png', 'content/feature-item2_9.png', 'image/png', 83479, 0),
(532, 'HansIsland.png', 'content/HansIsland_0.png', 'image/png', 1247358, 0),
(533, 'HansIsland.png', 'content/HansIsland_1.png', 'image/png', 1247358, 0),
(534, 'HansIsland.png', 'content/HansIsland_2.png', 'image/png', 1247358, 0),
(535, 'HansIsland.png', 'content/HansIsland_3.png', 'image/png', 1247358, 0),
(536, 'employee.png', 'content/employee_0.png', 'image/png', 154565, 0),
(537, 'employee.png', 'content/employee_1.png', 'image/png', 154565, 0),
(538, 'employee.png', 'content/employee_2.png', 'image/png', 154565, 0),
(539, 'HansIsland.png', 'content/HansIsland_4.png', 'image/png', 1247358, 0),
(540, 'HansIsland.png', 'content/HansIsland_5.png', 'image/png', 1247358, 0),
(541, 'employee.png', 'content/employee_3.png', 'image/png', 154565, 0),
(543, 'HansIsland.png', 'content/HansIsland_6.png', 'image/png', 1247358, 0),
(544, 'HansIsland.png', 'content/HansIsland_7.png', 'image/png', 1247358, 0),
(545, 'employee.png', 'content/employee_4.png', 'image/png', 154565, 0),
(546, 'HansIsland.png', 'content/HansIsland_8.png', 'image/png', 1247358, 0),
(547, '3fl-about-people.jpg', 'content/3fl-about-people_0.jpg', 'image/jpeg', 461243, 0),
(548, 'HansIsland.png', 'content/HansIsland_9.png', 'image/png', 1247358, 0),
(549, '1280px-Sortie_de_l_op_ra_en_l_an_2000-2_1_0.jpg', 'content/1280px-Sortie_de_l_op_ra_en_l_an_2000-2_1_0.jpg', 'image/jpeg', 426225, 0),
(550, '1280px-Sortie_de_l_op_ra_en_l_an_2000-2_1_0.jpg', 'content/1280px-Sortie_de_l_op_ra_en_l_an_2000-2_1_0.jpg', 'image/jpeg', 426225, 0),
(551, '7394_0.jpg', 'content/7394_0.jpg', 'image/jpeg', 8988, 0),
(552, 'attack02_0.jpeg', 'content/attack02_0.jpeg', 'image/jpeg', 58475, 0),
(553, 'bg-portfolio_6.jpg', 'content/bg-portfolio_6.jpg', 'image/jpeg', 235261, 0),
(554, '1.jpg', 'content/1_0.jpg', 'image/jpeg', 42907, 0),
(555, '7394_0.jpg', 'content/7394_0.jpg', 'image/jpeg', 8988, 0),
(556, '2.jpg', 'content/2_0.jpg', 'image/jpeg', 90794, 0),
(557, '6_pascua toro_19.JPG', 'content/6_pascua_toro_19_0.JPG', 'image/jpeg', 6708148, 0),
(558, '2a.jpg', 'content/2a_0.jpg', 'image/jpeg', 2006482, 0),
(559, '2a.jpg', 'content/2a_0.jpg', 'image/jpeg', 2006482, 0),
(560, '3а.JPG', 'content/3a_0.JPG', 'image/jpeg', 6142668, 0),
(561, '3б_2.JPG', 'content/3b_2_0.JPG', 'image/jpeg', 2199222, 0),
(562, '3в_1.JPG', 'content/3v_1_0.JPG', 'image/jpeg', 4683927, 0),
(563, '3в_2.JPG', 'content/3v_2_0.JPG', 'image/jpeg', 3721626, 0),
(564, '3г_2.JPG', 'content/3g_2_0.JPG', 'image/jpeg', 5148823, 0),
(565, '4SPS.jpg', 'content/4SPS_0.jpg', 'image/jpeg', 5744225, 0),
(566, '5_birthday_1.JPG', 'content/5_birthday_1_0.JPG', 'image/jpeg', 1922298, 0),
(567, '5_football.JPG', 'content/5_football_0.JPG', 'image/jpeg', 272228, 0),
(568, 'logo_6.png', 'content/logo_6_0.png', 'image/png', 5735, 0),
(569, '7394_0.jpg', 'content/7394_0_0.jpg', 'image/jpeg', 8988, 0),
(570, '7394_0.jpg', 'content/7394_0_0.jpg', 'image/jpeg', 8988, 0),
(571, '7394_0.jpg', 'content/7394_0_1.jpg', 'image/jpeg', 8988, 0),
(572, '7394_0.jpg', 'content/7394_0_2.jpg', 'image/jpeg', 8988, 0),
(573, '7394_0.jpg', 'content/7394_0_3.jpg', 'image/jpeg', 8988, 0),
(574, '7394_0.jpg', 'content/7394_0_3.jpg', 'image/jpeg', 8988, 0),
(575, '7394_0.jpg', 'content/7394_0_3.jpg', 'image/jpeg', 8988, 0),
(576, '7394_0.jpg', 'content/7394_0_0.jpg', 'image/jpeg', 8988, 0),
(577, '2в_10.jpg', 'content/2v_10_0.jpg', 'image/jpeg', 2295356, 0),
(578, '2a.jpg', 'content/2a_0.jpg', 'image/jpeg', 2006482, 0),
(579, '5_city_6.jpg', 'content/5_city_6_0.jpg', 'image/jpeg', 4660236, 0),
(580, '5_athlet_5.jpg', 'content/5_athlet_5_0.jpg', 'image/jpeg', 5422772, 0),
(581, '6_pascua toro_19.JPG', 'content/6_pascua_toro_19_0.JPG', 'image/jpeg', 6708148, 0),
(582, '5_football_4.jpg', 'content/5_football_4_0.jpg', 'image/jpeg', 6378315, 0),
(583, '5_ski_5.JPG', 'content/5_ski_5_0.JPG', 'image/jpeg', 5248331, 0),
(584, '5_birthday_2.JPG', 'content/5_birthday_2_0.JPG', 'image/jpeg', 3021140, 0),
(585, '5_athlet_2.JPG', 'content/5_athlet_2_0.JPG', 'image/jpeg', 1040664, 0),
(586, '3а_1.JPG', 'content/3a_1_0.JPG', 'image/jpeg', 5391981, 0),
(587, '5_portrait_passport_5.JPG', 'content/5_portrait_passport_5_0.JPG', 'image/jpeg', 234851, 0),
(588, '5_city_4.jpg', 'content/5_city_4_0.jpg', 'image/jpeg', 4403301, 0),
(589, '5_nature_2.JPG', 'content/5_nature_2_0.JPG', 'image/jpeg', 7600878, 0),
(590, '5_birthday_9.jpg', 'content/5_birthday_9_0.jpg', 'image/jpeg', 5015120, 0),
(591, '1_2.JPG', 'content/1_2_0.JPG', 'image/jpeg', 6135325, 0),
(592, '5_ski_4.JPG', 'content/5_ski_4_0.JPG', 'image/jpeg', 3332886, 0),
(593, '5_3.jpg', 'content/5_3_0.jpg', 'image/jpeg', 253561, 0),
(594, '5_nature_5.jpg', 'content/5_nature_5_0.jpg', 'image/jpeg', 4334271, 0),
(595, '6_pascua toro_10.jpg', 'content/6_pascua_toro_10_0.jpg', 'image/jpeg', 5664993, 0),
(596, '5_swim.jpg', 'content/5_swim_0.jpg', 'image/jpeg', 6319631, 0),
(597, '5_football_4.jpg', 'content/5_football_4_0.jpg', 'image/jpeg', 6378315, 0),
(598, '3б_6.jpg', 'content/3b_6_0.jpg', 'image/jpeg', 4813880, 0),
(599, '5_open air_2.jpg', 'content/5_open_air_2_0.jpg', 'image/jpeg', 2253422, 0),
(600, '4SPS.jpg', 'content/4SPS_0.jpg', 'image/jpeg', 5744225, 0),
(601, '5_birthday_1.JPG', 'content/5_birthday_1_0.JPG', 'image/jpeg', 1922298, 0),
(602, 'logo_3.png', 'content/logo_3_0.png', 'image/png', 2627, 0),
(603, '2б.JPG', 'content/2b_0.JPG', 'image/jpeg', 171627, 0),
(604, '3б_3.jpg', 'content/3b_3_0.jpg', 'image/jpeg', 4636243, 0),
(605, '3в_1.JPG', 'content/3v_1_0.JPG', 'image/jpeg', 4683927, 0),
(606, '3в_2.JPG', 'content/3v_2_0.JPG', 'image/jpeg', 3721626, 0),
(607, '3г_2.JPG', 'content/3g_2_0.JPG', 'image/jpeg', 5148823, 0),
(608, '3а_2.JPG', 'content/3a_2_0.JPG', 'image/jpeg', 2324369, 0),
(609, '2a_2.JPG', 'content/2a_2_0.JPG', 'image/jpeg', 6338383, 0),
(610, '6_cockfights_3.JPG', 'content/6_cockfights_3_0.JPG', 'image/jpeg', 4680374, 0),
(611, '6_Carnival of miners_7.jpg', 'content/6_Carnival_of_miners_7_0.jpg', 'image/jpeg', 3667914, 0),
(612, '6_Carnival of miners_13.jpg', 'content/6_Carnival_of_miners_13_0.jpg', 'image/jpeg', 3511902, 0),
(613, '6_Carnival of miners_15.jpg', 'content/6_Carnival_of_miners_15_0.jpg', 'image/jpeg', 3806355, 0),
(614, '6_Carnival of miners_8.jpg', 'content/6_Carnival_of_miners_8_0.jpg', 'image/jpeg', 6290595, 0),
(615, '6_kupala_7.jpg', 'content/6_kupala_7_0.jpg', 'image/jpeg', 4901663, 0),
(616, '6_kupala_8.JPG', 'content/6_kupala_8_0.JPG', 'image/jpeg', 5206401, 0),
(617, '6_kupala_1.JPG', 'content/6_kupala_1_0.JPG', 'image/jpeg', 3130293, 0),
(618, '6_kupala_17.JPG', 'content/6_kupala_17_0.JPG', 'image/jpeg', 2884729, 0),
(619, '6_cockfights_5.jpg', 'content/6_cockfights_5_0.jpg', 'image/jpeg', 8001128, 0),
(620, '6_cockfights_8.JPG', 'content/6_cockfights_8_0.JPG', 'image/jpeg', 7672268, 0),
(621, '6_pascua toro_3.jpg', 'content/6_pascua_toro_3_0.jpg', 'image/jpeg', 3516735, 0),
(622, 'attack02_0.jpeg', 'content/attack02_0_0.jpeg', 'image/jpeg', 58475, 0),
(623, 'attack02_0.jpeg', 'content/attack02_0_1.jpeg', 'image/jpeg', 58475, 0),
(624, 'anyday-00113599_2.jpg', 'content/anyday-00113599_2_0.jpg', 'image/jpeg', 11259, 0),
(625, 'anyday-00113601_1.jpg', 'content/anyday-00113601_1_0.jpg', 'image/jpeg', 13461, 0),
(626, 'arrest_0.png', 'content/arrest_0_0.png', 'image/png', 203815, 0),
(627, 'anyday-00113599_2.jpg', 'content/anyday-00113599_2_0.jpg', 'image/jpeg', 11259, 0),
(628, 'attack02_0.jpeg', 'content/attack02_0_0.jpeg', 'image/jpeg', 58475, 0),
(629, 'art_stub_3_0.jpg', 'content/art_stub_3_0_0.jpg', 'image/jpeg', 26120, 0),
(630, 'art_stub_3_0.jpg', 'content/art_stub_3_0_0.jpg', 'image/jpeg', 26120, 0),
(631, 'anyday-00113601_1.jpg', 'content/anyday-00113601_1_0.jpg', 'image/jpeg', 13461, 0),
(632, 'attack02_0.jpeg', 'content/attack02_0_0.jpeg', 'image/jpeg', 58475, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_infoblock`
--

CREATE TABLE IF NOT EXISTS `fx_infoblock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_infoblock_id` int(11) NOT NULL DEFAULT '0',
  `site_id` int(11) NOT NULL,
  `page_id` int(10) unsigned NOT NULL,
  `checked` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(255) NOT NULL,
  `controller` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `params` text NOT NULL,
  `scope` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `page_id` (`page_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=210 AUTO_INCREMENT=436 ;

--
-- Дамп данных таблицы `fx_infoblock`
--

INSERT INTO `fx_infoblock` (`id`, `parent_infoblock_id`, `site_id`, `page_id`, `checked`, `name`, `controller`, `action`, `params`, `scope`) VALUES
(345, 0, 18, 2635, 1, '', 'layout', 'show', 'a:0:{}', 'a:2:{s:5:"pages";s:11:"descendants";s:9:"page_type";s:0:"";}'),
(346, 0, 18, 2635, 1, 'Main menu', 'section', 'list_infoblock', 'a:2:{s:7:"submenu";s:3:"all";s:16:"extra_infoblocks";a:1:{i:0;s:3:"385";}}', 'a:2:{s:5:"pages";s:11:"descendants";s:9:"page_type";s:0:"";}'),
(347, 0, 18, 2635, 1, 'Footer nav', 'section', 'list_filtered', 'a:3:{s:10:"conditions";a:1:{s:5:"new_1";a:3:{s:4:"name";s:9:"parent_id";s:8:"operator";s:1:"=";s:5:"value";a:1:{i:0;s:4:"2635";}}}s:7:"submenu";s:4:"none";s:16:"extra_infoblocks";b:0;}', 'a:2:{s:5:"pages";s:11:"descendants";s:9:"page_type";s:0:"";}'),
(359, 345, 18, 2638, 1, '', 'layout', 'show', 'a:0:{}', 'a:2:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";}'),
(360, 0, 18, 2635, 1, 'Navigation / breadcrumbs', 'section', 'breadcrumbs', 'a:2:{s:11:"header_only";s:1:"0";s:13:"hide_on_index";s:1:"0";}', 'a:2:{s:5:"pages";s:8:"children";s:9:"page_type";s:0:"";}'),
(361, 0, 18, 2638, 1, 'Navigation / ', 'section', 'list_filtered', 'a:2:{s:10:"conditions";a:1:{s:5:"new_1";a:3:{s:4:"name";s:9:"parent_id";s:8:"operator";s:1:"=";s:5:"value";a:1:{i:0;s:4:"2638";}}}s:7:"submenu";s:4:"none";}', 'a:2:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";}'),
(362, 0, 18, 2638, 1, 'Navigation / ', 'section', 'list_selected', 'a:1:{s:7:"submenu";s:4:"none";}', 'a:2:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";}'),
(364, 0, 18, 2638, 1, 'Products', 'product', 'list_infoblock', 'a:4:{s:5:"limit";s:0:"";s:7:"sorting";s:6:"manual";s:11:"sorting_dir";s:3:"asc";s:11:"parent_type";s:15:"current_page_id";}', 'a:2:{s:5:"pages";s:8:"children";s:9:"page_type";s:7:"section";}'),
(367, 0, 18, 2638, 1, 'Product / Single entry', 'product', 'record', 'a:0:{}', 'a:2:{s:5:"pages";s:8:"children";s:9:"page_type";s:7:"product";}'),
(369, 0, 18, 2635, 1, 'Product / ', 'product', 'list_selected', 'a:2:{s:7:"sorting";s:6:"manual";s:11:"sorting_dir";s:3:"asc";}', 'a:2:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";}'),
(370, 0, 18, 2635, 1, 'Product / ', 'product', 'list_selected', 'a:2:{s:7:"sorting";s:6:"manual";s:11:"sorting_dir";s:3:"asc";}', 'a:2:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";}'),
(372, 0, 18, 2655, 1, 'Persons', 'person', 'list_infoblock', 'a:4:{s:5:"limit";s:0:"";s:7:"sorting";s:6:"manual";s:11:"sorting_dir";s:3:"asc";s:11:"parent_type";s:15:"current_page_id";}', 'a:3:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";s:10:"visibility";s:3:"all";}'),
(374, 0, 18, 2656, 1, 'Vacancies', 'vacancy', 'list_infoblock', 'a:4:{s:5:"limit";s:0:"";s:7:"sorting";s:6:"manual";s:11:"sorting_dir";s:3:"asc";s:11:"parent_type";s:15:"current_page_id";}', 'a:2:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";}'),
(376, 0, 18, 2656, 1, 'Vacancy / Single entry', 'vacancy', 'record', 'a:0:{}', 'a:2:{s:5:"pages";s:8:"children";s:9:"page_type";s:7:"vacancy";}'),
(379, 0, 18, 2657, 1, 'News', 'news', 'list_infoblock', 'a:4:{s:5:"limit";s:0:"";s:7:"sorting";s:12:"publish_date";s:11:"sorting_dir";s:4:"desc";s:11:"parent_type";s:15:"current_page_id";}', 'a:2:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";}'),
(381, 0, 18, 2635, 1, 'Featured news', 'news', 'list_selected', 'a:3:{s:7:"sorting";s:12:"publish_date";s:11:"sorting_dir";s:4:"desc";s:11:"parent_type";s:15:"current_page_id";}', 'a:3:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";s:10:"visibility";s:3:"all";}'),
(382, 345, 18, 2639, 1, '', 'layout', 'show', 'a:0:{}', 'a:2:{s:5:"pages";s:11:"descendants";s:9:"page_type";s:0:"";}'),
(385, 0, 18, 2639, 1, 'Projects', 'project', 'list_infoblock', 'a:4:{s:5:"limit";s:0:"";s:7:"sorting";s:6:"manual";s:11:"sorting_dir";s:3:"asc";s:11:"parent_type";s:13:"mount_page_id";}', 'a:2:{s:5:"pages";s:11:"descendants";s:9:"page_type";s:0:"";}'),
(386, 0, 18, 2639, 1, 'Project / Single entry', 'project', 'record', 'a:0:{}', 'a:2:{s:5:"pages";s:8:"children";s:9:"page_type";s:7:"project";}'),
(388, 0, 18, 2638, 1, 'Navigation / ', 'section', 'list_filtered', 'a:2:{s:10:"conditions";a:1:{s:5:"new_1";a:3:{s:4:"name";s:9:"parent_id";s:8:"operator";s:1:"=";s:5:"value";a:1:{i:0;s:4:"2638";}}}s:7:"submenu";s:4:"none";}', 'a:2:{s:5:"pages";s:8:"children";s:9:"page_type";s:0:"";}'),
(389, 0, 18, 2639, 1, 'Project gallery', 'photo', 'list_infoblock', 'a:4:{s:5:"limit";s:0:"";s:7:"sorting";s:6:"manual";s:11:"sorting_dir";s:3:"asc";s:11:"parent_type";s:15:"current_page_id";}', 'a:2:{s:5:"pages";s:8:"children";s:9:"page_type";s:7:"project";}'),
(390, 345, 18, 2640, 1, '', 'layout', 'show', 'a:0:{}', 'a:2:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";}'),
(391, 0, 18, 2640, 1, 'Navigation / ', 'section', 'list_selected', 'a:1:{s:7:"submenu";s:4:"none";}', 'a:2:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";}'),
(392, 0, 18, 2640, 1, 'Last news', 'news', 'list_filtered', 'a:5:{s:5:"limit";s:1:"4";s:10:"pagination";s:1:"0";s:7:"sorting";s:7:"created";s:11:"sorting_dir";s:3:"asc";s:10:"conditions";a:1:{s:5:"new_1";a:2:{s:4:"name";s:9:"parent_id";s:8:"operator";s:1:"=";}}}', 'a:2:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";}'),
(397, 0, 18, 2641, 1, 'Contacts text', 'text', 'list_infoblock', 'a:2:{s:5:"limit";s:0:"";s:11:"parent_type";s:15:"current_page_id";}', 'a:2:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";}'),
(398, 0, 18, 2657, 1, 'News / Single entry', 'news', 'record', 'a:0:{}', 'a:2:{s:5:"pages";s:8:"children";s:9:"page_type";s:4:"news";}'),
(399, 345, 18, 2635, 1, '', 'layout', 'show', 'a:0:{}', 'a:2:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";}'),
(400, 0, 18, 2635, 1, 'Navigation / ', 'section', 'list_filtered', 'a:3:{s:10:"conditions";a:2:{s:5:"new_1";a:3:{s:4:"name";s:9:"parent_id";s:8:"operator";s:1:"=";s:5:"value";a:1:{i:0;s:4:"2638";}}s:5:"new_2";a:3:{s:4:"name";s:12:"infoblock_id";s:8:"operator";s:1:"=";s:5:"value";a:1:{i:0;s:3:"346";}}}s:7:"submenu";s:4:"none";s:16:"extra_infoblocks";b:0;}', 'a:3:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";s:10:"visibility";s:3:"all";}'),
(404, 0, 18, 2640, 1, 'Navigation / ', 'section', 'list_filtered', 'a:3:{s:10:"conditions";a:2:{s:5:"new_1";a:3:{s:4:"name";s:9:"parent_id";s:8:"operator";s:1:"=";s:5:"value";a:1:{i:0;s:4:"2640";}}s:5:"new_2";a:3:{s:4:"name";s:12:"infoblock_id";s:8:"operator";s:1:"=";s:5:"value";a:1:{i:0;s:3:"346";}}}s:7:"submenu";s:4:"none";s:16:"extra_infoblocks";b:0;}', 'a:2:{s:5:"pages";s:8:"children";s:9:"page_type";s:0:"";}'),
(408, 0, 18, 2635, 1, 'Auth form', 'user', 'auth_form', 'a:0:{}', 'a:2:{s:5:"pages";s:11:"descendants";s:9:"page_type";s:0:"";}'),
(409, 0, 18, 2635, 1, 'Greet', 'user', 'greet', 'a:0:{}', 'a:2:{s:5:"pages";s:11:"descendants";s:9:"page_type";s:0:"";}'),
(410, 0, 18, 2635, 1, 'Two columns', 'grid', 'two_columns', 'a:0:{}', 'a:2:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";}'),
(411, 0, 18, 2635, 1, 'Featured pages', 'page', 'list_selected', 'a:3:{s:7:"sorting";s:6:"manual";s:11:"sorting_dir";s:3:"asc";s:11:"parent_type";s:15:"current_page_id";}', 'a:2:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";}'),
(412, 0, 18, 2638, 1, 'Product neighbours', 'product', 'neighbours', 'a:3:{s:7:"sorting";s:4:"auto";s:11:"sorting_dir";s:3:"asc";s:15:"group_by_parent";s:1:"1";}', 'a:2:{s:5:"pages";s:8:"children";s:9:"page_type";s:7:"product";}'),
(413, 0, 18, 2657, 1, 'News neighbours', 'news', 'neighbours', 'a:2:{s:7:"sorting";s:4:"auto";s:11:"sorting_dir";s:3:"asc";}', 'a:2:{s:5:"pages";s:8:"children";s:9:"page_type";s:4:"news";}'),
(414, 0, 18, 2656, 1, 'Vacancy neighbours', 'vacancy', 'neighbours', 'a:0:{}', 'a:2:{s:5:"pages";s:8:"children";s:9:"page_type";s:7:"vacancy";}'),
(416, 0, 18, 2639, 1, 'Project neighbours', 'project', 'neighbours', 'a:3:{s:7:"sorting";s:4:"auto";s:11:"sorting_dir";s:3:"asc";s:15:"group_by_parent";s:1:"0";}', 'a:2:{s:5:"pages";s:8:"children";s:9:"page_type";s:7:"project";}'),
(418, 0, 18, 2655, 1, 'Person record', 'person', 'record', 'a:0:{}', 'a:2:{s:5:"pages";s:8:"children";s:9:"page_type";s:6:"person";}'),
(419, 0, 18, 2655, 1, 'Person neighbours', 'person', 'neighbours', 'a:3:{s:7:"sorting";s:4:"auto";s:11:"sorting_dir";s:3:"asc";s:15:"group_by_parent";s:1:"0";}', 'a:2:{s:5:"pages";s:8:"children";s:9:"page_type";s:6:"person";}'),
(422, 0, 18, 2641, 1, 'Map', 'widget_map', 'show', 'a:1:{s:3:"map";a:3:{s:7:"address";s:76:"Большой Саввинский переулок, 12 строение 18";s:3:"lat";s:18:"55.732346350157044";s:3:"lon";s:17:"37.56402175659173";}}', 'a:2:{s:5:"pages";s:11:"descendants";s:9:"page_type";s:0:"";}'),
(423, 345, 18, 2638, 1, '', 'layout', 'show', 'a:0:{}', 'a:2:{s:5:"pages";s:8:"children";s:9:"page_type";s:0:"";}'),
(426, 0, 18, 2773, 1, 'News test', 'news', 'list_infoblock', 'a:4:{s:5:"limit";s:0:"";s:7:"sorting";s:12:"publish_date";s:11:"sorting_dir";s:4:"desc";s:11:"parent_type";s:15:"current_page_id";}', 'a:3:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";s:10:"visibility";s:3:"all";}'),
(427, 0, 18, 2773, 1, 'Menu test', 'section', 'list_infoblock', 'a:2:{s:7:"submenu";s:3:"all";s:16:"extra_infoblocks";a:1:{i:0;s:3:"426";}}', 'a:3:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";s:10:"visibility";s:3:"all";}'),
(429, 0, 18, 2773, 1, 'Sections by filter', 'section', 'list_filtered', 'a:3:{s:10:"conditions";a:1:{s:5:"new_1";a:3:{s:4:"name";s:9:"parent_id";s:8:"operator";s:1:"=";s:5:"value";a:2:{i:0;s:4:"2635";i:1;s:4:"2773";}}}s:7:"submenu";s:3:"all";s:16:"extra_infoblocks";b:0;}', 'a:3:{s:5:"pages";s:11:"descendants";s:9:"page_type";s:0:"";s:10:"visibility";s:3:"all";}'),
(431, 0, 18, 2635, 1, 'Text', 'text', 'list_infoblock', 'a:1:{s:11:"parent_type";s:15:"current_page_id";}', 'a:3:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";s:10:"visibility";s:3:"all";}'),
(435, 0, 18, 2640, 1, 'Person by filter', 'person', 'list_filtered', 'a:5:{s:5:"limit";b:0;s:10:"pagination";s:1:"0";s:7:"sorting";s:4:"name";s:11:"sorting_dir";s:4:"desc";s:10:"conditions";a:1:{s:5:"new_1";a:2:{s:4:"name";s:9:"parent_id";s:8:"operator";s:1:"=";}}}', 'a:3:{s:5:"pages";s:4:"this";s:9:"page_type";s:0:"";s:10:"visibility";s:3:"all";}');

-- --------------------------------------------------------

--
-- Структура таблицы `fx_infoblock_visual`
--

CREATE TABLE IF NOT EXISTS `fx_infoblock_visual` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `infoblock_id` int(10) unsigned NOT NULL,
  `layout_id` int(10) unsigned NOT NULL,
  `wrapper` varchar(255) NOT NULL,
  `wrapper_visual` text NOT NULL,
  `template` varchar(255) NOT NULL,
  `template_visual` text NOT NULL,
  `area` varchar(50) NOT NULL,
  `priority` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `infoblock_id` (`infoblock_id`,`layout_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=138 AUTO_INCREMENT=604 ;

--
-- Дамп данных таблицы `fx_infoblock_visual`
--

INSERT INTO `fx_infoblock_visual` (`id`, `infoblock_id`, `layout_id`, `wrapper`, `wrapper_visual`, `template`, `template_visual`, `area`, `priority`) VALUES
(59, 57, 1, 'theme.floxim.supernova:wrap_titled', '', 'page:list', '', 'content', 8),
(417, 345, 12, '', '', 'theme.floxim.phototeam:two_columns', 'a:7:{s:5:"phone";s:17:"8 (800) 123 12 45";s:4:"logo";s:0:"";s:17:"two_column_header";s:29:"\n                Yes, we can!";s:17:"one_column_header";s:25:"\n                Our news";s:9:"logo_name";s:10:"Photo Team";s:8:"icon_408";s:43:"/floxim_files/content/icon_login_active.png";s:8:"icon_409";s:39:"/floxim_files/content/icon_login_on.png";}', '', 1),
(418, 346, 12, '', '', 'theme.floxim.phototeam:main_menu', '', 'top_nav', 1),
(419, 347, 12, '', '', 'theme.floxim.phototeam:footer_menu', '', 'footer_menu', 1),
(431, 359, 12, '', '', 'theme.floxim.phototeam:one_column', '', '', 2),
(432, 360, 12, '', '', 'theme.floxim.phototeam:breadcrumbs', '', 'breadcrumbs-area', 1),
(433, 361, 12, '', '', 'theme.floxim.phototeam:featured_list', 'a:7:{s:5:"image";s:38:"/floxim_files/content/HansIsland_0.png";s:10:"image_2652";s:35:"/floxim_files/content/5_ski_4_0.JPG";s:10:"four_items";s:1:"1";s:8:"image_id";s:32:"/floxim_files/content/7394_0.jpg";s:10:"image_2654";s:40:"/floxim_files/content/5_people_cover.jpg";s:10:"image_2658";s:38:"/floxim_files/content/5_nature_5_0.jpg";s:10:"image_2744";s:40:"/floxim_files/content/6_events_cover.jpg";}', 'main_column', 2),
(434, 362, 12, '', '', 'theme.floxim.phototeam:banner', 'a:3:{s:18:"banner_header_2652";s:37:"<p class="">\n	 Special conditions</p>";s:16:"banner_text_2652";s:34:"<p class="">\n	For sport series</p>";s:17:"banner_image_2652";s:34:"/floxim_files/content/5_swim_0.jpg";}', 'main_column', 1),
(436, 364, 12, '', '', 'theme.floxim.phototeam:featured_list', 'a:1:{s:10:"four_items";s:1:"0";}', 'main_column', 3),
(439, 367, 12, '', '', 'theme.floxim.phototeam:product_record', '', 'main_column', 4),
(441, 369, 12, '', '', 'theme.floxim.phototeam:banner', 'a:6:{s:18:"banner_header_2660";s:28:"<p>\n	  Greate ship\n</p>\n<br>";s:16:"banner_text_2660";s:43:"<p>\n	It''s really <strong>cool</strong>\n</p>";s:7:"go_2660";s:2:"Go";s:17:"banner_image_2740";s:32:"/floxim_files/content/3b_6_0.jpg";s:16:"banner_text_2740";s:21:"Better than ever\n<br>";s:18:"banner_header_2740";s:34:"<p class="">Portrait figartret</p>";}', 'grid_content_410', 1),
(442, 370, 12, '', 'a:1:{s:6:"header";s:10:"Best ships";}', 'theme.floxim.phototeam:featured_list', 'a:2:{s:10:"four_items";s:1:"0";s:10:"photo_2743";s:0:"";}', 'grid_content_410', 2),
(444, 372, 12, '', '', 'theme.floxim.phototeam:person_list', 'a:4:{s:13:"facebook_2671";s:0:"";s:7:"vk_2671";s:0:"";s:7:"li_2671";s:0:"";s:12:"twitter_2671";s:0:"";}', 'main_column', 5),
(446, 374, 12, '', '', 'theme.floxim.phototeam:vacancies_list', 'a:3:{s:14:"more_info_2677";s:27:"More info about the vacancy";s:14:"more_info_2771";s:22:"more info for supermen";s:14:"more_info_2791";s:9:"More info";}', 'main_column', 6),
(451, 379, 12, '', '', 'theme.floxim.phototeam:news_mixed', 'a:3:{s:9:"show_more";s:1:"0";s:12:"show_anounce";s:1:"1";s:14:"count_featured";s:1:"2";}', 'main_column', 7),
(453, 381, 12, 'theme.floxim.phototeam:gray_block', 'a:1:{s:6:"header";s:16:"What''s happening";}', 'theme.floxim.phototeam:featured_news_list', 'a:3:{s:13:"more_news_url";s:5:"/news";s:9:"show_more";s:1:"1";s:12:"show_anounce";s:1:"1";}', 'main_column', 16),
(454, 382, 12, '', '', 'theme.floxim.phototeam:full_width', '', '', 8),
(457, 385, 12, '', '', 'theme.floxim.phototeam:full_screen_menu', 'a:13:{s:7:"bg_2688";s:38:"/floxim_files/content/HansIsland_8.png";s:3:"bg_";s:0:"";s:7:"bg_2690";s:69:"/floxim_files/content/1280px-Sortie_de_l_op_ra_en_l_an_2000-2_1_0.jpg";s:11:"header_2688";s:0:"";s:12:"caption_2688";s:71:"<p>\n	 The carnival of Potosi\n</p>\n<p>\n	<strong>in Bolivia</strong>\n</p>";s:11:"header_2690";s:0:"";s:11:"header_2639";s:42:"<p>\n	 Our projects\n</p>\n<p>\n	are cool\n</p>";s:12:"caption_2639";s:11:"Ain''t they?";s:12:"caption_2690";s:27:"<p>\n	The age old sport\n</p>";s:7:"bg_2639";s:30:"/floxim_files/content/2a_2.JPG";s:12:"caption_2751";s:20:"<p>\n	Pagan fest\n</p>";s:12:"caption_2757";s:28:"<p>\n	a.k.a. Pascua Toro\n</p>";s:7:"bg_2761";s:0:"";}', 'main_column', 12),
(458, 386, 12, 'theme.floxim.phototeam:block_titled', 'a:1:{s:6:"header";s:17:"About the project";}', 'theme.floxim.phototeam:project_record', '', 'main_column', 13),
(460, 388, 12, '', '', 'theme.floxim.phototeam:side_menu', 'a:1:{s:10:"unstylized";s:1:"0";}', 'left_column', 1),
(461, 389, 12, 'theme.floxim.phototeam:block_titled', 'a:1:{s:6:"header";s:6:"Images";}', 'theme.floxim.phototeam:slider', 'a:1:{s:10:"thumbnails";s:1:"1";}', 'main_column', 14),
(462, 390, 12, '', '', 'theme.floxim.phototeam:one_column', '', '', 9),
(463, 391, 12, '', '', 'theme.floxim.phototeam:banner', 'a:3:{s:18:"banner_header_2656";s:27:"<p class="">\n	Need job?</p>";s:16:"banner_text_2656";s:39:"<p class="">\n	Look at our vacancies</p>";s:17:"banner_image_2656";s:40:"/floxim_files/content/5_open_air_2_0.jpg";}', 'main_column', 9),
(464, 392, 12, 'theme.floxim.phototeam:gray_block', 'a:1:{s:6:"header";s:11:"Latest news";}', 'theme.floxim.phototeam:featured_news_list', 'a:4:{s:13:"more_news_url";s:5:"/News";s:9:"show_more";s:1:"1";s:12:"show_anounce";s:1:"0";s:9:"more_news";s:8:"all news";}', 'main_column', 8),
(469, 397, 12, '', '', 'theme.floxim.phototeam:text', 'a:3:{s:9:"blue_2701";s:1:"1";s:9:"blue_2700";s:1:"0";s:12:"hilight_2701";s:1:"1";}', 'main_column', 10),
(470, 398, 12, '', '', 'theme.floxim.phototeam:news_record', '', 'main_column', 11),
(471, 399, 12, '', '', 'theme.floxim.phototeam:index', '', '', 11),
(472, 400, 12, '', '', 'theme.floxim.phototeam:side_menu', 'a:1:{s:10:"unstylized";s:1:"0";}', 'grid_sidebar_410', 1),
(476, 404, 12, '', '', 'theme.floxim.phototeam:side_menu', 'a:1:{s:10:"unstylized";s:1:"0";}', 'left_column', 2),
(575, 408, 12, '', '', 'theme.floxim.phototeam:auth_form', 'a:4:{s:11:"label_email";s:30:"E-mail                        ";s:14:"label_password";s:8:"Password";s:14:"label_remember";s:11:"Remember me";s:12:"label_submit";s:6:"Log in";}', 'icons_area', 1),
(576, 409, 12, '', '', 'user:greet', '', 'icons_area', 2),
(577, 410, 12, 'theme.floxim.phototeam:titled_block', 'a:1:{s:6:"header";s:51:"We shoot everything and everywhere around the world";}', 'theme.floxim.phototeam:two_columns_grid', '', 'main_column', 17),
(578, 411, 12, '', '', 'theme.floxim.phototeam:full_screen_menu', 'a:3:{s:11:"header_2635";s:52:"<p class="">Team of</p><p class="">photographers</p>";s:12:"caption_2635";s:100:"We come in&nbsp;any&nbsp;sizes and shapes ready <em>to<br></em>\n	shoot any series&nbsp;you like.<br>";s:7:"bg_2635";s:44:"/floxim_files/content/6_pascua_toro_19_0.JPG";}', 'main_column', 15),
(579, 412, 12, '', '', 'page:neighbours', '', 'main_column', 18),
(580, 413, 12, '', '', 'page:neighbours', '', 'main_column', 19),
(581, 414, 12, '', '', 'page:neighbours', '', 'main_column', 28),
(583, 416, 12, '', '', 'page:neighbours', '', 'main_column', 20),
(585, 418, 12, '', '', 'theme.floxim.phototeam:person_record', '', 'main_column', 21),
(586, 419, 12, '', '', 'page:neighbours', '', 'main_column', 22),
(588, 376, 12, '', '', 'theme.floxim.phototeam:vacancy_record', '', 'main_column', 23),
(590, 422, 12, '', '', 'widget_map:static_google_map', 'a:3:{s:9:"map_width";s:3:"940";s:10:"map_height";s:3:"340";s:8:"map_zoom";s:2:"14";}', 'main_column', 24),
(591, 423, 12, '', '', 'theme.floxim.phototeam:one_column', '', '', 12),
(594, 426, 12, '', '', 'theme.floxim.phototeam:featured_news_list', 'a:5:{s:12:"show_anounce";s:1:"1";s:18:"read_more_#new_id#";s:4:"More";s:14:"read_more_2778";s:4:"More";s:14:"read_more_2782";s:11:"Reed Mooore";s:14:"read_more_2783";s:16:"Read more please";}', 'main_column', 25),
(595, 427, 12, 'theme.floxim.phototeam:block_titled', 'a:1:{s:6:"header";s:9:"Infoblock";}', 'section:listing_deep', '', 'main_column', 26),
(597, 429, 12, 'theme.floxim.phototeam:block_titled', 'a:1:{s:6:"header";s:8:"Filtered";}', 'section:listing_deep', '', 'main_column', 27),
(599, 431, 12, '', '', 'text:list', '', 'sidebar_430', 1),
(603, 435, 12, 'theme.floxim.phototeam:titled_block', 'a:1:{s:6:"header";s:19:"Meet the super team";}', 'theme.floxim.phototeam:featured_list', 'a:1:{s:10:"four_items";s:1:"1";}', 'main_column', 30);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_lang`
--

CREATE TABLE IF NOT EXISTS `fx_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `en_name` varchar(100) NOT NULL,
  `native_name` varchar(100) NOT NULL,
  `lang_code` varchar(5) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lang_code` (`lang_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Дамп данных таблицы `fx_lang`
--

INSERT INTO `fx_lang` (`id`, `en_name`, `native_name`, `lang_code`) VALUES
(1, 'English', 'English', 'en'),
(9, 'Russian', 'Русский', 'ru');

-- --------------------------------------------------------

--
-- Структура таблицы `fx_lang_string`
--

CREATE TABLE IF NOT EXISTS `fx_lang_string` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dict` varchar(45) DEFAULT NULL,
  `string` text,
  `lang_en` text,
  `lang_ru` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1097 ;

--
-- Дамп данных таблицы `fx_lang_string`
--

INSERT INTO `fx_lang_string` (`id`, `dict`, `string`, `lang_en`, `lang_ru`) VALUES
(1, 'component_section', 'Show path to the current page', 'Show path to the current page', 'Отображает путь до текущей страницы в структуре сайта'),
(2, 'component_section', 'Bread crumbs', 'Bread crumbs', 'Хлебные крошки'),
(3, 'component_section', 'Subsection', 'Subsection', 'Подраздел'),
(4, 'component_section', 'Show for all items', 'Show for all items', 'Показывать у всех'),
(5, 'component_section', 'Show for the active item', 'Show for the active item', 'Показывать у активного'),
(6, 'component_section', 'Don''t show', 'Don''t show', 'Не показывать'),
(7, 'component_section', 'Subsections', 'Subsections', 'Подразделы'),
(8, 'component_section', 'Navigation', 'Navigation', 'Меню'),
(9, 'system', 'File is not writable', 'File is not writable', 'Не могу произвести запись в файл'),
(10, 'controller_component', 'Show entries by filter', 'Show entries by filter', 'Выводит записи по произвольному фильтру'),
(11, 'controller_component', 'Show entries from the specified section', 'Show entries from the specified section', 'Выводит список записей из указанного раздела'),
(12, 'controller_component', 'List', 'List', 'Список'),
(13, 'controller_component', 'Show single entry', 'Show single entry', 'Выводит отдельную запись'),
(14, 'controller_component', 'Entry', 'Entry', 'Запись'),
(15, 'controller_component', 'From specified section', 'From specified section', 'Указать раздел явно'),
(16, 'controller_component', 'From all sections', 'From all sections', 'Из любого раздела'),
(17, 'controller_component', 'Choose section', 'Choose section', 'Выбрать родителя'),
(18, 'controller_component', 'Random', 'Random', 'Произвольный'),
(19, 'controller_component', 'The infoblock owner section', 'The infoblock owner section', 'Страница, куда прицеплен инфоблок'),
(20, 'controller_component', 'Current page', 'Current page', 'Текущая страница'),
(21, 'controller_component', 'Parent', 'Parent', 'Родитель'),
(22, 'controller_component', 'Ascending', 'Ascending', 'По возрастанию'),
(23, 'controller_component', 'Descending', 'Descending', 'По убыванию'),
(24, 'controller_component', 'Order', 'Order', 'Порядок'),
(25, 'controller_component', 'Sorting', 'Sorting', 'Сортировка'),
(26, 'controller_component', 'Manual', 'Manual', 'Ручная'),
(27, 'controller_component', 'Created', 'Created', 'Дата создания'),
(28, 'controller_component', 'Show pagination?', 'Show pagination?', 'Разбивать на страницы?'),
(29, 'controller_component', 'How many entries to display', 'How many entries to display', 'Сколько выводить'),
(30, 'controller_layout', 'Sign in', 'Sign in', 'Вход'),
(31, 'system', 'Add infoblock', 'Add infoblock', 'Добавить инфоблок'),
(32, 'system', 'Link', 'Link', 'Ссылка'),
(33, 'system', 'Picture', 'Picture', 'Картинка'),
(34, 'system', 'Elements', 'Elements', 'Элементы'),
(35, 'system', 'Classifier', 'Classifier', 'Классификатор'),
(36, 'system', 'Manually', 'Manually', 'Вручную'),
(37, 'system', 'Source', 'Source', 'Источник'),
(38, 'system', 'Show like', 'Show like', 'Показывать как'),
(39, 'system', 'Current file:', 'Current file:', 'Текущий файл:'),
(40, 'system', 'replace newline to br', 'Replace newline with &lt;br /&gt;', 'заменять перенос строки на br'),
(41, 'system', 'allow HTML tags', 'Allow HTML tags', 'разрешить html-теги'),
(42, 'system', 'Related type', 'Related type', 'Связанный тип'),
(43, 'system', 'Bind value to the parent', 'Bind value to the parent', 'Привязать значение к родителю'),
(44, 'system', 'Key name for the property', 'Key name for the property', 'Ключ для свойства'),
(45, 'system', 'Links to', 'Links to', 'Куда ссылается'),
(46, 'system', 'Enter the name of the site', 'Enter the name of the site', 'Укажите название сайта'),
(47, 'system', 'Priority', 'Priority', 'Приоритет'),
(49, 'system', 'This keyword is used by the component', 'This keyword is used by the component', 'Такой keyword уже используется компоненте'),
(50, 'system', 'Keyword can only contain letters, numbers, symbols, "hyphen" and "underscore"', 'Keyword can only contain letters, numbers, symbols, "hyphen" and "underscore"', 'Keyword может содержать только буквы, цифры, символы "дефис" и "подчеркивание"'),
(51, 'system', 'Specify component keyword', 'Specify component keyword', 'Укажите keyword компонента'),
(52, 'system', 'Component name can not be empty', 'Component name can not be empty', 'Название компонента не может быть пустым'),
(53, 'system', 'Specify field description', 'Specify field description', 'Укажите описание поля'),
(54, 'system', 'This field already exists', 'This field already exists', 'Такое поле уже существует'),
(55, 'system', 'This field is reserved', 'This field is reserved', 'Данное поле зарезервировано'),
(56, 'system', 'Field name can contain only letters, numbers, and the underscore character', 'Field name can contain only letters, numbers, and the underscore character', 'Имя поля может содержать только латинские буквы, цифры и знак подчеркивания'),
(57, 'system', 'name', 'name', 'название'),
(58, 'system', 'Specify field name', 'Specify field name', 'Укажите название поля'),
(59, 'system', 'This keyword is used by widget', 'This keyword is used by widget', 'Такой keyword уже используется в виджете'),
(60, 'system', 'Keyword can contain only letters and numbers', 'Keyword can contain only letters and numbers', 'Keyword может сожержать только буквы и цифры'),
(61, 'system', 'Enter the keyword of widget', 'Enter the keyword of widget', 'Укажите keyword виджета'),
(62, 'system', 'Specify the name of the widget', 'Specify the name of the widget', 'Укажите название виджета'),
(63, 'system', 'You are about to install:', 'You are about to install:', 'Вы собираетесь установить:'),
(64, 'system', 'Preview', 'Preview', 'Превью'),
(65, 'system', 'Layout', 'Layout', 'Макет'),
(66, 'system', 'Show when the site is off', 'Show when the site is off', 'Показывать, когда сайт выключен'),
(67, 'system', 'Cover Page', 'Cover Page', 'Титульная страница'),
(68, 'system', 'Prevent indexing', 'Prevent indexing', 'Запретить индексирование'),
(69, 'system', 'The contents of robots.txt', 'The contents of robots.txt', 'Содержимое robots.txt'),
(70, 'system', 'Site language', 'Site language', 'Язык сайта'),
(71, 'system', 'Aliases', 'Aliases', 'Зеркала'),
(72, 'system', 'Domain', 'Domain', 'Домен'),
(73, 'system', 'Site name', 'Site name', 'Название сайта'),
(74, 'system', 'Enabled', 'Enabled', 'Включен'),
(75, 'system', 'System', 'System', 'Системные'),
(76, 'system', 'Main', 'Main', 'Основные'),
(77, 'system', 'any', 'any', 'любое'),
(78, 'system', 'vertical', 'vertical', 'вертикальное'),
(79, 'system', 'Menu', 'Menu', 'Меню'),
(80, 'system', 'Direction', 'Direction', 'Направление'),
(81, 'system', 'Required', 'Required', 'Обязательный'),
(82, 'system', 'Block', 'Block', 'Блок'),
(83, 'system', 'Blocks', 'Blocks', 'Блоки'),
(84, 'system', 'Sites', 'Sites', 'Сайты'),
(85, 'system', 'Design', 'Design', 'Дизайн'),
(86, 'system', 'Settings', 'Settings', 'Настройки'),
(87, 'system', 'Site map', 'Site map', 'Карта сайта'),
(88, 'system', 'Site not found', 'Site not found', 'Сайт не найден'),
(89, 'system', 'Page not found', 'Page not found', 'Страница не найдена'),
(90, 'system', 'Error creating a temporary file', 'Error creating a temporary file', 'Ошибка при создании временного файла'),
(91, 'system', 'Create a new site', 'Create a new site', 'Добавление нового сайта'),
(92, 'system', 'Add new site', 'Add new site', 'Новый сайт'),
(93, 'system', 'New', 'New', 'Новый'),
(94, 'system', 'Export', 'Export', 'Экспорт'),
(95, 'system', 'for mobile devices', 'for mobile devices', 'для мобильный устройств'),
(96, 'system', 'Language:', 'Language:', 'Язык:'),
(97, 'system', 'Description', 'Description', 'Описание'),
(98, 'system', 'Group', 'Group', 'Группа'),
(99, 'system', 'Another group', 'Another group', 'Другая группа'),
(100, 'system', 'Name of entity created by the component', 'Name of entity created by the component', 'Название сущности, создаваемой компонентом'),
(101, 'system', 'Component name', 'Component name', 'Название компонента'),
(102, 'system', 'Keyword:', 'Keyword:', 'Ключевое слово:'),
(103, 'system', '--no--', '--no--', '--нет--'),
(104, 'system', 'Parent component', 'Parent component', 'Компонент-родитель'),
(105, 'system', 'default', 'default', 'по умолчанию'),
(106, 'system', 'Components', 'Components', 'Компоненты'),
(107, 'system', 'Widgets', 'Widgets', 'Виджеты'),
(108, 'system', 'Keyword', 'Keyword', 'Ключевое слово'),
(109, 'system', 'File', 'File', 'Файл'),
(110, 'system', 'Fields', 'Fields', 'Поля'),
(111, 'system', 'Install from FloximStore', 'Install from FloximStore', 'установить с FloximStore'),
(112, 'system', 'import', 'import', 'импортировать'),
(113, 'system', 'Layout of inside page', 'Layout of inside page', 'Макет внутренней страницы'),
(114, 'system', 'Cover Page Layout', 'Cover Page Layout', 'Макет титульной страницы'),
(115, 'system', 'Sign out', 'Sign out', 'Выход'),
(116, 'system', 'Apply the current', 'Apply the current', 'Применить текущий'),
(117, 'system', 'Colors', 'Colors', 'Расцветка'),
(118, 'system', 'Layout not found', 'Layout not found', 'Макет не найден'),
(119, 'system', 'Enter the layout name', 'Enter the layout name', 'Укажите название макета'),
(120, 'system', 'Layout name', 'Layout name', 'Название макета'),
(121, 'system', 'Export to file', 'Export to file', 'Экспортировать в файл'),
(122, 'system', 'No files', 'No files', 'Нет файлов'),
(123, 'system', 'Layouts', 'Layouts', 'Макеты'),
(124, 'system', 'Unable to create directory', 'Unable to create directory', 'Не удалось создать каталог'),
(125, 'system', 'Adding a layout design', 'Adding a layout design', 'Добавление макета дизайна'),
(126, 'system', 'Import layout design', 'Import layout design', 'Импорт макета дизайна'),
(127, 'system', 'empty', 'empty', 'пустой'),
(128, 'system', 'Used on', 'Used on', 'Используется на сайтах'),
(129, 'system', 'Repeated', 'Repeated', 'Повторено'),
(130, 'system', 'Cancelled', 'Cancelled', 'Отменено'),
(131, 'system', 'Header sent', 'Header sent', 'Посылаемый заголовок'),
(132, 'system', 'New url', 'New url', 'Новый url'),
(133, 'system', 'Old url', 'Old url', 'Старый url'),
(134, 'system', 'Changing the transfer rule', 'Changing the transfer rule', 'Изменение правила переадресации'),
(135, 'system', 'Adding forwarding rules', 'Adding forwarding rules', 'Добавление правила переадресации'),
(136, 'system', 'Header', 'Header', 'Заголовок'),
(137, 'system', 'Layouts can not be deleted', 'Layouts can not be deleted', 'Удалять лейауты нельзя!'),
(138, 'system', 'Unbind/Hide', 'Unbind/Hide', 'Отвязать/скрыть'),
(139, 'system', 'Delete', 'Delete', 'Удалить'),
(140, 'system', 'The infoblock contains some content', 'The infoblock contains some content', 'Инфоблок содержит контент'),
(141, 'system', 'items. What should we do with them?', 'items. What should we do with them?', ' шт. Что с ним делать?'),
(142, 'system', 'I am REALLY shure', 'I am REALLY shure', 'Будет удалено куча всего, я понимаю последствия'),
(143, 'system', 'Block wrapper template', 'Block wrapper template', 'Оформление блока'),
(144, 'system', 'Template', 'Template', 'Шаблон'),
(145, 'system', 'Auto select', 'Auto select', 'Автовыбор'),
(146, 'system', 'With no wrapper', 'With no wrapper', 'Без оформления'),
(147, 'system', 'On the page and it''s children', 'On the page and it''s children', 'На этой и на вложенных'),
(148, 'system', 'Only on children', 'Only on children', 'Только на вложенных страницах'),
(149, 'system', 'Only on the page', 'Only on the page', 'Только на этой странице'),
(150, 'system', 'Page', 'Page', 'Страница'),
(151, 'system', 'On all pages', 'On all pages', 'На всех страницах'),
(152, 'system', 'Remove this rule', 'Remove this rule', 'Удалить это правило'),
(153, 'system', 'Create a new rule', 'Create a new rule', 'Создать новое правило'),
(154, 'system', 'Update', 'Update', 'Обновить'),
(155, 'system', 'Create', 'Create', 'Создать'),
(156, 'system', 'Page layout', 'Page layout', 'Выбор шаблона страницы'),
(157, 'system', 'Infoblock settings', 'Infoblock settings', 'Настройка инфоблока'),
(158, 'system', 'Where to show', 'Where to show', 'Где показывать'),
(159, 'system', 'How to show', 'How to show', 'Как показывать'),
(160, 'system', 'Block name', 'Block name', 'Название блока'),
(161, 'system', 'What to show', 'What to show', 'Что показывать'),
(162, 'system', 'Widget', 'Widget', 'Виджет'),
(163, 'system', 'Next', 'Next', 'Продолжить'),
(164, 'system', 'Install from Store', 'Install from Store', 'Установить с Store'),
(165, 'system', 'Adding infoblock', 'Adding infoblock', 'Добавление инфоблока'),
(166, 'system', 'Type', 'Type', 'Тип'),
(167, 'system', 'Action', 'Action', 'Действие'),
(169, 'system', 'Component', 'Component', 'Компонент'),
(170, 'system', 'Single entry', 'Single entry', 'Отдельный объект'),
(171, 'system', 'Mirror', 'Mirror', 'Mirror'),
(173, 'system', 'Change password', 'Change password', 'Сменить пароль'),
(175, 'system', 'Download from FloximStore', 'Download from FloximStore', 'Скачать с FloximStore'),
(176, 'system', 'Download file', 'Download file', 'Cкачать файл'),
(177, 'system', 'Upload file', 'Upload file', 'Закачать файл'),
(178, 'system', 'Permissions', 'Permissions', 'Права'),
(179, 'system', 'Select parent block', 'Select parent block', 'выделить блок'),
(180, 'system', 'Site layout', 'Site layout', 'Сменить макет сайта'),
(181, 'system', 'Page design', 'Page design', 'Дизайн страницы'),
(182, 'system', 'Development', 'Development', 'Разработка'),
(183, 'system', 'Administration', 'Administration', 'Администрирование'),
(184, 'system', 'Tools', 'Tools', 'Инструменты'),
(185, 'system', 'Users', 'Users', 'Пользователи'),
(186, 'system', 'Site', 'Site', 'Сайт'),
(187, 'system', 'Management', 'Management', 'Управление'),
(188, 'system', 'Default value', 'Default value', 'Значение по умолчанию'),
(189, 'system', 'Field can be used for searching', 'Field can be used for searching', 'Возможен поиск по полю'),
(191, 'system', 'Field not found', 'Field not found', 'Поле не найдено'),
(192, 'system', 'Field is available for', 'Field is available for', 'Поле доступно'),
(193, 'system', 'anybody', 'anybody', 'всем'),
(194, 'system', 'admins only', 'admins only', 'только админам'),
(195, 'system', 'nobody', 'nobody', 'никому'),
(196, 'system', 'Field type', 'Field type', 'Тип поля'),
(197, 'system', 'Field keyword', 'Field keyword', 'Название на латинице'),
(199, 'system', 'New widget', 'New widget', 'Новый виджет'),
(200, 'system', 'Widget size', 'Widget size', 'Размер виджета'),
(201, 'system', 'Mini Block', 'Mini Block', 'Миниблок'),
(202, 'system', 'Narrow', 'Narrow', 'Узкий'),
(203, 'system', 'Wide', 'Wide', 'Широкий'),
(204, 'system', 'Narrowly wide', 'Narrowly wide', 'Узко-широкий'),
(205, 'system', 'Icon to be used', 'Icon to be used', 'Используемая иконка'),
(206, 'system', 'This icon is used by default', 'This icon is used by default', 'эта иконка используется по умолчанию'),
(207, 'system', 'This icon is icon.png file in the directory widget', 'This icon is icon.png file in the directory widget', 'эта иконка находится в файле icon.png в директории виджета'),
(208, 'system', 'This icon is selected from a list of icons', 'This icon is selected from a list of icons', 'эта иконка выбрана из списка иконок'),
(209, 'system', 'Enter the widget name', 'Enter the widget name', 'Введите название виджета'),
(210, 'system', 'Specify the name', 'Specify the name', 'Укажите название'),
(211, 'system', 'Edit User Group', 'Edit User Group', 'Изменение группы пользователей'),
(212, 'system', 'Add User Group', 'Add User Group', 'Добавление группы пользователей'),
(213, 'system', 'New Group', 'New Group', 'Новая группа'),
(214, 'system', 'Assign the right director', 'Assign the right director', 'Присвоить право директора'),
(215, 'system', 'The first version has just the right director', 'The first version has just the right director', 'В первой версии есть только право Директор'),
(216, 'system', 'There are no rules', 'There are no rules', 'Нет никак прав'),
(217, 'system', 'Permission', 'Permission', 'Право'),
(218, 'system', 'Content edit', 'Content edit', 'Редактирование контента'),
(219, 'system', 'Avatar', 'Avatar', 'Аватар'),
(220, 'system', 'Nick', 'Nick', 'Имя на сайте'),
(221, 'system', 'Confirm password', 'Confirm password', 'Пароль еще раз'),
(222, 'system', 'Password', 'Password', 'Пароль'),
(223, 'system', 'Login', 'Login', 'Логин'),
(224, 'system', 'Groups', 'Groups', 'Группы'),
(225, 'system', 'Passwords do not match', 'Passwords do not match', 'Пароли не совпадают'),
(226, 'system', 'Password can''t be empty', 'Password can''t be empty', 'Пароль не может быть пустым'),
(227, 'system', 'Fill in with the login', 'Fill in with the login', 'Заполните поле с логином'),
(228, 'system', 'Please select at least one group', 'Please select at least one group', 'Выберите хотя бы одну группу'),
(229, 'system', 'Add User', 'Add User', 'Добавление пользователя'),
(230, 'system', 'publications in', 'publications in', 'публикации в'),
(231, 'system', 'Select objects', 'Select objects', 'Выберите объекты'),
(232, 'system', 'publish:', 'publish:', 'опубликовал:'),
(234, 'system', 'friends, send message', 'friends, send message', 'друзья, отправить сообщение'),
(235, 'system', 'registred:', 'registred:', 'зарегистрирован:'),
(236, 'system', 'Activity', 'Activity', 'Активность'),
(237, 'system', 'Registration data', 'Registration data', 'Регистрационные данные'),
(238, 'system', 'Rights management', 'Rights management', 'Управление правами'),
(239, 'system', 'Password and verification do not match.', 'Password and verification do not match.', 'Пароль и подтверждение не совпадают.'),
(240, 'system', 'Password is too short. The minimum length of the password', 'Password is too short. The minimum length of the password', 'Пароль слишком короткий. Минимальная длина пароля'),
(241, 'system', 'Enter the password', 'Enter the password', 'Введите пароль.'),
(242, 'system', 'This login is already in use', 'This login is already in use', 'Такой логин уже используется'),
(243, 'system', 'Error: can not find information block with users.', 'Error: can not find information block with users.', 'Ошибка: не найден инфоблок с пользователями.'),
(244, 'system', 'Self-registration is prohibited.', 'Self-registration is prohibited.', 'Самостоятельная регистрация запрещена.'),
(245, 'system', 'Can not find <? ​​Php class file', 'Can not find <? ​​Php class file', 'Не могу найти <?php в файле класса'),
(246, 'system', 'Syntax error in the component class', 'Syntax error in the component class', 'Синтаксическая ошибка в классе компонента'),
(247, 'system', 'Syntax error in function', 'Syntax error in function', 'Синтаксическая ошибка в функции'),
(248, 'system', 'Profile', 'Profile', 'Профиль'),
(249, 'system', 'User not found', 'User not found', 'Пользователь не найден'),
(250, 'system', 'List not found', 'List not found', 'Список не найден'),
(252, 'system', 'Widget not found', 'Widget not found', 'Виджет не найден'),
(253, 'system', 'Component not found', 'Component not found', 'Компонент не найден'),
(254, 'system', 'Modules', 'Modules', 'Модули'),
(255, 'system', 'All sites', 'Sites', 'Список сайтов'),
(256, 'system', 'Unable to connect to server', 'Unable to connect to server', 'Не удалось соединиться с сервером'),
(257, 'system', 'Override the settings in the class', 'Override the settings in the class', 'Переопределите метод settings в своем классе'),
(258, 'system', 'Configuring the', 'Configuring the', 'Настройка модуля'),
(260, 'system', 'Saved', 'Saved', 'Сохранено'),
(261, 'system', 'Could not open file!', 'Could not open file!', 'Не получилось открыть файл!'),
(262, 'system', 'Error when downloading a file', 'Error when downloading a file', 'Ошибка при закачке файла'),
(263, 'system', 'Enter the file', 'Enter the file', 'Укажите файл'),
(264, 'system', 'Not all fields are transferred!', 'Not all fields are transferred!', 'Не все поля переданы!'),
(265, 'system', 'Error Deleting File', 'Error Deleting File', 'Ошибка при удалении файла'),
(266, 'system', 'Error when changing the name', 'Error when changing the name', 'Ошибка при изменении имени'),
(267, 'system', 'Error when permission', 'Error when permission', 'Ошибка при изменении прав доступа'),
(268, 'system', 'Set permissions', 'Set permissions', 'Задайте права доступа'),
(269, 'system', 'Enter the name', 'Enter the name', 'Укажите имя'),
(270, 'system', 'Edit the file/directory', 'Edit the file/directory', 'Правка файла/директории'),
(271, 'system', 'View the contents', 'View the contents', 'Просмотр содержимого'),
(272, 'system', 'Execution', 'Execution', 'Выполнение'),
(273, 'system', 'Writing', 'Writing', 'Запись'),
(274, 'system', 'Reading', 'Reading', 'Чтение'),
(275, 'system', 'Permissions for the rest', 'Permissions for the rest', 'Права для остальных'),
(276, 'system', 'Permissions for the group owner', 'Permissions for the group owner', 'Права для группы-владельца'),
(277, 'system', 'Permissions for the user owner', 'Permissions for the user owner', 'Права для пользователя-владельца'),
(278, 'system', 'Do not pass the file name!', 'Do not pass the file name!', 'Не передано имя файла!'),
(279, 'system', 'An error occurred while creating the file/directory', 'An error occurred while creating the file/directory', 'Ошибка при создании файла/каталога'),
(280, 'system', 'Not all fields are transferred', 'Not all fields are transferred', 'Не все поля переданы'),
(281, 'system', 'Enter the name of the file/directory', 'Enter the name of the file/directory', 'Укажите имя файла/каталога'),
(282, 'system', 'Create a new file/directory', 'Create a new file/directory', 'Создание нового файла/директории'),
(283, 'system', 'Name of file/directory', 'Name of file/directory', 'Имя файла/каталога'),
(284, 'system', 'What we create', 'What we create', 'Что создаём'),
(285, 'system', 'directory', 'directory', 'каталог'),
(286, 'system', 'Writing to file failed', 'Writing to file failed', 'Не удалась запись в файл'),
(287, 'system', 'Reading of file failed', 'Reading of file failed', 'Не удалось прочитать файл!'),
(288, 'system', 'Gb', 'Gb', 'Гб'),
(289, 'system', 'Mb', 'Mb', 'Мб'),
(290, 'system', 'Kb', 'Kb', 'Кб'),
(291, 'system', 'byte', 'byte', 'байт'),
(292, 'system', 'Parent directory', 'Parent directory', 'родительский каталог'),
(293, 'system', 'Size', 'Size', 'Размер'),
(294, 'system', 'File-manager', 'File-manager', 'Файл-менеджер'),
(295, 'system', 'Invalid action', 'Invalid action', 'Неверное действие'),
(296, 'system', 'Invalid user id', 'Invalid user id', 'Неверный id пользователя'),
(297, 'system', 'Invalid code', 'Invalid code', 'Неверный код'),
(298, 'system', 'Your account has been created.', 'Your account has been created.', 'Ваш аккаунт активирован.'),
(299, 'system', 'Your e-mail address is confirmed. Wait for the verification and account activation by the administrator.', 'Your e-mail address is confirmed. Wait for the verification and account activation by the administrator.', 'Ваш адрес e-mail подтвержден. Дождитесь проверки и активации учетной записи администратором.'),
(300, 'system', 'Invalid confirmation code registration.', 'Invalid confirmation code registration.', 'Неверный код подтверждения регистрации.'),
(301, 'system', 'Not passed the verification code registration.', 'Not passed the verification code registration.', 'Не передан код подтверждения регистрации.'),
(302, 'system', 'Action after the first authorization', 'Action after the first authorization', 'Действие после первой авторизации'),
(303, 'system', 'Group, which gets the user after login', 'Group, which gets the user after login', 'Группы, куда попадет пользователь после авторизации'),
(304, 'system', 'Facebook data', 'Facebook data', 'Данные facebook'),
(305, 'system', 'User fields', 'User fields', 'Поля пользователя'),
(306, 'system', 'Complies fields', 'Complies fields', 'Соответсвие полей'),
(307, 'system', 'enable authentication with facebook', 'enable authentication with facebook', 'включить авторизацию через facebook'),
(308, 'system', 'Twitter data', 'Twitter data', 'Данные twiiter'),
(309, 'system', 'enable authentication with twitter', 'enable authentication with twitter', 'включить авторизацию через твиттер'),
(310, 'system', 'The minimum length of the password must be an integer.', 'The minimum length of the password must be an integer.', 'Минимальная длина пароля должна быть целым числом.'),
(311, 'system', 'The time during which the user is online, can be an integer greater than 0.', 'The time during which the user is online, can be an integer greater than 0.', 'Время, в течение которого пользователь считается online, должно быть целым числом больше 0.'),
(312, 'system', 'nvalid address format of e-mail.', 'nvalid address format of e-mail.', 'Неверный формат адреса e-mail.'),
(313, 'system', 'You have not selected any of the member.', 'You have not selected any of the member.', 'Вы не выбрали ни одной группы для зарегистрированных пользователей.'),
(314, 'system', 'HTML-letter', 'HTML-letter', 'HTML-письмо'),
(315, 'system', 'Letter body', 'Letter body', 'Тело письма'),
(316, 'system', 'Letter header', 'Letter header', 'Заголовок письма'),
(317, 'system', 'Restore the default form', 'Restore the default form', 'Восстановить форму по умолчанию'),
(318, 'system', 'Component "Private Messages"', 'Component "Private Messages"', 'Компонент "Личные сообщения"'),
(319, 'system', 'Component "Users"', 'Component "Users"', 'Компонент "Пользователи"'),
(320, 'system', 'Allow users to add enemies', 'Allow users to add enemies', 'Разрешить добавлять пользователей во враги'),
(321, 'system', 'Friends and enemies', 'Friends and enemies', 'Друзья и враги'),
(322, 'system', 'Allow users to add as friend', 'Allow users to add as friend', 'Разрешить добавлять пользователей в друзья'),
(323, 'system', 'Notify the user by e-mail about the new message', 'Notify the user by e-mail about the new message', 'Оповещать пользователя по e-mail о новом сообщении'),
(324, 'system', 'Private messages', 'Private messages', 'Личные сообщения'),
(325, 'system', 'Allow to send private messages', 'Allow to send private messages', 'Разрешить отправлять личные сообщения'),
(326, 'system', 'User authentication after the confirm', 'User authentication after the confirm', 'Авторизация пользователя сразу после подтверждения'),
(327, 'system', 'E-mail the administrator to send alerts', 'E-mail the administrator to send alerts', 'E-mail администратора для отсылки оповещений'),
(328, 'system', 'Send a letter to the manager when a user logs', 'Send a letter to the manager when a user logs', 'Отправлять письмо администратору при регистрации пользователя'),
(329, 'system', 'Moderated by the administrator', 'Moderated by the administrator', 'Премодерация администратором'),
(330, 'system', 'Require confirmation by e-mail', 'Require confirmation by e-mail', 'Требовать подтверждение через e-mail'),
(331, 'system', 'Group to which the user will get after registration', 'Group to which the user will get after registration', 'Группы, куда попадёт пользователь после регистрации'),
(332, 'system', 'Enable self-registration', 'Enable self-registration', 'Разрешить самостоятельную регистрацию'),
(333, 'system', 'Registration', 'Registration', 'Регистрация'),
(334, 'system', 'Bind users to sites', 'Bind users to sites', 'Привязывать пользователей к сайтам'),
(335, 'system', 'Deny yourself to recover your password', 'Deny yourself to recover your password', 'Запретить самостоятельно восстанавливать пароль'),
(336, 'system', 'General Settings', 'General Settings', 'Общие настройки'),
(337, 'system', 'Do not show the form of a failed login attempt', 'Do not show the form of a failed login attempt', 'Не показывать форму при неудачной попытке авторизации'),
(338, 'system', 'Restored', 'Restored', 'Восстановлено'),
(339, 'system', 'Nonexistent tab!', 'Nonexistent tab!', 'Несуществующая вкладка!'),
(340, 'system', 'Login through external services', 'Login through external services', 'Авторизация через внешние сервисы'),
(341, 'system', 'Email templates', 'Email templates', 'Шаблоны писем'),
(342, 'system', 'General', 'General', 'Общие'),
(343, 'system', 'Password restore', 'Password restore', 'Восстановление пароля'),
(344, 'system', 'Registration confirm', 'Registration confirm', 'Подтверждение регистрации'),
(345, 'system', 'Now you will be taken to the login page.', 'Now you will be taken to the login page.', 'Сейчас вы будете переброшены на страницу авторизации.'),
(346, 'system', 'Click here if you do not want to wait.', 'Click here if you do not want to wait.', 'Нажмите, если не хотите ждать.'),
(347, 'system', 'Login via twitter disabled', 'Login via twitter disabled', 'Авторизация через twitter запрещена'),
(348, 'system', 'Login via facebook disabled', 'Login via facebook disabled', 'Авторизация через facebook запрещена'),
(349, 'system', 'FX_ADMIN_FIELD_STRING', 'String', 'Строка'),
(350, 'system', 'FX_ADMIN_FIELD_INT', 'Integer', 'Целое число'),
(352, 'system', 'FX_ADMIN_FIELD_SELECT', 'Options list', 'Список'),
(353, 'system', 'FX_ADMIN_FIELD_BOOL', 'Boolean', 'Логическая переменная'),
(354, 'system', 'FX_ADMIN_FIELD_FILE', 'File', 'Файл'),
(355, 'system', 'FX_ADMIN_FIELD_FLOAT', 'Float number', 'Дробное число'),
(356, 'system', 'FX_ADMIN_FIELD_DATETIME', 'Date and time', 'Дата и время'),
(357, 'system', 'FX_ADMIN_FIELD_COLOR', 'Color', 'Цвет'),
(359, 'system', 'FX_ADMIN_FIELD_IMAGE', 'Image', 'Изображение'),
(360, 'system', 'FX_ADMIN_FIELD_MULTISELECT', 'Multiple select', 'Мультисписок'),
(361, 'system', 'FX_ADMIN_FIELD_LINK', 'Link to another object', 'Связь с другим объектом'),
(362, 'system', 'FX_ADMIN_FIELD_MULTILINK', 'Multiple link', 'Множественная связь'),
(363, 'system', 'FX_ADMIN_FIELD_TEXT', 'Text', 'Текст'),
(375, 'system', 'add', 'add', 'добавить'),
(376, 'system', 'edit', 'edit', 'Редактировать'),
(377, 'system', 'on', 'on', 'on'),
(378, 'system', 'off', 'off', 'off'),
(381, 'system', 'Render type', 'Render type', 'Render type'),
(382, 'system', 'Live search', 'Live search', 'Live search'),
(383, 'system', 'Simple select', 'Simple select', 'Simple select'),
(384, 'system', '-Any-', '-Any-', 'Любой'),
(385, 'system', 'Only on pages of type', 'Only on pages of type', 'Только на страницах типа'),
(386, 'system', '-- choose something --', '-- choose something --', '-- выберите вариант --'),
(387, 'component_section', 'Show only header?', 'Show only header?', 'Показывать только заголовок?'),
(388, 'component_section', 'Hide on the index page', 'Hide on the index page', 'Скрыть на главной?'),
(389, 'system', 'Welcome to Floxim.CMS, please sign in', 'Welcome to Floxim.CMS, please sign in', 'Welcome to Floxim.CMS, please sign in'),
(390, 'system', 'Editing ', 'Editing ', 'Редактируем'),
(391, 'system', 'Fields table', 'Fields table', 'Fields table'),
(392, 'system', 'Adding new ', 'Adding new ', 'Adding new '),
(393, 'controller_component', 'New infoblock', 'New infoblock', 'Новый инфоблок'),
(394, 'controller_component', 'Infoblock for the field', 'Infoblock for the field', 'Инфоблок для поля '),
(396, 'system', 'Name of an entity created by the component', 'Name of an entity created by the component', 'Название сущности, создаваемой компонентом'),
(397, 'system', 'Component actions', 'Component actions', 'Component actions'),
(398, 'system', 'Templates', 'Templates', 'Шаблоны'),
(402, 'system', 'Save', 'Save', 'Сохранить'),
(403, 'system', 'Used', 'Used', 'Used'),
(404, 'component_section', 'Nesting level', 'Nesting level', 'Уровень вложенности'),
(405, 'component_section', '2 levels', '2 levels', '2 уровня'),
(406, 'component_section', '3 levels', '3 levels', '3 уровня'),
(407, 'component_section', 'Current level +1', 'Current level +1', 'Текущий +1'),
(408, 'component_section', 'No limit', 'No limit', 'Без ограничения'),
(409, 'system', 'Cancel', 'Cancel', 'Отменить'),
(410, 'system', 'Redo', 'Redo', 'Вернуть'),
(411, 'system', 'More', 'More', 'Еще'),
(412, 'system', 'Patches', NULL, 'Патчи'),
(413, 'system', 'Update check failed', NULL, 'Проверка обновлений завершилась неудачей'),
(414, 'system', 'Installing patch %s...', NULL, 'Устанавливаем патч %s...'),
(415, 'content', 'Current Floxim version:', NULL, 'Текущая версия Floxim:'),
(433, 'system', 'Название компонента (по-русски)', 'Название компонента (по-русски)', 'Название компонента'),
(439, 'system', 'Add new component', 'Add new component', 'Добавить новый компонент'),
(440, 'system', 'Add new Components', 'Add new Components', 'Добавить новые компоненты'),
(441, 'system', 'Add new widget', 'Add new widget', 'Создать новый виджет'),
(442, 'system', 'Add new field', 'Add new field', 'Создать новое поле'),
(443, 'system', 'Keyword (название папки с макетом)', 'Keyword (название папки с макетом)', 'Ключевое слово'),
(444, 'system', 'Layout keyword', 'Layout keyword', 'Ключевое слово лейаута'),
(445, 'system', 'Add new layout', 'Add new layout', 'Создать новый лейаут'),
(446, 'system', 'Finish', 'Finish', 'Закончить'),
(447, 'system', 'Keyword can only contain letters, numbers, symbols, \\"hyphen\\" and \\"underscore\\"', 'Keyword can only contain letters, numbers, symbols, \\"hyphen\\" and \\"underscore\\"', NULL),
(452, 'controller_component', 'Limit', 'Limit', 'Ограничение'),
(453, 'controller_component', 'Conditoins', 'Conditoins', 'Условия'),
(454, 'controller_component', 'Conditions', 'Conditions', 'Условия'),
(455, 'controller_component', 'Infoblock page', 'Infoblock page', 'Страница инфоблока'),
(456, 'system', 'I am REALLY sure', 'I am REALLY sure', 'Я действительно уверен'),
(457, 'component_section', 'Source infoblock', 'Source infoblock', 'Инфоблок-источник'),
(459, 'system', 'Email', 'Email', 'E-mail'),
(460, 'system', 'Edit User', 'Edit User', 'Редактировать пользователя'),
(462, 'system', 'Admin', 'Admin', 'Админ'),
(463, 'system', 'Fill in email', 'Fill in email', 'Заполните e-mail'),
(464, 'system', 'Add new user', 'Add new user', 'Создать нового пользователя'),
(465, 'system', 'Fill in correct email', 'Fill in correct email', 'Укажите корректный e-mail'),
(466, 'system', 'Fill in name', 'Fill in name', 'Укажите название'),
(467, 'system', 'Ununique email', 'Ununique email', 'Неуникальный e-mail'),
(470, 'controller_component', 'Selected', 'Selected', 'Выбраны'),
(477, 'controller_component', 'Count entries', 'Count entries', 'Число записей'),
(484, 'system', 'Block wrapper', 'Block wrapper', 'Оформление блока'),
(485, 'system', 'Template2', 'Template2', 'Шаблон2'),
(486, 'system', 'NOW() by default', 'NOW() by default', 'СЕЙЧАС по умолчанию'),
(487, 'system', 'Languages', 'Languages', 'Языки'),
(488, 'system', 'Add new language', 'Add new language', 'Создать новый язык'),
(492, 'system', 'Language name', 'Language name', 'Название языка (по-английски)'),
(493, 'system', 'Enter english language name', 'Enter english language name', 'Укажите название языка на английском'),
(494, 'system', 'Native language name', 'Native language name', 'Самоназвание языка'),
(495, 'system', 'Enter native language name', 'Enter native language name', 'Укажите самоназвание языка'),
(496, 'system', 'Language code', 'Language code', 'Код языка'),
(497, 'system', 'Enter language code', 'Enter language code', 'Укажите код языка'),
(498, 'system', 'Create a new language', 'Create a new language', 'Создать новый язык'),
(499, 'system', 'Naitive name', 'Naitive name', 'Оригинальное название'),
(500, 'component_section', 'Add subsection to', 'Add subsection to', 'Добавить подраздел в...'),
(501, 'system', 'Language', 'Language', 'Язык'),
(503, 'system', 'Inherited from', 'Inherited from', 'Унаследовано от'),
(504, 'system', 'Editable', 'Editable', 'Редактируемое'),
(505, 'system', 'No', 'No', 'Нет'),
(506, 'system', 'Yes', 'Yes', 'Да'),
(507, 'system', 'Inherited', 'Inherited', 'Унаследовано'),
(753, 'system', 'Logs', 'Logs', 'Логи'),
(754, 'system', 'Request', 'Request', 'Запрос'),
(755, 'system', 'Date', 'Date', 'Дата'),
(756, 'system', 'Time', 'Time', 'Время'),
(757, 'system', 'Entries', 'Entries', 'Записи'),
(758, 'system', 'Delte', 'Delte', 'Удалить'),
(759, 'system', 'Delete all', 'Delete all', 'Удалить все'),
(761, 'component_section', 'Breadcrumbs', 'Breadcrumbs', 'Хлебные крошки'),
(762, 'controller_component', 'Add items to', 'Add items to', 'Добавлять записи в'),
(763, 'controller_component', 'Bind items to', 'Bind items to', 'Привязывать записи к'),
(764, 'widget_blockset', 'Block set', 'Block set', 'Набор блоков'),
(765, 'controller_component', 'Paginate?', 'Paginate?', 'Постраничный вывод?'),
(901, 'system', 'Fake infoblock data', 'Fake infoblock data', 'Здесь будут данные инфоблока'),
(994, 'system', 'Layout settings', 'Layout settings', 'Настройки лейаута'),
(995, 'system', 'Edit current page', 'Edit current page', 'Редактировать текущую страницу'),
(996, 'system', 'Use wider rule', 'Use wider rule', 'Использовать более широкое правило'),
(997, 'system', 'Drop current rule and use the wider one', 'Drop current rule and use the wider one', 'Удалить текущее правило и использовать более общее'),
(998, 'system', 'For admin only', 'For admin only', 'Только для администратора'),
(999, 'system', 'Count items', 'Count items', 'Количество объектов'),
(1000, 'system', 'Count', 'Count', 'Сколько'),
(1019, 'widget_grid', 'Two columns', 'Two columns', 'Две колонки'),
(1021, 'system', 'Language strings', 'Language strings', 'Языковые строки'),
(1025, 'system', 'Key', 'Key', 'Ключ'),
(1026, 'system', 'Value', 'Value', 'Значение'),
(1028, 'system', 'Dictionary', 'Dictionary', 'Словарь'),
(1029, 'system', 'String', 'String', 'Строка'),
(1050, 'component_section', 'Menu', 'Menu', 'Меню'),
(1051, 'system', 'settings', 'settings', 'Настройки'),
(1052, 'system', 'delete', 'delete', 'Удалить'),
(1053, 'system', 'Import', 'Import', 'Импортировать'),
(1054, 'system', 'Edit', 'Edit', 'Редактировать'),
(1055, 'system', 'Edit strings', 'Edit strings', 'Редактировать строки'),
(1056, 'system', 'Current Floxim version:', 'Current Floxim version:', 'Текущая версия Floxim:'),
(1057, 'system', 'Name', 'Name', 'Название'),
(1058, 'system', 'Edit user', 'Edit user', 'Редактировать пользователя'),
(1059, 'system', 'All pages', 'All pages', 'Все страницы'),
(1060, 'system', 'All pages of type %s', 'All pages of type %s', 'Все страницы типа %s'),
(1061, 'system', '%s children only', '%s children only', 'Только потомки %s'),
(1062, 'system', '%s and children', '%s and children', '%s и потомки'),
(1063, 'system', '%s only', '%s only', 'Только %s'),
(1064, 'system', 'Scope', 'Scope', 'Где показывать'),
(1065, 'system', '%s children of type %s', '%s children of type %s', 'Потомки %s типа %s'),
(1066, 'system', 'Add', 'Add', 'Добавить'),
(1067, 'controller_component', 'by filter', 'by filter', 'по фильтру'),
(1068, 'system', 'Console', 'Console', 'Консоль'),
(1069, 'system', 'Apply', 'Apply', 'Применить'),
(1070, 'system', 'Execute', 'Execute', 'Выполнить'),
(1071, 'component_user', 'New %s password', 'New %s password', 'Новый пароль на %s'),
(1072, 'component_user', 'Hello, %s! Your new password: %s', 'Hello, %s! Your new password: %s', 'Здравствуйте, %s! Ваш новый пароль: %s'),
(1073, 'system', 'Add user', 'Add user', 'Добавить пользователя'),
(1074, 'system', 'Version', 'Version', 'Версия'),
(1075, 'system', 'Previous', 'Previous', 'Предыдущий'),
(1076, 'system', 'Status', 'Status', 'Статус'),
(1077, 'system', 'Install', 'Install', 'Установить'),
(1078, 'system', 'User name', 'User name', 'Имя пользователя'),
(1079, 'system', 'Items', 'Items', 'Объекты'),
(1080, 'system', 'Unable to save essence "lang_string"', 'Unable to save essence "lang_string"', 'Не удается сохранить языковую строку'),
(1081, 'system', 'HTML code snippet', 'HTML code snippet', 'Фрагмент HTML-кода'),
(1082, 'system', 'Is admin?', 'Is admin?', 'Администратор?'),
(1083, 'system', 'Is multi-language field?', 'Is multi-language field?', 'Многоязычное поле?'),
(1084, 'system', 'Nane', 'Nane', NULL),
(1085, 'system', 'Field name', 'Field name', 'Название поля'),
(1086, 'controller_component', 'Auto', 'Auto', 'Автоматически'),
(1087, 'controller_component', 'Group by parent', 'Group by parent', 'Группировать по родителю'),
(1088, 'system', ' by tag', ' by tag', 'по тегу'),
(1089, 'system', 'Standard', 'Standard', NULL),
(1090, 'system', 'Local', 'Local', NULL),
(1091, 'system', 'Page infoblocks', 'Page infoblocks', NULL),
(1092, 'system', 'Visibility', 'Visibility', NULL),
(1093, 'system', 'Area', 'Area', NULL),
(1094, 'system', '%d items', '%d items', NULL),
(1095, 'component_section', 'Add subsection', 'Add subsection', NULL),
(1096, 'system', 'Wrapper', 'Wrapper', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_layout`
--

CREATE TABLE IF NOT EXISTS `fx_layout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=64 AUTO_INCREMENT=13 ;

--
-- Дамп данных таблицы `fx_layout`
--

INSERT INTO `fx_layout` (`id`, `keyword`, `name`) VALUES
(12, 'floxim.phototeam', 'Photo Team');

-- --------------------------------------------------------

--
-- Структура таблицы `fx_module`
--

CREATE TABLE IF NOT EXISTS `fx_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `installed` tinyint(4) NOT NULL DEFAULT '0',
  `inside_admin` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `checked` tinyint(4) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `Checked` (`checked`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=68 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `fx_module`
--

INSERT INTO `fx_module` (`id`, `name`, `keyword`, `description`, `installed`, `inside_admin`, `checked`) VALUES
(1, 'FX_MODULE_AUTH', 'auth', 'FX_MODULE_AUTH_DESCRIPTION', 1, 1, 1),
(3, 'FX_MODULE_FORUM', 'forum', 'FX_MODULE_FORUM_DESCRIPTION', 1, 1, 1),
(4, 'FX_MODULE_FILEMANAGER', 'filemanager', 'FX_MODULE_FILEMANAGER_DESCRIPTION', 1, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_option`
--

CREATE TABLE IF NOT EXISTS `fx_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `autoload` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `autoload` (`autoload`),
  KEY `keyword` (`keyword`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `fx_option`
--

INSERT INTO `fx_option` (`id`, `keyword`, `name`, `value`, `autoload`) VALUES
(1, 'fx.version', 'Current floxim version', '0.1.1', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_patch`
--

CREATE TABLE IF NOT EXISTS `fx_patch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `to` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `description` char(255) NOT NULL,
  `from` varchar(255) NOT NULL,
  `status` varchar(20) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

--
-- Дамп данных таблицы `fx_patch`
--

INSERT INTO `fx_patch` (`id`, `to`, `created`, `description`, `from`, `status`, `url`) VALUES
(20, '0.1.1', '2013-08-19 15:24:17', 'Test patch', '0.1.0', 'installed', 'http://floxim.org/getfloxim/patches/0.1.0-0.1.1/patch_0.1.1.zip');

-- --------------------------------------------------------

--
-- Структура таблицы `fx_patch_migration`
--

CREATE TABLE IF NOT EXISTS `fx_patch_migration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `fx_patch_migration`
--

INSERT INTO `fx_patch_migration` (`id`, `name`, `created`) VALUES
(1, 'm20140808_062932', '2014-08-13 04:36:44'),
(2, 'm20140812_050811', '2014-08-13 04:36:44');

-- --------------------------------------------------------

--
-- Структура таблицы `fx_session`
--

CREATE TABLE IF NOT EXISTS `fx_session` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `session_key` char(32) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `site_id` int(10) unsigned NOT NULL,
  `start_time` int(11) NOT NULL DEFAULT '0',
  `last_activity_time` int(11) NOT NULL DEFAULT '0',
  `ip` bigint(11) NOT NULL DEFAULT '0',
  `remember` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `User_ID` (`user_id`),
  KEY `session_key` (`session_key`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=126 AUTO_INCREMENT=13 ;

--
-- Дамп данных таблицы `fx_session`
--

INSERT INTO `fx_session` (`id`, `session_key`, `user_id`, `site_id`, `start_time`, `last_activity_time`, `ip`, `remember`) VALUES
(12, '7b0357b9976a03f4f95f2f471d3cb922', 2367, 0, 1413908159, 1413908637, 2130706433, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_settings`
--

CREATE TABLE IF NOT EXISTS `fx_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `module` varchar(255) NOT NULL DEFAULT 'system',
  `site_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `site_ID` (`site_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=70 AUTO_INCREMENT=40 ;

--
-- Дамп данных таблицы `fx_settings`
--

INSERT INTO `fx_settings` (`id`, `key`, `value`, `module`, `site_id`) VALUES
(1, 'version', '0.9.9', 'system', 0),
(2, 'last_check', '1346408043', 'system', 0),
(3, 'last_response', 'a:3:{s:10:"next_patch";s:5:"1.0.0";s:19:"next_patch_fulllink";s:39:"http://floxim.org/update/update_15.html";s:15:"next_patch_link";s:61:"http://floxim.org/?essence=module_patch&action=download&id=15";}', 'system', 0),
(4, 'next_patch', '1.0.0', 'system', 0),
(5, 'user_email_field', 'email', 'system', 0),
(6, 'spam_from_name', 'Admin', 'system', 0),
(7, 'spam_from_email', 'dubr.cola@gmail.com', 'system', 0),
(8, 'secret_key', '387768baa556f6f94ee29cb0e3e2a662', 'system', 0),
(9, 'authtype', '3', 'auth', 0),
(10, 'pm_allow', '1', 'auth', 0),
(11, 'pm_notify', '1', 'auth', 0),
(12, 'friend_allow', '1', 'auth', 0),
(13, 'banned_allow', '', 'auth', 0),
(14, 'incorrect_login_form_disable', '0', 'auth', 0),
(15, 'allow_registration', '1', 'auth', 0),
(16, 'external_user_groups', 'a:1:{i:0;s:1:"2";}', 'auth', 0),
(17, 'min_pasword_length', '0', 'auth', 0),
(18, 'deny_recoverpasswd', '0', 'auth', 0),
(19, 'online_timeleft', '300', 'auth', 0),
(20, 'bind_to_site', '0', 'auth', 0),
(21, 'user_component_id', '1', 'auth', 0),
(22, 'registration_confirm', '1', 'auth', 0),
(23, 'registration_premoderation', '0', 'auth', 0),
(24, 'registration_notify_admin', '0', 'auth', 0),
(25, 'autoauthorize', '1', 'auth', 0),
(26, 'admin_notify_email', '', 'auth', 0),
(27, 'twitter_enabled', '0', 'auth', 0),
(28, 'twitter_app_id', '', 'auth', 0),
(29, 'twitter_app_key', '', 'auth', 0),
(30, 'twitter_map', 'a:2:{i:1;a:2:{s:14:"external_field";s:11:"screen_name";s:10:"user_field";s:4:"name";}i:2;a:2:{s:14:"external_field";s:17:"profile_image_url";s:10:"user_field";s:6:"avatar";}}', 'auth', 0),
(31, 'twitter_group', 'a:1:{i:0;s:1:"3";}', 'auth', 0),
(32, 'twitter_addaction', '/* Доступные переменные: $fx_core, $user, $response */\r\nif ( $fx_core->AUTHORIZE_BY == ''login'' ) {\r\n  if ( !$user[''login''] ) {\r\n    $maybe_login = $response[''screen_name''];\r\n    if ( $fx_core->user->get(''login'', $maybe_login )) {\r\n      $maybe_login .= $response[''id''];\r\n    }\r\n    $user->set(''login'', $maybe_login)->save();\r\n  }\r\n}\r\n\r\n', 'auth', 0),
(33, 'facebook_enabled', '0', 'auth', 0),
(34, 'facebook_app_id', '', 'auth', 0),
(35, 'facebook_app_key', '', 'auth', 0),
(36, 'facebook_addaction', '/* Доступные переменные: $fx_core, $user, $response */\r\nif ( $fx_core->AUTHORIZE_BY == ''login'' ) {\r\n  if ( !$user[''login''] ) {\r\n    $maybe_login = $response[''name''];\r\n    if ( $fx_core->user->get(''login'', $maybe_login )) {\r\n      $maybe_login .= $response[''id''];\r\n    }\r\n    $user->set(''login'', $maybe_login)->save();\r\n  }\r\n}\r\n', 'auth', 0),
(37, 'facebook_map', 'a:3:{i:1;a:2:{s:14:"external_field";s:4:"name";s:10:"user_field";s:4:"name";}i:2;a:2:{s:14:"external_field";s:5:"email";s:10:"user_field";s:5:"email";}i:21;a:2:{s:14:"external_field";s:6:"avatar";s:10:"user_field";s:6:"avatar";}}', 'auth', 0),
(38, 'facebook_group', 'a:1:{i:0;s:1:"3";}', 'auth', 0),
(39, 'pm_component_id', '11', 'auth', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_site`
--

CREATE TABLE IF NOT EXISTS `fx_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `domain` varchar(128) NOT NULL,
  `layout_id` int(11) NOT NULL DEFAULT '0',
  `color` int(11) NOT NULL DEFAULT '0' COMMENT 'Расцветка',
  `mirrors` text NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `checked` smallint(6) NOT NULL DEFAULT '0',
  `index_page_id` int(11) NOT NULL DEFAULT '0',
  `error_page_id` int(11) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `robots` text,
  `disallow_indexing` int(11) DEFAULT '0',
  `type` enum('useful','mobile') NOT NULL DEFAULT 'useful' COMMENT 'Тип сайта: обычный или мобильный',
  `language` varchar(255) NOT NULL DEFAULT 'en',
  `offline_text` varchar(255) DEFAULT NULL,
  `store_id` text,
  PRIMARY KEY (`id`),
  KEY `Checked` (`checked`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=292 AUTO_INCREMENT=19 ;

--
-- Дамп данных таблицы `fx_site`
--

INSERT INTO `fx_site` (`id`, `parent_id`, `name`, `domain`, `layout_id`, `color`, `mirrors`, `priority`, `checked`, `index_page_id`, `error_page_id`, `created`, `last_updated`, `robots`, `disallow_indexing`, `type`, `language`, `offline_text`, `store_id`) VALUES
(18, 0, 'The Photo Team', 'psr.loc', 12, 0, '', 4, 1, 2635, 2636, '2014-01-28 11:39:50', '2014-10-07 14:26:47', '', 0, 'useful', 'en', '', '');

-- --------------------------------------------------------

--
-- Структура таблицы `fx_url_alias`
--

CREATE TABLE IF NOT EXISTS `fx_url_alias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL,
  `site_id` int(11) NOT NULL DEFAULT '0',
  `page_id` int(11) NOT NULL DEFAULT '0',
  `is_current` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `is_original` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `url` (`url`),
  KEY `page_id` (`page_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `fx_url_alias`
--

INSERT INTO `fx_url_alias` (`id`, `url`, `site_id`, `page_id`, `is_current`, `is_original`) VALUES
(1, '/', 18, 2635, 1, 1),
(2, '/404', 18, 2636, 1, 1),
(3, '/About-Us-2', 18, 2640, 1, 1),
(4, '/Athletics', 18, 2739, 1, 1),
(5, '/Birthday-parties', 18, 2745, 1, 1),
(6, '/Bull-Easter', 18, 2757, 1, 1),
(7, '/Carnival-of-miners', 18, 2688, 1, 1),
(8, '/Catalog', 18, 2638, 1, 1),
(9, '/Cities', 18, 2742, 1, 1),
(10, '/Cockfights', 18, 2690, 1, 1),
(11, '/Contacts', 18, 2641, 1, 1),
(12, '/contest', 18, 2731, 1, 1),
(13, '/Corporate-events', 18, 2746, 1, 1),
(14, '/Delivery-person', 18, 2737, 1, 1),
(15, '/Events', 18, 2744, 0, 1),
(16, '/Football-photo-report', 18, 2660, 1, 1),
(17, '/Free-ride-proof-pics', 18, 2680, 1, 1),
(18, '/Ken-Cold', 18, 2671, 1, 1),
(19, '/Kupala-Night', 18, 2751, 1, 1),
(20, '/Landscapes', 18, 2658, 1, 1),
(21, '/Leila-Stoparsson', 18, 2673, 1, 1),
(22, '/Maker-up', 18, 2677, 1, 1),
(23, '/Moscow-Athletics-Championship', 18, 2681, 1, 1),
(24, '/Moscow-Streetshot-Contest', 18, 2679, 1, 1),
(25, '/Nature', 18, 2743, 1, 1),
(26, '/News', 18, 2657, 1, 1),
(27, '/Nika-Lightman', 18, 2675, 1, 1),
(28, '/Passport-photos', 18, 2741, 1, 1),
(29, '/people-photo', 18, 2654, 1, 1),
(30, '/Portrait', 18, 2740, 1, 1),
(31, '/Projects', 18, 2639, 1, 1),
(32, '/Redecoration-in-our-new-studio', 18, 2678, 1, 1),
(33, '/Skiing', 18, 2661, 1, 1),
(34, '/Sonya-Zoomer', 18, 2735, 1, 1),
(35, '/sport', 18, 2733, 1, 1),
(36, '/Sport-series', 18, 2652, 1, 1),
(37, '/studio', 18, 2728, 1, 1),
(38, '/Swimming', 18, 2662, 1, 1),
(39, '/Team', 18, 2655, 1, 1),
(40, '/Vacancies', 18, 2656, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `fx_widget`
--

CREATE TABLE IF NOT EXISTS `fx_widget` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) NOT NULL,
  `name_ru` varchar(255) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `description_en` text,
  `description_ru` text NOT NULL,
  `checked` tinyint(1) NOT NULL DEFAULT '1',
  `vendor` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=111 AUTO_INCREMENT=11 ;

--
-- Дамп данных таблицы `fx_widget`
--

INSERT INTO `fx_widget` (`id`, `name_en`, `name_ru`, `keyword`, `description_en`, `description_ru`, `checked`, `vendor`) VALUES
(4, 'Block set', 'Набор блоков', 'blockset', NULL, '', 1, ''),
(8, 'Grid', 'Сетка', 'grid', NULL, '', 1, ''),
(9, 'Сustom code', '', 'custom_code', NULL, '', 1, ''),
(10, 'Map', '', 'map', NULL, '', 1, 'std');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
