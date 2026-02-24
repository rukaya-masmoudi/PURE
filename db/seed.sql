PRAGMA foreign_keys = ON;

-- Providers
DELETE FROM Provider;

INSERT INTO Provider (provider_id, name, notes) VALUES
(1, 'Microsoft', NULL),
(2, 'Microsoft Learn', NULL),
(3, 'AWS', NULL);

-- Categories
DELETE FROM Category;

INSERT INTO Category (category_id, name, notes) VALUES
(1, 'Data', NULL),
(2, 'Machine Learning', NULL),
(3, 'Cloud Development', NULL),
(4, 'AI Engineering', NULL),
(5, 'Power Platform', NULL),
(6, 'Natural Language Processing', NULL),
(7, 'Data Analytics', NULL);

-- Learning levels
DELETE FROM LearningLevel;

INSERT INTO LearningLevel (learning_level_id, name, notes) VALUES
(1, 'beginner', NULL),
(2, 'intermediate', NULL);

-- Certification tiers
DELETE FROM CertificationTier;

INSERT INTO CertificationTier (cert_tier_id, name, notes) VALUES
(1, 'fundamentals', NULL),
(2, 'associate', NULL);

-- Visibility
DELETE FROM Visibility;

INSERT INTO Visibility (visibility_id, name, notes) VALUES
(1, 'PUBLIC', NULL),
(2, 'PRIVATE', NULL);

-- Study status
DELETE FROM StudyStatus;

INSERT INTO StudyStatus (status_id, name, notes) VALUES
(1, 'DONE', NULL),
(2, 'PLANNED', NULL);

-- Practice result types
DELETE FROM PracticeResultType;

INSERT INTO PracticeResultType (result_type_id, name, notes) VALUES
(1, 'applied-skill', NULL);

-- Attempt status
DELETE FROM AttemptStatus;

INSERT INTO AttemptStatus (attempt_status_id, name, notes) VALUES
(1, 'pass', NULL),
(2, 'fail', NULL),
(3, 'scheduled', NULL);

-- Tags
DELETE FROM Tag;

INSERT INTO Tag (tag_id, name, description) VALUES
(1,  'Azure', NULL),
(2,  'SQL', NULL),
(3,  'NoSQL', NULL),
(4,  'Analytics', NULL),
(5,  'Python', NULL),
(6,  'Regression', NULL),
(7,  'Classification', NULL),
(8,  'Clustering', NULL),
(9,  'Deep Learning', NULL),
(10, 'Evaluation', NULL),

(11, 'Azure Storage', NULL),
(12, 'Azure Cosmos DB', NULL),
(13, 'Power BI', NULL),
(14, 'Streaming', NULL),

(15, 'NLP', NULL),
(16, 'Azure AI Language', NULL),
(17, 'Question Answering', NULL),
(18, 'CLU', NULL),
(19, 'NER', NULL),
(20, 'Translator', NULL),
(21, 'Speech', NULL),
(22, 'Azure AI Foundry', NULL),
(23, 'Azure AI Search', NULL);

-- Topics
DELETE FROM Topic;

-- -------------------------
-- DP-900 modules (Beginner)
-- Learning path: core data concepts
-- -------------------------
INSERT INTO Topic (topic_id, name, provider_id, category_id, learning_level_id, visibility_id, created_at) VALUES
(1, 'Explore core data concepts',      2, 1, 1, 1, '2026-02-09 00:00:00'),
(2, 'Explore data roles and services', 2, 1, 1, 1, '2026-02-09 00:00:00');

-- -------------------------
-- DP-900 modules (Beginner)
-- Learning path: relational data
-- -------------------------
INSERT INTO Topic (topic_id, name, provider_id, category_id, learning_level_id, visibility_id, created_at) VALUES
(3, 'Explore fundamental relational data concepts',  2, 1, 1, 1, '2026-02-10 00:00:00'),
(4, 'Explore relational database services in Azure', 2, 1, 1, 1, '2026-02-10 00:00:00');

-- -------------------------
-- DP-900 modules (Beginner)
-- Learning path: non-relational data
-- -------------------------
INSERT INTO Topic (topic_id, name, provider_id, category_id, learning_level_id, visibility_id, created_at) VALUES
(5, 'Explore Azure Storage for non-relational data', 2, 1, 1, 1, '2026-02-11 00:00:00'),
(6, 'Explore fundamentals of Azure Cosmos DB',       2, 1, 1, 1, '2026-02-11 00:00:00');

-- -------------------------
-- DP-900 modules (Beginner)
-- Learning path: analytics in Azure
-- -------------------------
INSERT INTO Topic (topic_id, name, provider_id, category_id, learning_level_id, visibility_id, created_at) VALUES
(7, 'Explore fundamentals of large-scale analytics', 2, 7, 1, 1, '2026-02-12 00:00:00'),
(8, 'Explore fundamentals of real-time analytics',   2, 7, 1, 1, '2026-02-12 00:00:00'),
(9, 'Explore fundamentals of data visualization',    2, 7, 1, 1, '2026-02-12 00:00:00');

-- -------------------------
-- Create machine learning models (Intermediate)
-- -------------------------
INSERT INTO Topic (topic_id, name, provider_id, category_id, learning_level_id, visibility_id, created_at) VALUES
(10, 'Explore and analyze data with Python',      2, 2, 2, 1, '2026-02-13 00:00:00'),
(11, 'Train and evaluate regression models',      2, 2, 2, 1, '2026-02-15 00:00:00'),
(12, 'Train and evaluate classification models',  2, 2, 2, 1, '2026-02-16 00:00:00'),
(13, 'Train and evaluate clustering models',      2, 2, 2, 1, '2026-02-16 00:00:00'),
(14, 'Train and evaluate deep learning models',   2, 2, 2, 1, '2026-02-16 00:00:00');

-- -------------------------
-- Develop natural language solutions in Azure (Intermediate)
-- -------------------------
INSERT INTO Topic (topic_id, name, provider_id, category_id, learning_level_id, visibility_id, created_at) VALUES
(15, 'Analyze text with Azure Language',                        2, 6, 2, 1, '2026-02-19 00:00:00'),
(16, 'Create question answering solutions with Azure Language', 2, 6, 2, 1, '2026-02-19 00:00:00'),
(17, 'Build a conversational language understanding model',     2, 6, 2, 1, '2026-02-19 00:00:00'),
(18, 'Create custom text classification solutions',             2, 6, 2, 1, '2026-02-19 00:00:00'),
(19, 'Custom named entity recognition',                         2, 6, 2, 1, '2026-02-19 00:00:00'),
(20, 'Translate text with Azure Translator service',            2, 6, 2, 1, '2026-02-19 00:00:00'),
(21, 'Create speech-enabled apps with Microsoft Foundry',       2, 6, 2, 1, '2026-02-19 00:00:00'),
(22, 'Translate speech with the Azure Speech service',          2, 6, 2, 1, '2026-02-19 00:00:00'),
(23, 'Develop an audio-enabled generative AI application',      2, 6, 2, 1, '2026-02-19 00:00:00'),
(24, 'Develop an Azure AI Voice Live agent',                    2, 6, 2, 1, '2026-02-19 00:00:00');

-- -------------------------
-- Implement knowledge mining with Azure AI Search (Intermediate)
-- -------------------------
INSERT INTO Topic (topic_id, name, provider_id, category_id, learning_level_id, visibility_id, created_at) VALUES
(25, 'Create an Azure AI Search solution',                                2, 4, 2, 1, '2026-02-24 00:00:00'),
(26, 'Create a custom skill for Azure AI Search',                         2, 4, 2, 1, '2026-02-24 00:00:00'),
(27, 'Create a knowledge store with Azure AI Search',                     2, 4, 2, 1, '2026-02-24 00:00:00'),
(28, 'Implement advanced search features in Azure AI Search',             2, 4, 2, 1, '2026-02-24 00:00:00'),
(29, 'Search data outside Azure in Azure AI Search using Azure Data Factory', 2, 4, 2, 1, '2026-02-24 00:00:00'),
(30, 'Maintain an Azure AI Search solution',                              2, 4, 2, 1, '2026-02-24 00:00:00'),
(31, 'Perform search reranking with semantic ranking in Azure AI Search', 2, 4, 2, 1, '2026-02-24 00:00:00'),
(32, 'Perform vector search and retrieval in Azure AI Search',            2, 4, 2, 1, '2026-02-24 00:00:00');

-- Topic tags
DELETE FROM TopicTag;

-- -------------------------
-- DP-900 tags (Data / Analytics)
-- -------------------------
INSERT INTO TopicTag (topic_id, tag_id) VALUES
(1, 1),
(2, 1),
(3, 1), (3, 2),
(4, 1), (4, 2),
(5, 1), (5, 11),
(6, 1), (6, 3), (6, 12),
(7, 1), (7, 4),
(8, 1), (8, 4), (8, 14),
(9, 1), (9, 4), (9, 13);

-- -------------------------
-- Create ML Models tags
-- -------------------------
INSERT INTO TopicTag (topic_id, tag_id) VALUES
(10, 5),
(11, 5), (11, 6), (11, 10),
(12, 5), (12, 7), (12, 10),
(13, 5), (13, 8), (13, 10),
(14, 5), (14, 9), (14, 10);

-- -------------------------
-- NLP tags
-- -------------------------
INSERT INTO TopicTag (topic_id, tag_id) VALUES
(15, 1), (15, 15), (15, 16),
(16, 1), (16, 15), (16, 16), (16, 17),
(17, 1), (17, 15), (17, 16), (17, 18),
(18, 1), (18, 15), (18, 16), (18, 7),
(19, 1), (19, 15), (19, 16), (19, 19),
(20, 1), (20, 15), (20, 20),
(21, 1), (21, 21), (21, 22),
(22, 1), (22, 21),
(23, 1), (23, 21), (23, 22),
(24, 1), (24, 21), (24, 22);

-- -------------------------
-- Knowledge Mining tags
-- -------------------------
INSERT INTO TopicTag (topic_id, tag_id) VALUES
(25, 1), (25, 4), (25, 23),
(26, 1), (26, 4), (26, 23),
(27, 1), (27, 4), (27, 23),
(28, 1), (28, 4), (28, 23),
(29, 1), (29, 4), (29, 23),
(30, 1), (30, 4), (30, 23),
(31, 1), (31, 4), (31, 23),
(32, 1), (32, 4), (32, 23);

-- Study sessions

-- -------------------------
-- DONE
-- -------------------------

DELETE FROM StudySession;

INSERT INTO StudySession (session_id, topic_id, started_at, ended_at, duration_minutes, difficulty, energy, notes, visibility_id, status_id) VALUES
-- =========================
-- DONE
-- =========================

-- 2026-02-09
(1,  1, '2026-02-09 19:12:00', '2026-02-09 19:49:00', 37, 2, 3, NULL, 1, 1),
(2,  2, '2026-02-09 20:05:00', '2026-02-09 20:27:00', 22, 2, 3, NULL, 1, 1),

-- 2026-02-10
(3,  3, '2026-02-10 19:18:00', '2026-02-10 20:02:00', 44, 3, 3, NULL, 1, 1),
(4,  4, '2026-02-10 20:17:00', '2026-02-10 21:00:00', 43, 3, 3, NULL, 1, 1),

-- 2026-02-11
(5,  5, '2026-02-11 19:41:00', '2026-02-11 20:29:00', 48, 3, 3, NULL, 1, 1),
(6,  6, '2026-02-11 20:44:00', '2026-02-11 21:22:00', 38, 3, 3, NULL, 1, 1),

-- 2026-02-12
(7,  7, '2026-02-12 19:09:00', '2026-02-12 20:00:00', 51, 3, 2, NULL, 1, 1),
(8,  8, '2026-02-12 20:14:00', '2026-02-12 20:52:00', 38, 3, 2, NULL, 1, 1),
(9,  9, '2026-02-12 21:06:00', '2026-02-12 21:44:00', 38, 2, 2, NULL, 1, 1),

-- 2026-02-13
(10, 10, '2026-02-13 17:08:00', '2026-02-13 18:08:00', 60, 3, 3, NULL, 1, 1),

-- 2026-02-15
(11, 11, '2026-02-15 12:10:00', '2026-02-15 13:19:00', 69, 4, 3, NULL, 1, 1),

-- 2026-02-16
(12, 12, '2026-02-16 19:26:00', '2026-02-16 20:30:00', 64, 4, 3, NULL, 1, 1),
(13, 13, '2026-02-16 20:46:00', '2026-02-16 21:32:00', 46, 3, 3, NULL, 1, 1),
(14, 14, '2026-02-16 21:45:00', '2026-02-16 22:32:00', 47, 5, 2, NULL, 1, 1),

-- 2026-02-19
(15, 15, '2026-02-19 19:33:00', '2026-02-19 20:27:00', 54, 4, 3, NULL, 1, 1),
(16, 16, '2026-02-19 20:44:00', '2026-02-19 21:30:00', 46, 4, 3, NULL, 1, 1),

-- 2026-02-20
(17, 17, '2026-02-20 17:05:00', '2026-02-20 18:10:00', 65, 4, 3, NULL, 1, 1),
(18, 18, '2026-02-20 18:18:00', '2026-02-20 19:03:00', 45, 4, 3, NULL, 1, 1),

-- 2026-02-21
(19, 19, '2026-02-21 13:06:00', '2026-02-21 13:56:00', 50, 4, 3, NULL, 1, 1),
(20, 20, '2026-02-21 16:04:00', '2026-02-21 16:44:00', 40, 3, 3, NULL, 1, 1),

-- 2026-02-22
(21, 21, '2026-02-22 12:12:00', '2026-02-22 13:04:00', 52, 4, 3, NULL, 1, 1),
(22, 22, '2026-02-22 13:16:00', '2026-02-22 13:58:00', 42, 4, 3, NULL, 1, 1),

-- 2026-02-23
(23, 23, '2026-02-23 19:11:00', '2026-02-23 20:06:00', 55, 5, 3, NULL, 1, 1),
(24, 24, '2026-02-23 20:20:00', '2026-02-23 21:11:00', 51, 5, 3, NULL, 1, 1),

-- 2026-02-24
(25, 25, '2026-02-24 19:00:00', '2026-02-24 19:50:00', 50, 4, 3, NULL, 1, 1),
(26, 26, '2026-02-24 19:55:00', '2026-02-24 20:45:00', 50, 4, 3, NULL, 1, 1),
(27, 27, '2026-02-24 20:50:00', '2026-02-24 21:40:00', 50, 4, 3, NULL, 1, 1),

-- =========================
-- PLANNED
-- =========================

-- 2026-02-25
(28, 28, '2026-02-25 19:00:00', '2026-02-25 19:50:00', 50, 4, 3, NULL, 1, 2),
(29, 29, '2026-02-25 20:00:00', '2026-02-25 20:40:00', 40, 4, 3, NULL, 1, 2),
(30, 30, '2026-02-25 20:50:00', '2026-02-25 21:40:00', 50, 4, 3, NULL, 1, 2),

-- 2026-02-26
(31, 31, '2026-02-26 19:00:00', '2026-02-26 19:50:00', 50, 4, 3, NULL, 1, 2),
(32, 32, '2026-02-26 20:00:00', '2026-02-26 20:50:00', 50, 4, 3, NULL, 1, 2);

-- Practice results
DELETE FROM PracticeResult;

INSERT INTO PracticeResult (result_id, session_id, result_type_id, attempt_number, score, attempt_status_id, feedback, evidence_url, visibility_id, created_at) VALUES
(1, 24, 1, 1, 88, 1, 'Microsoft Applied Skills: Build a natural language processing solution with Azure AI Language', 'https://learn.microsoft.com/en-us/users/rukaya/credentials/3bae28df7468e920', 1, '2026-02-23 21:30:00');

-- Certifications
DELETE FROM Certification;

INSERT INTO Certification (certification_id, code, name, provider_id, category_id, cert_tier_id, official_url) VALUES
(1, 'PL-400', 'Microsoft Certified: Power Platform Developer Associate', 1, 5, 2, 'https://learn.microsoft.com/api/credentials/share/en-us/Rukaya/C2CE3CE593A5D7E3?sharingId=CC0BDDAD2772AF76'),
(2, 'AZ-204', 'Microsoft Certified: Azure Developer Associate',          1, 3, 2, 'https://learn.microsoft.com/api/credentials/share/es-es/Rukaya/2E58B6A8209C0581?sharingId=CC0BDDAD2772AF76'),
(3, 'DVA-C02', 'AWS Certified Developer – Associate',                    3, 3, 2, 'https://www.credly.com/badges/9b66d1ee-f6c6-4424-9526-010a2375210f/public_url'),
(4, 'AI-102',  'Microsoft Certified: Azure AI Engineer Associate',       1, 4, 2, 'https://learn.microsoft.com/api/credentials/share/en-us/Rukaya/921C08034138DABA?sharingId=CC0BDDAD2772AF76');

-- =========================
-- LIFE LAYER
-- =========================

-- Community
DELETE FROM Community;

INSERT INTO Community (community_id, name, description, website_url, visibility_id) VALUES
(1, 'Codemotion España', 'Organiza meetups y encuentros para la comunidad tech en España.', 'https://community.codemotion.com/codemotion-espana', 1),
(2, 'EmpleaTech', 'Foro de empleo tecnológico en Madrid con stands y agenda de charlas.', 'https://empleatech.es/', 1),
(3, 'AzureBrains', 'Comunidad técnica Azure y AI en Madrid.', 'https://azurebrains.com/', 1),
(4, 'Arcasiles Group', 'Diseñan y producen experiencias que conectan tecnología, cultura y comunidad con creatividad y actitud.', 'https://arcasiles.com/', 1),
(5, 'Meetup de InnoIT Consulting en Madrid', 'Grupo de meetups técnicos de InnoIT Consulting en Madrid centrados en IA, cloud y desarrollo.', 'https://www.meetup.com/es-ES/meetup-de-innoit-consulting-en-madrid/', 1),
(6, 'DisiTech', 'Comunidad tecnológica centrada en eventos y contenidos donde la tecnología se conecta con diseño e IA desde una perspectiva creativa y no convencional.', 'https://www.linkedin.com/company/disitech/', 1),
(7, 'Women For Technical Talks (W4TT)', 'Comunidad que impulsa la participación de mujeres en carreras STEM como ponentes y profesionales técnicas.', 'https://www.women4tt.com/', 1),
(8, 'Microsoft Techie Girls Group', 'Meetup técnico orientado a tecnologías Microsoft para capacitar talento femenino y personas no binarias en cloud, datos e IA.', 'https://www.meetup.com/es-es/microsoft-techie-girls-group/', 1),
(9, 'Tech Riders', 'Comunidad tecnológica de Tajamar centrada en visibilidad y participación en eventos y redes.', 'https://techriders.tajamar.es/', 1),
(10, 'Global Power Platform Bootcamp Madrid', 'Eventos internacional centrado en Power Platform, low-code, automatización e IA aplicada.', 'https://www.powerplatformbootcamp.com/', 1);

-- City + Venue
DELETE FROM City;

INSERT INTO City (city_id, name, region, country) VALUES
(1, 'Madrid', NULL, 'Spain');

DELETE FROM Venue;

INSERT INTO Venue (venue_id, name, address, city_id, notes) VALUES
(1, 'ILAB', 'C. de Bailén, 41, Centro, 28005 Madrid, Spain', 1, NULL),
(2, 'La Nave', 'C. Cifuentes, 5, Villaverde, 28021 Madrid', 1, NULL),
(3, 'NTT Data Spain – Novus Building', 'Cam. de la Fuente de la Mora, 1, Hortaleza, 28050 Madrid, Spain', 1, NULL),
(4, 'Celonis SL', 'Pl. de Manuel Gómez-Moreno, 2, Tetuán, 28020 Madrid, Spain', 1, NULL),
(5, 'Meet&Go', 'C. de Martín de Vargas, 23, Arganzuela, 28005 Madrid, Spain', 1, NULL);

-- Event
DELETE FROM Event;

INSERT INTO Event (event_id, name, community_id, venue_id, starts_at, ends_at, language, external_url, visibility_id) VALUES
(1,'CodeMeet after Tech– Donde la comunidad se encuentra', 1, 1, '2026-02-18 18:15:00', '2026-02-18 20:30:00', 'Spanish', 'https://community.codemotion.com/codemotion-espana/meetups/codemeet-after-tech-donde-la-comunidad-se-encuentra', 1),
(2, 'EmpleaTech 2026 (Edición Madrid)', 2, 2, '2026-02-04 09:20:00', '2026-02-04 14:00:00', 'Spanish', 'https://empleatech.es/agenda/', 1),
(3, 'Season of AI – MCP by AzureBrains', 3, 3, '2026-01-29 18:30:00', '2026-01-29 19:30:00', 'Spanish', 'https://www.meetup.com/azurebrains/events/312537177/', 1),
(4, 'Fintech CONF 2026', 4, 4, '2026-01-28 18:45:00', '2026-01-28 21:30:00', 'Spanish', 'https://luma.com/soyngnfn?tk=dHq7fr', 1),
(5, 'Con licencia para razonar: IA al estilo 007', 5, 5, '2026-01-21 18:30:00', '2026-01-21 20:30:00', 'Spanish', 'https://www.meetup.com/es-ES/meetup-de-innoit-consulting-en-madrid/events/312499540/', 1),
(6, 'Global Power Platform Bootcamp Madrid 2026', 10, 3, '2026-02-14 09:00:00', '2026-02-14 18:00:00', 'Spanish', 'https://www.eventbrite.es/e/entradas-global-power-platform-bootcamp-madrid-2026-1981590026111', 1);

-- Role catalog
DELETE FROM Role;

INSERT INTO Role (role_id, name, notes) VALUES
(1, 'attendee',  'Attended the event'),
(2, 'speaker',   'Spoke at the event'),
(3, 'community-collaborator', 'Supported event promotion and community engagement');

-- Your participation
DELETE FROM EventParticipation;

INSERT INTO EventParticipation (participation_id, person_name, event_id, role_id, notes, visibility_id) VALUES
(1, 'Rukaya Masmoudi Messaoud', 1, 1, 'Attended as participant.', 1),
(2, 'Rukaya Masmoudi Messaoud', 2, 2, 'Speaker with Patricia Rodríguez Vaquero.', 1),
(3, 'Rukaya Masmoudi Messaoud', 3, 3, 'Supported promotion and community engagement for the meetup.', 1),
(4, 'Rukaya Masmoudi Messaoud', 4, 1, 'Attended as participant.', 1),
(5, 'Rukaya Masmoudi Messaoud', 5, 1, 'Attended as participant.', 1),
(6, 'Rukaya Masmoudi Messaoud', 6, 1, 'Attended as participant.', 1);

-- Your contribution
DELETE FROM Contribution;

INSERT INTO Contribution (contribution_id, event_id, type, title, description, starts_at, ends_at, visibility_id) VALUES
(1, 2, 'talk', 'Ser visible para poder existir: Out in Tech, identidad, resiliencia y crecimiento profesional', 'Tech Career Stories Room (Sala 7) — Charla 5. Shared with Patricia Rodríguez Vaquero.', '2026-02-04 11:40:00', '2026-02-04 11:55:00', 1);

-- Media assets
DELETE FROM MediaAsset;

INSERT INTO MediaAsset (asset_id, asset_type, taken_at, storage_ref, caption, visibility_id) VALUES
(1, 'PHOTO', '2026-02-18 19:30:00', 'docs/assets/events/codemeet-after-tech-cover.jpg', 'Panel en CodeMeet after Tech (Codemotion España).', 1),
(2, 'PHOTO', '2026-02-04 11:50:00', 'docs/assets/events/empleatech-2026-cover.jpg', 'Charla en EmpleaTech 2026 en La Nave (Madrid).', 1),
(3, 'PHOTO', '2026-01-29 19:00:00', 'docs/assets/events/azurebrains-season-ai-mcp-cover.jpg', 'Presentación Season of AI – MCP by AzureBrains.', 1),
(4, 'PHOTO', '2026-01-28 19:00:00', 'docs/assets/events/fintech-conf-2026-cover.jpg', 'Asistencia a Fintech CONF 2026 en las oficinas de Celonis (Madrid).', 1),
(5, 'PHOTO', '2026-01-21 19:30:00', 'docs/assets/events/con-licencia-ia-007-cover.jpg', 'Meetup "Con licencia para razonar: IA al estilo 007" de InnoIT Consulting en Meet&Go (Madrid).', 1),
(6, 'PHOTO', '2026-02-21 13:00:00', 'docs/assets/events/global-power-platform-bootcamp-madrid-2026-cover.jpg', 'Asistencia al Global Power Platform Bootcamp Madrid 2026.', 1),
(7, 'IMAGE', '2026-02-23 23:30:00', 'docs/assets/certifications/applied-skills/applied-skills-azure-ai-language.jpg', 'Microsoft Applied Skills: Build a natural language processing solution with Azure AI Language', 1),
(8, 'IMAGE', '2024-01-15 12:00:00', 'docs/assets/certifications/pl-400-badge.jpg', 'Microsoft Certified: Power Platform Developer Associate (PL-400).', 1),
(9, 'IMAGE', '2024-03-10 12:00:00', 'docs/assets/certifications/az-204-badge.jpg', 'Microsoft Certified: Azure Developer Associate (AZ-204).', 1),
(10, 'IMAGE', '2024-09-01 12:00:00', 'docs/assets/certifications/ai-102-badge.jpg', 'Microsoft Certified: Azure AI Engineer Associate (AI-102).', 1);

-- Event ↔ Media links
DELETE FROM EventMedia;

INSERT INTO EventMedia (event_id, asset_id, is_cover) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1);

-- PracticeResult ↔ Media links
DELETE FROM PracticeResultMedia;

INSERT INTO PracticeResultMedia (result_id, asset_id) VALUES 
(1, 7);

-- Certification ↔ Media links
DELETE FROM CertificationMedia;

INSERT INTO CertificationMedia (certification_id, asset_id) VALUES
(1, 8),
(2, 9),
(4, 10);

-- Posts
DELETE FROM Post;

INSERT INTO Post (post_id, platform, url, published_at, title, notes, visibility_id) VALUES
(1, 'LinkedIn', 'https://www.linkedin.com/posts/rukaya-masmoudi_alcachofas-activity-7422911684425674752-jhbi?utm_source=share&utm_medium=member_desktop&rcm=ACoAAEAMnmQByJUnEXTUyWJqTyUlfPm1itelPDI', '2026-01-30 10:00:00', 'Post en LinkedIn sobre Fintech CONF 2026 (Arcasiles)', 'Publicación en LinkedIn comentando la experiencia en Fintech CONF 2026 organizado por Arcasiles en las oficinas de Celonis (Madrid).', 1),
(2, 'LinkedIn', 'https://www.linkedin.com/posts/rukaya-masmoudi_el-mi%C3%A9rcoles-estuve-en-el-meetup-con-licencia-activity-7421114622314704897-SYqr?utm_source=share&utm_medium=member_desktop&rcm=ACoAAEAMnmQByJUnEXTUyWJqTyUlfPm1itelPDI', '2026-01-23 10:00:00', 'Post en LinkedIn sobre el meetup "Con licencia para razonar: IA al estilo 007"', 'Publicación en LinkedIn resumiendo la charla de Celeste Tania Sánchez Fresneda sobre agentes de IA al estilo James Bond en el meetup de InnoIT Consulting.', 1),
(3, 'LinkedIn', 'https://www.linkedin.com/posts/rukaya-masmoudi_powerplatform-gppb2026-community-activity-7432008948150452224-iJAW?utm_source=share&utm_medium=member_desktop&rcm=ACoAAEAMnmQByJUnEXTUyWJqTyUlfPm1itelPDI', '2026-02-23 11:30:00', 'Post en LinkedIn sobre el Global Power Platform Bootcamp Madrid 2026', 'Publicación en LinkedIn contando la experiencia en el Global Power Platform Bootcamp Madrid 2026, destacando sesiones y el ambiente de comunidad.', 1);

-- Link Event ↔ Post
DELETE FROM EventPost;

INSERT INTO EventPost (event_id, post_id) VALUES
(4, 1),
(5, 2),
(6, 3); 

-- Organizations (companies / educational centers)
INSERT INTO Organization (organization_id, name, org_type, website_url, city_id, description, visibility_id) VALUES
(1, 'Tajamar', 'education', 'https://tajamar.es/', 1, 'Centro educativo', 1),
(2, 'Linkia', 'education', 'https://linkiafp.es/', 1, 'Centro educativo', 1),
(3, 'Infoavan', 'company', 'https://infoavan.com/', 1, 'Empresa de consultoría especializada en tecnologías Microsoft.', 1),
(4, 'Creatiburón', 'company', 'https://www.creatiburon.com/', 1, 'Estudio de diseño gráfico y desarrollo web especializado en WordPress, WooCommerce y estrategia digital.', 1),
(5, 'Prosegur', 'company', 'https://www.prosegur.es/', 1, 'Empresa de servicios globales de seguridad y soporte operativo.', 1);

-- Engagement types
INSERT INTO EngagementType (engagement_type_id, name, notes) VALUES
(1, 'education',  'Formal education such as degrees and master programs'),
(2, 'work',       'Professional experience in companies'),
(3, 'volunteering','Community, meetup and non-profit contributions'),
(4, 'project',    'Individual or team projects (reserved for future use)');

-- Engagements: education, work, volunteering

-- Education
INSERT INTO Engagement (engagement_id, engagement_type_id, organization_id, community_id, title, started_on, ended_on, is_current, city_id, description, visibility_id) VALUES
(1, 1, 1, NULL, 'Máster en Desarrollo Web Full Stack + MultiCloud', '2023-10-01', '2024-06-30', 0, 1, 'Máster orientado a desarrollo web Full Stack con foco en front-end, back-end y nubes (Azure y AWS).', 1),
(2, 1, 2, NULL, 'Grado Superior en Desarrollo de Aplicaciones Web (DAW)', '2021-09-01', '2023-05-31', 0, 1, 'Formación en desarrollo de aplicaciones web (DAW)', 1);

-- Work
INSERT INTO Engagement (engagement_id, engagement_type_id, organization_id, community_id, title, started_on, ended_on, is_current, city_id, description, visibility_id) VALUES
(3, 2, 3, NULL, 'Technical Consultant', '2024-09-01', NULL, 1, 1, 'Rol como consultora técnica trabajando con tecnologías Microsoft especializada en inteligencia artificial.', 1),
(4, 2, 4, NULL, 'Desarrolladora y Diseñadora Web en WordPress', '2023-04-01', '2024-09-30', 0, 1, 'Desarrollo y diseño de sitios web en WordPress y WooCommerce, maquetación con HTML/CSS, diseño con Divi, SEO y accesibilidad web.', 1),
(5, 2, 5, NULL, 'Líder del equipo de Auxiliares en Ciudad Financiera del BBVA', '2017-10-01', '2023-04-30', 0, 1, 'Gestión de equipo, coordinación operativa y mejora de eficiencia mediante herramientas digitales en Ciudad Financiera del BBVA.', 1);

-- Volunteering
INSERT INTO Engagement (engagement_id, engagement_type_id, organization_id, community_id, title, started_on, ended_on, is_current, city_id, description, visibility_id) VALUES
(6, 3, NULL, 6, 'Co-fundadora y organizadora', '2025-05-01', NULL, 1, 1, 'Co-fundadora de una comunidad tecnológica centrada en eventos, contenidos y espacios formativos conectando tecnología y diseño.', 1),
(7, 3, NULL, 3, 'Gestión de eventos y difusión técnica', '2025-05-01', NULL, 1, 1, 'Colaboración en la organización y difusión de eventos técnicos centrados en Azure.', 1),
(8, 3, NULL, 7, 'Desarrollo, mantenimiento y actualización web', '2025-05-01', NULL, 1, 1, 'Gestión técnica de la web de W4TT, mantenimiento y actualización continua para asegurar correcto funcionamiento y contenido actualizado.', 1),
(9, 3, NULL, 8, 'Co-fundadora y organizadora', '2024-11-01', NULL, 1, 1, 'Co-fundadora de un meetup técnico orientado a tecnologías Microsoft, cloud, datos e IA para talento femenino y personas no binarias.', 1),
(10, 3, NULL, 9, 'Young Rider', '2023-10-01', '2024-06-30', 0, 1, 'Participación en la comunidad Tech Riders, dando visibilidad a eventos y actividades tecnológicas desde Tajamar.', 1);

-- =========================
-- REFLECTIONS & NLP SIGNALS (seed)
-- =========================

DELETE FROM ReflectionAnalysis;
DELETE FROM Reflection;

INSERT INTO Reflection (
  reflection_id,
  source_type,
  source_id,
  created_at,
  text,
  visibility_id
) VALUES
-- =========================
-- STUDY (StudySession)
-- =========================
(
  1,
  'STUDY',
  1,
  '2026-02-09 22:00:00',
  'Hoy he empezado oficialmente DP-900. Me sorprende lo mucho que ayuda volver a los fundamentos de los datos antes de meterse en IA.',
  1
),
(
  2,
  'STUDY',
  6,
  '2026-02-11 22:00:00',
  'La parte de datos no relacionales me ha roto un poco la cabeza, pero empiezo a ver por qué Cosmos DB tiene sentido cuando el modelo relacional se queda corto.',
  1
),
(
  3,
  'STUDY',
  9,
  '2026-02-12 22:15:00',
  'Cerrar la parte de analítica en Azure me ha hecho ver que el mundo datos no es solo tablas. Hay streaming, analítica masiva y visualización para contar historias.',
  1
),
(
  4,
  'STUDY',
  10,
  '2026-02-13 19:15:00',
  'Volver a Python para explorar datos me ha recordado por qué me gusta tanto Machine Learning: transformar números en decisiones.',
  1
),
(
  5,
  'STUDY',
  11,
  '2026-02-15 14:00:00',
  'Con los modelos de regresión por fin siento que puedo aterrizar problemas de negocio en algo medible. No es magia, son hipótesis, datos y evaluación.',
  1
),
(
  6,
  'STUDY',
  14,
  '2026-02-16 23:00:00',
  'Hoy he terminado la ruta de Create Machine Learning Models. Me ha costado, pero siento que por fin tengo una base real de Machine Learning en Azure.',
  1
),
(
  7,
  'STUDY',
  15,
  '2026-02-19 22:00:00',
  'Entrar en Azure AI Language me ha encantado. Ver texto convertirse en sentimiento, frases clave y categorías me parece justo lo que quiero aplicar en PURE.',
  1
),
(
  8,
  'STUDY',
  19,
  '2026-02-21 18:00:00',
  'Custom NER me ha hecho pensar en todas las entidades de mi propia vida tech: comunidades, eventos, roles. PURE puede convertirse en su propio dataset etiquetado.',
  1
),
(
  9,
  'STUDY',
  21,
  '2026-02-22 14:30:00',
  'La parte de voz en Azure AI y Foundry me ha abierto una puerta nueva: no solo quiero texto, también quiero voz, historias y narrativa en mis proyectos.',
  1
),
(
  10,
  'STUDY',
  23,
  '2026-02-23 22:15:00',
  'Cerrar la parte de apps generativas con audio me recuerda que quiero que PURE hable, escuche y acompañe, no solo que muestre datos.',
  1
),

-- =========================
-- EVENTS (Event)
-- =========================
(
  11,
  'EVENT',
  1,
  '2026-02-18 22:30:00',
  'CodeMeet after Tech ha sido una recarga social. Ver tanta gente tech junta me da la sensación de que no estoy sola en este camino.',
  1
),
(
  12,
  'EVENT',
  2, 
  '2026-02-04 23:00:00',
  'EmpleaTech ha sido intenso pero muy especial. Hablar de visibilidad femenina en tecnología me ha recordado por qué hago todo esto.',
  1
),
(
  13,
  'EVENT',
  3,
  '2026-01-29 22:00:00',
  'Season of AI – MCP me ha hecho ver que la comunidad no solo consume contenido: lo crea. Estar cerca de ese tipo de eventos me inspira a construir los míos.',
  1
),
(
  14,
  'EVENT',
  4,
  '2026-01-28 23:00:00',
  'Fintech CONF 2026 ha mezclado creatividad, marca personal y tecnología de una forma muy diferente a la típica charla técnica. Ese equilibrio me representa mucho.',
  1
),
(
  15,
  'EVENT',
  5,
  '2026-01-21 22:15:00',
  'El meetup "Con licencia para razonar" me ha hecho ver los agentes de IA como algo casi cinematográfico. Me gusta cuando lo técnico tiene narrativa.',
  1
),
(
  16,
  'EVENT',
  6,
  '2026-02-14 20:30:00',
  'El Global Power Platform Bootcamp me ha recordado por qué Power Platform es clave: velocidad, impacto y mucha comunidad alrededor.',
  1
),

-- =========================
-- ENGAGEMENTS (education, work, volunteering)
-- =========================
(
  17,
  'WORK',
  1,
  '2024-06-30 21:00:00',
  'El máster de Tajamar fue el punto donde dejé de ver la tecnología solo como algo que estudiaba y empecé a verla como algo que podía diseñar y gobernar.',
  1
),
(
  18,
  'WORK',
  2,
  '2023-05-31 21:00:00',
  'El DAW fue mucho más que un título: fue la prueba de que podía estudiar a distancia mientras trabajaba y seguir adelante aunque el camino no fuera lineal.',
  1
),
(
  19,
  'WORK',
  3,
  '2026-02-18 21:30:00',
  'En Infoavan empiezo a sentir que conecto mis proyectos personales con el trabajo del día a día. Falta mucho, pero el camino tiene sentido.',
  1
),
(
  20,
  'WORK',
  4,
  '2024-09-30 20:30:00',
  'Creatiburón me enseñó a cuidar el detalle visual y la experiencia. Hoy esa parte estética se nota en cómo quiero que PURE se vea y se sienta.',
  1
),
(
  21,
  'WORK',
  5,
  '2023-04-30 21:30:00',
  'Prosegur fue mi etapa de resiliencia. Coordinar equipos y lidiar con operativa diaria me preparó mucho más de lo que pensaba para el mundo tech.',
  1
),
(
  22,
  'WORK',
  6,
  '2025-05-15 22:00:00',
  'DisiTech es la prueba de que también puedo crear espacios propios. No solo consumir comunidad, sino construirla desde una perspectiva disidente.',
  1
),
(
  23,
  'WORK',
  8,
  '2025-06-15 21:30:00',
  'Colaborar con Women For Technical Talks me recuerda que no solo estoy construyendo mi carrera, también estoy ayudando a que otras tengan voz.',
  1
),
(
  24,
  'WORK',
  9,
  '2024-11-15 21:00:00',
  'Microsoft Techie Girls Group me conecta con el tipo de comunidad que quería encontrar cuando empecé: técnica, cercana y con referentes femeninos.',
  1
);

-- =========================
-- NLP ANALYSIS (Azure AI Language)
-- =========================

INSERT INTO ReflectionAnalysis (
  analysis_id,
  reflection_id,
  provider,
  language_code,
  sentiment_label,
  sentiment_positive,
  sentiment_neutral,
  sentiment_negative,
  key_phrases,
  category,
  pii_flag,
  visibility_id,
  created_at
) VALUES
-- STUDY
(
  1,
  1,
  'azure-ai-language',
  'es',
  'positive',
  0.84,
  0.13,
  0.03,
  'DP-900,fundamentos de datos,IA,Azure',
  'learning',
  0,
  1,
  '2026-02-09 22:05:00'
),
(
  2,
  2,
  'azure-ai-language',
  'es',
  'positive',
  0.82,
  0.14,
  0.04,
  'datos no relacionales,Cosmos DB,modelo relacional',
  'learning',
  0,
  1,
  '2026-02-11 22:05:00'
),
(
  3,
  3,
  'azure-ai-language',
  'es',
  'positive',
  0.88,
  0.10,
  0.02,
  'analítica en Azure,streaming,visualización,historias con datos',
  'learning',
  0,
  1,
  '2026-02-12 22:20:00'
),
(
  4,
  4,
  'azure-ai-language',
  'es',
  'positive',
  0.86,
  0.11,
  0.03,
  'Python,explorar datos,Machine Learning,decisiones',
  'learning',
  0,
  1,
  '2026-02-13 19:20:00'
),
(
  5,
  5,
  'azure-ai-language',
  'es',
  'positive',
  0.87,
  0.10,
  0.03,
  'regresión,problemas de negocio,medible,evaluación',
  'learning',
  0,
  1,
  '2026-02-15 14:05:00'
),
(
  6,
  6,
  'azure-ai-language',
  'es',
  'positive',
  0.89,
  0.08,
  0.03,
  'Create Machine Learning Models,base real de Machine Learning,Azure',
  'learning',
  0,
  1,
  '2026-02-16 23:05:00'
),
(
  7,
  7,
  'azure-ai-language',
  'es',
  'positive',
  0.90,
  0.07,
  0.03,
  'Azure AI Language,texto,sentimiento,frases clave, PURE',
  'learning',
  0,
  1,
  '2026-02-19 22:05:00'
),
(
  8,
  8,
  'azure-ai-language',
  'es',
  'positive',
  0.88,
  0.09,
  0.03,
  'Custom NER,entidades,comunidades,eventos,roles, dataset etiquetado',
  'learning',
  0,
  1,
  '2026-02-21 18:05:00'
),
(
  9,
  9,
  'azure-ai-language',
  'es',
  'positive',
  0.87,
  0.10,
  0.03,
  'voz,Azure AI,Foundry, historias,narrativa',
  'learning',
  0,
  1,
  '2026-02-22 14:35:00'
),
(
  10,
  10,
  'azure-ai-language',
  'es',
  'positive',
  0.89,
  0.08,
  0.03,
  'apps generativas,audio,PURE,hable y escuche',
  'learning',
  0,
  1,
  '2026-02-23 22:20:00'
),

-- EVENTS
(
  11,
  11,
  'azure-ai-language',
  'es',
  'positive',
  0.92,
  0.06,
  0.02,
  'CodeMeet after Tech,comunidad,recarga social,camino',
  'community',
  0,
  1,
  '2026-02-18 22:35:00'
),
(
  12,
  12,
  'azure-ai-language',
  'es',
  'positive',
  0.91,
  0.07,
  0.02,
  'EmpleaTech,visibilidad femenina,tecnología',
  'community',
  0,
  1,
  '2026-02-04 23:05:00'
),
(
  13,
  13,
  'azure-ai-language',
  'es',
  'positive',
  0.90,
  0.08,
  0.02,
  'Season of AI,AzureBrains,comunidad,crear contenido',
  'community',
  0,
  1,
  '2026-01-29 22:05:00'
),
(
  14,
  14,
  'azure-ai-language',
  'es',
  'positive',
  0.89,
  0.09,
  0.02,
  'Fintech CONF 2026,creatividad,marca personal,tecnología,equilibrio',
  'community',
  0,
  1,
  '2026-01-28 23:05:00'
),
(
  15,
  15,
  'azure-ai-language',
  'es',
  'positive',
  0.88,
  0.10,
  0.02,
  'Con licencia para razonar,agentes de IA,narrativa,James Bond',
  'community',
  0,
  1,
  '2026-01-21 22:20:00'
),
(
  16,
  16,
  'azure-ai-language',
  'es',
  'positive',
  0.90,
  0.08,
  0.02,
  'Global Power Platform Bootcamp,Power Platform,low-code,comunidad',
  'community',
  0,
  1,
  '2026-02-14 20:35:00'
),

-- ENGAGEMENTS
(
  17,
  17,
  'azure-ai-language',
  'es',
  'positive',
  0.88,
  0.10,
  0.02,
  'máster,Tajamar,diseñar tecnología,gobernar sistemas',
  'career',
  0,
  1,
  '2024-06-30 21:05:00'
),
(
  18,
  18,
  'azure-ai-language',
  'es',
  'positive',
  0.87,
  0.11,
  0.02,
  'DAW,estudiar a distancia,trabajar,camino no lineal',
  'career',
  0,
  1,
  '2023-05-31 21:05:00'
),
(
  19,
  19,
  'azure-ai-language',
  'es',
  'positive',
  0.79,
  0.18,
  0.03,
  'Infoavan,proyectos personales,trabajo del día a día,camino',
  'career',
  0,
  1,
  '2026-02-18 21:35:00'
),
(
  20,
  20,
  'azure-ai-language',
  'es',
  'positive',
  0.86,
  0.11,
  0.03,
  'Creatiburón,detalle visual,experiencia,PURE,se vea y se sienta',
  'career',
  0,
  1,
  '2024-09-30 20:35:00'
),
(
  21,
  21,
  'azure-ai-language',
  'es',
  'positive',
  0.85,
  0.12,
  0.03,
  'Prosegur,resiliencia,gestión de equipos,operativa diaria,mundo tech',
  'career',
  0,
  1,
  '2023-04-30 21:35:00'
),
(
  22,
  22,
  'azure-ai-language',
  'es',
  'positive',
  0.90,
  0.08,
  0.02,
  'DisiTech,espacios propios,comunidad,perspectiva disidente',
  'community',
  0,
  1,
  '2025-05-15 22:05:00'
),
(
  23,
  23,
  'azure-ai-language',
  'es',
  'positive',
  0.89,
  0.09,
  0.02,
  'Women For Technical Talks,voz,mujeres en tecnología,apoyo',
  'community',
  0,
  1,
  '2025-06-15 21:35:00'
),
(
  24,
  24,
  'azure-ai-language',
  'es',
  'positive',
  0.90,
  0.07,
  0.03,
  'Microsoft Techie Girls Group,meetup técnico,referentes femeninos,cloud,datos,IA',
  'community',
  0,
  1,
  '2024-11-15 21:05:00'
);

-- =========================
-- REFLECTION LABELS (multi-label)
-- =========================

DELETE FROM ReflectionLabelAssignment;
DELETE FROM ReflectionLabel;

INSERT INTO ReflectionLabel (label_id, name, description) VALUES
(1,  'foundations',        'Fundamentos técnicos y bases conceptuales'),
(2,  'machine-learning',   'Aprendizaje automático y modelos predictivos'),
(3,  'azure',              'Tecnologías del ecosistema Azure'),
(4,  'nlp',                'Procesamiento de lenguaje natural'),
(5,  'community',          'Eventos, networking y comunidad'),
(6,  'career-growth',      'Evolución profesional y trayectoria'),
(7,  'resilience',         'Esfuerzo, superación y disciplina'),
(8,  'identity',           'Marca personal y propósito'),
(9,  'leadership',         'Gestión de equipos y liderazgo'),
(10, 'creativity',         'Creatividad y narrativa aplicada a tecnología'),
(11, 'power-platform',     'Tecnologías Power Platform'),
(12, 'ai-agents',          'Agentes, IA generativa y automatización');

-- =========================
-- REFLECTION LABEL ASSIGNMENTS
-- =========================

INSERT INTO ReflectionLabelAssignment (reflection_id, label_id) VALUES

-- STUDY
(1, 1), (1, 3),                        -- foundations + azure
(2, 1), (2, 3),                        -- foundations + azure
(3, 1), (3, 3),                        -- analytics + azure
(4, 2), (4, 3),                        -- ML + azure
(5, 2),                                -- ML
(6, 2), (6, 3),                        -- ML + azure
(7, 4), (7, 3),                        -- NLP + azure
(8, 4),                                -- NLP
(9, 4), (9, 12),                       -- NLP + AI agents
(10, 12), (10, 2),                     -- generative AI + ML

-- EVENTS
(11, 5),                               -- community
(12, 5), (12, 8),                      -- community + identity
(13, 5), (13, 12),                     -- community + AI agents
(14, 5), (14, 10),                     -- community + creativity
(15, 5), (15, 12),                     -- community + AI agents
(16, 5), (16, 11),                     -- community + power-platform

-- ENGAGEMENTS
(17, 6), (17, 7),                      -- career + resilience
(18, 6), (18, 7),                      -- career + resilience
(19, 6),                               -- career
(20, 6), (20, 10),                     -- career + creativity
(21, 6), (21, 9), (21, 7),             -- career + leadership + resilience
(22, 5), (22, 8),                      -- community + identity
(23, 5), (23, 8),                      -- community + identity
(24, 5), (24, 8), (24, 3);             -- community + identity + azure