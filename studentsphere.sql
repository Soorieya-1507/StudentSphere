--
-- PostgreSQL database dump
--

\restrict 4HA9Ajre9DdklU0rgYE529jrjI5Vp58Qm0n7esrzWrxl6een1D2vEJtTSJSsbdd

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-06-13 19:16:38

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 49432)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 5408 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 237 (class 1259 OID 49760)
-- Name: academic_health_index; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.academic_health_index (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    ahi_score double precision NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.academic_health_index OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 50008)
-- Name: accreditation_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accreditation_reports (
    id uuid NOT NULL,
    institute_id uuid NOT NULL,
    report_type character varying NOT NULL,
    academic_year character varying NOT NULL,
    file_path character varying,
    data_snapshot json,
    generated_at timestamp without time zone
);


ALTER TABLE public.accreditation_reports OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 49470)
-- Name: achievement_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.achievement_categories (
    id uuid NOT NULL,
    name character varying NOT NULL,
    default_points integer,
    priority character varying
);


ALTER TABLE public.achievement_categories OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 49568)
-- Name: achievements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.achievements (
    id uuid NOT NULL,
    student_id uuid,
    department_id uuid,
    category_id uuid,
    title character varying NOT NULL,
    description text,
    organization_name character varying,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    academic_year integer,
    semester integer,
    certificate_url character varying,
    supporting_docs_url character varying,
    status character varying,
    points_awarded integer,
    ocr_student_name character varying,
    ocr_organization character varying,
    ocr_event_name character varying,
    ocr_date character varying,
    duplicate_status character varying,
    duplicate_confidence integer,
    created_at timestamp without time zone
);


ALTER TABLE public.achievements OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 50131)
-- Name: alumni_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alumni_records (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    department_id uuid NOT NULL,
    graduation_year integer NOT NULL,
    outcome_type character varying NOT NULL,
    company_name character varying,
    role character varying,
    university_name character varying
);


ALTER TABLE public.alumni_records OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 49652)
-- Name: approval_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.approval_history (
    id uuid NOT NULL,
    achievement_id uuid,
    faculty_id uuid,
    action character varying,
    comments text,
    action_date timestamp without time zone
);


ALTER TABLE public.approval_history OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 49903)
-- Name: arrear_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.arrear_records (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    subject_id uuid NOT NULL,
    attempt_number integer NOT NULL,
    status character varying NOT NULL,
    cleared_date timestamp without time zone
);


ALTER TABLE public.arrear_records OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 49633)
-- Name: assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assignments (
    id uuid NOT NULL,
    course_id uuid,
    faculty_id uuid,
    title character varying NOT NULL,
    description text,
    due_date timestamp without time zone
);


ALTER TABLE public.assignments OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 49856)
-- Name: attendance_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attendance_records (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    subject_id uuid NOT NULL,
    month character varying NOT NULL,
    total_classes integer NOT NULL,
    attended_classes integer NOT NULL,
    percentage double precision NOT NULL
);


ALTER TABLE public.attendance_records OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 50040)
-- Name: career_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.career_profiles (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    career_readiness_score double precision,
    category character varying,
    preferred_role character varying,
    snapshot_date timestamp without time zone
);


ALTER TABLE public.career_profiles OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 50084)
-- Name: career_roadmaps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.career_roadmaps (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    target_role character varying NOT NULL,
    steps json NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.career_roadmaps OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 49730)
-- Name: cgpa_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cgpa_records (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    cgpa double precision NOT NULL,
    total_credits_earned integer NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.cgpa_records OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 50226)
-- Name: community_posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.community_posts (
    id uuid NOT NULL,
    author_id uuid NOT NULL,
    department_id uuid,
    post_type character varying NOT NULL,
    title character varying NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.community_posts OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 49551)
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    id uuid NOT NULL,
    code character varying NOT NULL,
    name character varying NOT NULL,
    department_id uuid,
    credits integer
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 49925)
-- Name: department_health_index; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department_health_index (
    id uuid NOT NULL,
    department_id uuid NOT NULL,
    score double precision NOT NULL,
    category character varying NOT NULL,
    attendance_avg double precision,
    cgpa_avg double precision,
    arrears_avg double precision,
    achievements_count integer,
    snapshot_date timestamp without time zone
);


ALTER TABLE public.department_health_index OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 49605)
-- Name: department_rankings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department_rankings (
    id uuid NOT NULL,
    department_id uuid,
    academic_year integer,
    total_certificates integer,
    total_internships integer,
    total_projects integer,
    total_research_papers integer,
    total_hackathons integer,
    department_score integer,
    ranking integer,
    calculated_at timestamp without time zone
);


ALTER TABLE public.department_rankings OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 49447)
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    id uuid NOT NULL,
    name character varying NOT NULL,
    institute_id uuid NOT NULL,
    hod_id uuid
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 49616)
-- Name: enrollments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrollments (
    student_id uuid NOT NULL,
    course_id uuid NOT NULL,
    semester integer
);


ALTER TABLE public.enrollments OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 49941)
-- Name: faculty_impact_index; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculty_impact_index (
    id uuid NOT NULL,
    faculty_id uuid NOT NULL,
    score double precision NOT NULL,
    category character varying NOT NULL,
    mentoring_score double precision,
    student_growth_score double precision,
    snapshot_date timestamp without time zone
);


ALTER TABLE public.faculty_impact_index OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 49511)
-- Name: faculty_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculty_profiles (
    user_id uuid NOT NULL,
    employee_id character varying NOT NULL,
    department_id uuid,
    profile_photo_url character varying,
    qualification character varying,
    experience integer,
    research_papers_count integer,
    research_areas character varying,
    biography text
);


ALTER TABLE public.faculty_profiles OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 49818)
-- Name: gpa_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gpa_records (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    semester_id uuid NOT NULL,
    gpa double precision NOT NULL,
    credits_earned integer NOT NULL
);


ALTER TABLE public.gpa_records OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 49433)
-- Name: institutes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.institutes (
    id uuid NOT NULL,
    institute_id character varying NOT NULL,
    name character varying NOT NULL,
    total_faculty integer,
    total_students integer,
    domain character varying NOT NULL
);


ALTER TABLE public.institutes OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 50024)
-- Name: institution_intelligence_score; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.institution_intelligence_score (
    id uuid NOT NULL,
    institute_id uuid NOT NULL,
    score double precision NOT NULL,
    category character varying NOT NULL,
    academic_factor double precision,
    placement_factor double precision,
    research_factor double precision,
    snapshot_date timestamp without time zone
);


ALTER TABLE public.institution_intelligence_score OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 49838)
-- Name: internal_marks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.internal_marks (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    subject_id uuid NOT NULL,
    internal_1 double precision,
    internal_2 double precision,
    assignment double precision,
    model_exam double precision
);


ALTER TABLE public.internal_marks OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 49973)
-- Name: internship_gap_analysis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.internship_gap_analysis (
    id uuid NOT NULL,
    department_id uuid NOT NULL,
    academic_year character varying NOT NULL,
    participation_rate double precision NOT NULL,
    gap_score double precision NOT NULL,
    snapshot_date timestamp without time zone
);


ALTER TABLE public.internship_gap_analysis OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 50210)
-- Name: learning_recommendations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.learning_recommendations (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    item_type character varying NOT NULL,
    title character varying NOT NULL,
    reason text,
    status character varying
);


ALTER TABLE public.learning_recommendations OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 49532)
-- Name: mentor_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mentor_assignments (
    id uuid NOT NULL,
    faculty_id uuid NOT NULL,
    department_id uuid NOT NULL,
    batch_year integer NOT NULL
);


ALTER TABLE public.mentor_assignments OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 49773)
-- Name: mentor_feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mentor_feedback (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    mentor_id uuid NOT NULL,
    feedback_type character varying NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.mentor_feedback OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 49592)
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id uuid NOT NULL,
    user_id uuid,
    title character varying,
    message text,
    is_read boolean,
    created_at timestamp without time zone
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 49957)
-- Name: placement_readiness; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.placement_readiness (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    score double precision NOT NULL,
    category character varying NOT NULL,
    cgpa_factor double precision,
    internship_factor double precision,
    project_factor double precision,
    snapshot_date timestamp without time zone
);


ALTER TABLE public.placement_readiness OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 50100)
-- Name: portfolio_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.portfolio_profiles (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    public_url_slug character varying NOT NULL,
    is_public boolean,
    theme character varying,
    pdf_export_url character varying,
    created_at timestamp without time zone
);


ALTER TABLE public.portfolio_profiles OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 50153)
-- Name: recruiter_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recruiter_profiles (
    user_id uuid NOT NULL,
    company_name character varying NOT NULL,
    industry character varying,
    is_verified boolean
);


ALTER TABLE public.recruiter_profiles OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 50167)
-- Name: recruiter_search_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recruiter_search_logs (
    id uuid NOT NULL,
    recruiter_id uuid NOT NULL,
    search_query character varying,
    filters_used json,
    "timestamp" timestamp without time zone
);


ALTER TABLE public.recruiter_search_logs OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 50117)
-- Name: resume_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resume_profiles (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    ats_score double precision,
    compatibility_feedback text,
    resume_type character varying,
    pdf_url character varying,
    docx_url character varying,
    generated_at timestamp without time zone
);


ALTER TABLE public.resume_profiles OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 49744)
-- Name: risk_assessments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.risk_assessments (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    risk_score double precision NOT NULL,
    risk_category character varying NOT NULL,
    factors text,
    updated_at timestamp without time zone
);


ALTER TABLE public.risk_assessments OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 49880)
-- Name: semester_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.semester_results (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    subject_id uuid NOT NULL,
    grade character varying NOT NULL,
    credits integer NOT NULL,
    status character varying NOT NULL
);


ALTER TABLE public.semester_results OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 49713)
-- Name: semesters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.semesters (
    id uuid NOT NULL,
    department_id uuid NOT NULL,
    semester_number integer NOT NULL,
    academic_year character varying NOT NULL,
    regulation character varying NOT NULL,
    start_date timestamp without time zone,
    end_date timestamp without time zone
);


ALTER TABLE public.semesters OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 50069)
-- Name: skill_gap_analysis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skill_gap_analysis (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    target_role character varying NOT NULL,
    missing_skills json,
    weak_skills json,
    gap_score double precision,
    analysis_date timestamp without time zone
);


ALTER TABLE public.skill_gap_analysis OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 50054)
-- Name: skill_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skill_profiles (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    skill_name character varying NOT NULL,
    proficiency character varying,
    is_verified boolean,
    source character varying
);


ALTER TABLE public.skill_profiles OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 50195)
-- Name: student_digital_twins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_digital_twins (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    snapshot_data json NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.student_digital_twins OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 49481)
-- Name: student_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_profiles (
    user_id uuid NOT NULL,
    enrollment_number character varying NOT NULL,
    roll_number character varying,
    department_id uuid,
    batch_year integer,
    mentor_id uuid,
    linkedin_url character varying,
    gender character varying,
    accommodation character varying,
    father_name character varying,
    father_mobile character varying,
    father_occupation character varying,
    mother_name character varying,
    mother_mobile character varying,
    mother_occupation character varying,
    family_income character varying,
    year_of_joining integer,
    year_of_passing integer,
    tenth_percentage character varying,
    twelfth_percentage character varying,
    school_name character varying,
    school_address character varying,
    home_address character varying,
    aadhaar_number character varying,
    aadhaar_certificate_url character varying,
    community_certificate_url character varying,
    bank_passbook_url character varying,
    tenth_marksheet_url character varying,
    twelfth_marksheet_url character varying,
    public_profile_id uuid,
    profile_status character varying,
    rejection_reason text
);


ALTER TABLE public.student_profiles OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 50181)
-- Name: student_success_index; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_success_index (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    score double precision,
    category character varying,
    cgpa_factor double precision,
    attendance_factor double precision,
    achievements_factor double precision,
    crs_factor double precision,
    pri_factor double precision,
    research_factor double precision,
    skill_factor double precision,
    snapshot_date timestamp without time zone
);


ALTER TABLE public.student_success_index OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 49990)
-- Name: student_success_predictions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_success_predictions (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    improvement_probability double precision NOT NULL,
    dropout_risk double precision NOT NULL,
    requires_intervention character varying NOT NULL,
    confidence_score double precision NOT NULL,
    explanation text,
    snapshot_date timestamp without time zone
);


ALTER TABLE public.student_success_predictions OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 49795)
-- Name: subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subjects (
    id uuid NOT NULL,
    semester_id uuid NOT NULL,
    subject_code character varying NOT NULL,
    subject_name character varying NOT NULL,
    credits integer NOT NULL,
    department_id uuid NOT NULL
);


ALTER TABLE public.subjects OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 49670)
-- Name: submissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.submissions (
    id uuid NOT NULL,
    assignment_id uuid,
    student_id uuid,
    content_url character varying,
    submitted_at timestamp without time zone,
    grade character varying,
    feedback text
);


ALTER TABLE public.submissions OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 49457)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    email character varying NOT NULL,
    hashed_password character varying NOT NULL,
    role character varying NOT NULL,
    mobile_number character varying NOT NULL,
    is_active boolean,
    created_at timestamp without time zone,
    institute_id uuid,
    department_id uuid
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 5375 (class 0 OID 49760)
-- Dependencies: 237
-- Data for Name: academic_health_index; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.academic_health_index (id, student_id, ahi_score, updated_at) FROM stdin;
\.


--
-- TOC entry 5388 (class 0 OID 50008)
-- Dependencies: 250
-- Data for Name: accreditation_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accreditation_reports (id, institute_id, report_type, academic_year, file_path, data_snapshot, generated_at) FROM stdin;
\.


--
-- TOC entry 5360 (class 0 OID 49470)
-- Dependencies: 222
-- Data for Name: achievement_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.achievement_categories (id, name, default_points, priority) FROM stdin;
6a376801-170d-4dd1-a676-747c79ecd5a1	Workshop	5	LOW
01935919-620a-4613-b671-7df0c552fc14	Certificate	10	LOW
702d75b3-be79-45f0-96c9-2587af9ccf0a	Event Participation	10	MEDIUM
3f0e0cae-a143-472d-9b92-047307e11494	Project	30	MEDIUM
fbd7200f-8159-4648-ad4a-55b2f537be46	Internship	25	HIGH
ddcac4e0-99ac-4937-9fec-09c7375afd6f	Research Paper	50	HIGH
8868dd1f-7799-4754-a046-2fab0e86a3f0	Hackathon Participation	40	HIGH
980026ca-4dbd-4d39-8fe1-b2abc9adcbe1	Hackathon Winner	75	HIGH
70eb05d5-4e4a-43f5-ac56-c243eac2e045	Sports Achievement	20	MEDIUM
b1c0a386-a0ef-49d3-916b-376a5dad0cbf	Cultural Achievement	20	MEDIUM
\.


--
-- TOC entry 5365 (class 0 OID 49568)
-- Dependencies: 227
-- Data for Name: achievements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.achievements (id, student_id, department_id, category_id, title, description, organization_name, start_date, end_date, academic_year, semester, certificate_url, supporting_docs_url, status, points_awarded, ocr_student_name, ocr_organization, ocr_event_name, ocr_date, duplicate_status, duplicate_confidence, created_at) FROM stdin;
b3a035f1-0053-4a1c-ad1e-5654486b7725	b8bfae65-ef25-4267-bec0-e227ee9cfb95	4d6a5eee-7226-445a-a6aa-5135f8887140	01935919-620a-4613-b671-7df0c552fc14	IBM Course Cognitive Class		IBM	2026-04-12 00:00:00	2026-04-15 00:00:00	2024	1	\N	\N	DRAFT	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 09:51:26.734414
665ddc75-603d-46ee-8b92-b17ab6913d12	fcbc51f6-0c5a-414e-ad83-05d0907bf80e	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	6a376801-170d-4dd1-a676-747c79ecd5a1	Hacked Auto-Approved Achievement	\N	Hacker Org	\N	\N	\N	\N	\N	\N	PENDING	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 09:56:01.782578
0ac2107b-4339-4c17-af2c-42ba953ce1eb	53c77baa-295a-45a6-a90d-a713a43c1e53	0ab92ffa-cf85-43c5-9b36-68d2bf5f5d85	6a376801-170d-4dd1-a676-747c79ecd5a1	Student A Cert	Test cert	TestOrg	\N	\N	2025	1	\N	\N	DRAFT	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 10:03:32.078829
0d6f2014-566f-45cf-ad28-850dfffdf320	b59a697f-f67e-4307-bd61-ed36917cfd5b	03df13aa-b840-4fba-8461-7278d7669f21	6a376801-170d-4dd1-a676-747c79ecd5a1	Approved Cert Test	\N	\N	\N	\N	2025	1	\N	\N	APPROVED	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 10:03:32.745711
2e1cb46f-7305-4978-b0aa-8406e145e15d	b59a697f-f67e-4307-bd61-ed36917cfd5b	03df13aa-b840-4fba-8461-7278d7669f21	6a376801-170d-4dd1-a676-747c79ecd5a1	Pending Cert Test	\N	\N	\N	\N	2025	1	\N	\N	PENDING	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 10:03:32.760384
2dc7410c-000f-4e43-9fa4-15fbc2cdf745	76dfde8a-075b-44dc-9ee8-dc8f93c6f6f6	6c7860ff-99ac-4d0c-a209-7e45cdd89686	6a376801-170d-4dd1-a676-747c79ecd5a1	Student A Cert	Test cert	TestOrg	\N	\N	2025	1	\N	\N	DRAFT	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 10:04:24.594903
87fc2e1b-c473-495a-bf03-88b897134417	f593445f-21e9-437a-ac0a-f09341d44cef	56f6d369-d0b4-416b-b7a9-f0dc751cf3b5	6a376801-170d-4dd1-a676-747c79ecd5a1	Approved Cert Test	\N	\N	\N	\N	2025	1	\N	\N	APPROVED	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 10:04:25.247732
d24cffe9-3821-42b6-9e0f-3c6cc1224cbd	f593445f-21e9-437a-ac0a-f09341d44cef	56f6d369-d0b4-416b-b7a9-f0dc751cf3b5	6a376801-170d-4dd1-a676-747c79ecd5a1	Pending Cert Test	\N	\N	\N	\N	2025	1	\N	\N	PENDING	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 10:04:25.263585
f7cbbe58-3d77-48ac-b5f2-37637b010eb0	08589901-0057-4b52-a431-b9090807af86	67556692-ca7d-463d-9a43-54df33af1d5b	6a376801-170d-4dd1-a676-747c79ecd5a1	Student A Cert	Test cert	TestOrg	\N	\N	2025	1	\N	\N	DRAFT	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 10:05:28.519394
de1abf6a-0ba1-41be-a45c-76e7100b0dea	102096c5-f659-446d-8022-f4b620a7589c	5dfa0623-6eea-473d-a331-e5a97f969fd0	6a376801-170d-4dd1-a676-747c79ecd5a1	Approved Cert Test	\N	\N	\N	\N	2025	1	\N	\N	APPROVED	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 10:05:29.17279
c4729440-1765-4bb0-bbf0-d62affc2dafc	102096c5-f659-446d-8022-f4b620a7589c	5dfa0623-6eea-473d-a331-e5a97f969fd0	6a376801-170d-4dd1-a676-747c79ecd5a1	Pending Cert Test	\N	\N	\N	\N	2025	1	\N	\N	PENDING	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 10:05:29.188469
b6705d67-2c07-4f82-bc4e-9b18e0812de0	0cae0790-e00a-43f2-94f5-5b55d33f0909	d71823d2-033e-46da-a1c5-12c20bafa4f4	6a376801-170d-4dd1-a676-747c79ecd5a1	Student A Cert	Test cert	TestOrg	\N	\N	2025	1	\N	\N	DRAFT	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:05:25.138289
976e2fd6-a0c9-463f-9e75-44231a0769de	bca185f7-55bc-4219-a7bb-1fefe34a9d1c	de6a08fb-3018-422d-b384-6e7dff4af315	6a376801-170d-4dd1-a676-747c79ecd5a1	Approved Cert Test	\N	\N	\N	\N	2025	1	\N	\N	APPROVED	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:05:25.697889
7aeeccd4-b1f3-4269-a887-e2c6fd304dba	bca185f7-55bc-4219-a7bb-1fefe34a9d1c	de6a08fb-3018-422d-b384-6e7dff4af315	6a376801-170d-4dd1-a676-747c79ecd5a1	Pending Cert Test	\N	\N	\N	\N	2025	1	\N	\N	PENDING	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:05:25.709981
34d11103-5a37-46c0-884b-b85eee36456a	4a0612fd-1aed-4d8d-b84d-ba2c59267cfb	a5d619a0-b481-4e5b-988d-85589dd6168c	6a376801-170d-4dd1-a676-747c79ecd5a1	Student A Cert	Test cert	TestOrg	\N	\N	2025	1	\N	\N	DRAFT	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:08:20.142011
6c5b57f1-468f-42bb-a72d-cda792a538f2	61368e4f-ffe9-46b3-a22e-d2a5ea9adc09	ba66490c-4ec3-4181-b0ce-6a3342d0366a	6a376801-170d-4dd1-a676-747c79ecd5a1	Approved Cert Test	\N	\N	\N	\N	2025	1	\N	\N	APPROVED	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:08:20.691865
a5758728-3a82-4ed6-9ea6-0eb7f5edb7be	61368e4f-ffe9-46b3-a22e-d2a5ea9adc09	ba66490c-4ec3-4181-b0ce-6a3342d0366a	6a376801-170d-4dd1-a676-747c79ecd5a1	Pending Cert Test	\N	\N	\N	\N	2025	1	\N	\N	PENDING	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:08:20.704897
7136f241-6071-4a81-8406-ce7c49da8e81	9030cfd4-3968-4eb7-b7f1-aed308bd26e4	4e955f10-3c93-4f07-b325-0cab11aa0493	6a376801-170d-4dd1-a676-747c79ecd5a1	Student A Cert	Test cert	TestOrg	\N	\N	2025	1	\N	\N	DRAFT	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:09:45.412637
28e1a8ec-bfa6-406e-9068-677cdcb70608	4cce8634-6f55-4de9-857c-0f245c893979	027632d1-3166-4cd3-8463-7e03ae68e534	6a376801-170d-4dd1-a676-747c79ecd5a1	Approved Cert Test	\N	\N	\N	\N	2025	1	\N	\N	APPROVED	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:09:45.948334
4c9e591c-d6ee-433d-bd82-6d94e30724a9	4cce8634-6f55-4de9-857c-0f245c893979	027632d1-3166-4cd3-8463-7e03ae68e534	6a376801-170d-4dd1-a676-747c79ecd5a1	Pending Cert Test	\N	\N	\N	\N	2025	1	\N	\N	PENDING	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:09:45.960721
5a95af72-bc37-4a02-996d-b5eddff7b18b	0ab7c80e-e828-40bf-8aa8-3f5a6b65ecae	7a920d00-8293-4558-9c43-04ca5f295124	6a376801-170d-4dd1-a676-747c79ecd5a1	Student A Cert	Test cert	TestOrg	\N	\N	2025	1	\N	\N	DRAFT	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:14:21.347757
39f26638-7ab7-4060-8a2c-6b3074fecf4e	7b6469a6-e2b3-4f20-ae06-68bf7e77f28b	16c76429-22e0-412f-9272-3123c66dbe5a	6a376801-170d-4dd1-a676-747c79ecd5a1	Approved Cert Test	\N	\N	\N	\N	2025	1	\N	\N	APPROVED	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:14:21.876408
b337ed81-d8ae-48ee-b784-e3589ddbd3c1	7b6469a6-e2b3-4f20-ae06-68bf7e77f28b	16c76429-22e0-412f-9272-3123c66dbe5a	6a376801-170d-4dd1-a676-747c79ecd5a1	Pending Cert Test	\N	\N	\N	\N	2025	1	\N	\N	PENDING	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:14:21.889405
e3f62aa1-5c6d-40f3-bace-33223c20af91	233ee444-cd4d-4542-8aaa-1e5d55605f81	42ae23c2-47db-4929-ac14-62b026bd019f	6a376801-170d-4dd1-a676-747c79ecd5a1	Student A Cert	Test cert	TestOrg	\N	\N	2025	1	\N	\N	DRAFT	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:18:21.365082
e7fce553-ded3-45ec-aea9-10540dc6e434	9f926d82-77f8-411e-8619-876308fede35	8291d7ed-0e7c-4267-9ba8-4189816219fc	6a376801-170d-4dd1-a676-747c79ecd5a1	Approved Cert Test	\N	\N	\N	\N	2025	1	\N	\N	APPROVED	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:18:21.938494
4845afd8-bb5b-4026-8c8a-79922fdf8113	9f926d82-77f8-411e-8619-876308fede35	8291d7ed-0e7c-4267-9ba8-4189816219fc	6a376801-170d-4dd1-a676-747c79ecd5a1	Pending Cert Test	\N	\N	\N	\N	2025	1	\N	\N	PENDING	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:18:21.950403
40ba4817-2ca7-4011-83fb-bc4b462e0ca0	46deae43-ad61-4049-9103-aabae3297c73	bc5b07bf-96b1-4e0e-b711-0a6d1f7d67bc	6a376801-170d-4dd1-a676-747c79ecd5a1	Student A Cert	Test cert	TestOrg	\N	\N	2025	1	\N	\N	DRAFT	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:20:14.776305
e9d1b4c3-ad74-46dc-95d5-38259a93a74e	3caa152d-a7ce-4f86-bf13-2037b4e4879e	e0a4d971-42a0-4b6d-9511-714649eaca66	6a376801-170d-4dd1-a676-747c79ecd5a1	Approved Cert Test	\N	\N	\N	\N	2025	1	\N	\N	APPROVED	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:20:15.357622
9fae6824-4baf-4a3a-9208-605a6f617709	3caa152d-a7ce-4f86-bf13-2037b4e4879e	e0a4d971-42a0-4b6d-9511-714649eaca66	6a376801-170d-4dd1-a676-747c79ecd5a1	Pending Cert Test	\N	\N	\N	\N	2025	1	\N	\N	PENDING	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:20:15.365324
283af6be-fdca-4b2e-a19d-595343bb2405	14f17dc7-e135-4e2a-8877-58dca2c968f9	40b8b0f0-8f8a-4504-ab85-3e41d974f5ba	6a376801-170d-4dd1-a676-747c79ecd5a1	Student A Cert	Test cert	TestOrg	\N	\N	2025	1	\N	\N	DRAFT	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:21:55.78817
652950d7-47a7-4802-a123-2eabad6dd66a	0abbf1d1-be23-4415-a4cf-8822589fea34	8f3a7ba3-4394-4778-b390-5b43f1fa44b1	6a376801-170d-4dd1-a676-747c79ecd5a1	Approved Cert Test	\N	\N	\N	\N	2025	1	\N	\N	APPROVED	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:21:56.471188
be1b6a6b-bc76-4827-b285-ab3d72999536	0abbf1d1-be23-4415-a4cf-8822589fea34	8f3a7ba3-4394-4778-b390-5b43f1fa44b1	6a376801-170d-4dd1-a676-747c79ecd5a1	Pending Cert Test	\N	\N	\N	\N	2025	1	\N	\N	PENDING	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:21:56.486355
e0255834-bb0a-4170-9927-12663bc2bca6	d1e2d40f-c013-49c3-91d2-c544580aaf62	d829adc5-19d2-4474-b7ff-22884ee8be1a	6a376801-170d-4dd1-a676-747c79ecd5a1	Student A Cert	Test cert	TestOrg	\N	\N	2025	1	\N	\N	DRAFT	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:25:24.502645
a2117925-efa9-4310-a7d2-b7c37a885ba6	473e90ea-4841-452a-a1c5-8d43c44fa6c5	11080b39-be3e-4c21-bb51-bc83e6b53998	6a376801-170d-4dd1-a676-747c79ecd5a1	Approved Cert Test	\N	\N	\N	\N	2025	1	\N	\N	APPROVED	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:25:25.150925
966a9b5d-327d-4611-ac41-49b08bebbaef	473e90ea-4841-452a-a1c5-8d43c44fa6c5	11080b39-be3e-4c21-bb51-bc83e6b53998	6a376801-170d-4dd1-a676-747c79ecd5a1	Pending Cert Test	\N	\N	\N	\N	2025	1	\N	\N	PENDING	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:25:25.16428
aef7abf7-76c6-4c6a-8dcf-2f0840df5afd	f034d950-7d5c-4ef6-b664-375e2066b458	258b1705-9460-4337-871e-74d6a825e475	6a376801-170d-4dd1-a676-747c79ecd5a1	Student A Cert	Test cert	TestOrg	\N	\N	2025	1	\N	\N	DRAFT	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:27:28.646837
cf0c4b12-f3bf-4730-b3f8-f41e0a76aeb0	aa0cc309-8a20-4dc3-bd74-515e82353e9a	d37ae460-4f11-4467-a93f-476f3bc5d9dd	6a376801-170d-4dd1-a676-747c79ecd5a1	Approved Cert Test	\N	\N	\N	\N	2025	1	\N	\N	APPROVED	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:27:29.247758
82ab4e36-14f0-44d5-b73a-086d0679a036	aa0cc309-8a20-4dc3-bd74-515e82353e9a	d37ae460-4f11-4467-a93f-476f3bc5d9dd	6a376801-170d-4dd1-a676-747c79ecd5a1	Pending Cert Test	\N	\N	\N	\N	2025	1	\N	\N	PENDING	0	\N	\N	\N	\N	UNIQUE	0	2026-06-13 11:27:29.27141
\.


--
-- TOC entry 5396 (class 0 OID 50131)
-- Dependencies: 258
-- Data for Name: alumni_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alumni_records (id, student_id, department_id, graduation_year, outcome_type, company_name, role, university_name) FROM stdin;
\.


--
-- TOC entry 5370 (class 0 OID 49652)
-- Dependencies: 232
-- Data for Name: approval_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.approval_history (id, achievement_id, faculty_id, action, comments, action_date) FROM stdin;
\.


--
-- TOC entry 5382 (class 0 OID 49903)
-- Dependencies: 244
-- Data for Name: arrear_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.arrear_records (id, student_id, subject_id, attempt_number, status, cleared_date) FROM stdin;
\.


--
-- TOC entry 5369 (class 0 OID 49633)
-- Dependencies: 231
-- Data for Name: assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assignments (id, course_id, faculty_id, title, description, due_date) FROM stdin;
\.


--
-- TOC entry 5380 (class 0 OID 49856)
-- Dependencies: 242
-- Data for Name: attendance_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attendance_records (id, student_id, subject_id, month, total_classes, attended_classes, percentage) FROM stdin;
\.


--
-- TOC entry 5390 (class 0 OID 50040)
-- Dependencies: 252
-- Data for Name: career_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.career_profiles (id, student_id, career_readiness_score, category, preferred_role, snapshot_date) FROM stdin;
\.


--
-- TOC entry 5393 (class 0 OID 50084)
-- Dependencies: 255
-- Data for Name: career_roadmaps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.career_roadmaps (id, student_id, target_role, steps, created_at) FROM stdin;
\.


--
-- TOC entry 5373 (class 0 OID 49730)
-- Dependencies: 235
-- Data for Name: cgpa_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cgpa_records (id, student_id, cgpa, total_credits_earned, updated_at) FROM stdin;
\.


--
-- TOC entry 5402 (class 0 OID 50226)
-- Dependencies: 264
-- Data for Name: community_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.community_posts (id, author_id, department_id, post_type, title, content, created_at) FROM stdin;
\.


--
-- TOC entry 5364 (class 0 OID 49551)
-- Dependencies: 226
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses (id, code, name, department_id, credits) FROM stdin;
\.


--
-- TOC entry 5383 (class 0 OID 49925)
-- Dependencies: 245
-- Data for Name: department_health_index; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department_health_index (id, department_id, score, category, attendance_avg, cgpa_avg, arrears_avg, achievements_count, snapshot_date) FROM stdin;
\.


--
-- TOC entry 5367 (class 0 OID 49605)
-- Dependencies: 229
-- Data for Name: department_rankings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department_rankings (id, department_id, academic_year, total_certificates, total_internships, total_projects, total_research_papers, total_hackathons, department_score, ranking, calculated_at) FROM stdin;
\.


--
-- TOC entry 5358 (class 0 OID 49447)
-- Dependencies: 220
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departments (id, name, institute_id, hod_id) FROM stdin;
4d6a5eee-7226-445a-a6aa-5135f8887140	Computer Science	6e91aae8-6a9b-4b38-9476-68d92319dba3	\N
58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	Information Technology	6e91aae8-6a9b-4b38-9476-68d92319dba3	\N
f945b515-a537-4ab1-a1da-7cd72141897c	Artificial Intelligence	6e91aae8-6a9b-4b38-9476-68d92319dba3	\N
72958370-78e8-4805-bbff-c8db9847d6e1	Computer Science	4df602f6-6142-477d-9245-8ae40c49cff2	\N
bff398ef-9c99-4658-be03-0eabfdf6f9c4	Information Technology	4df602f6-6142-477d-9245-8ae40c49cff2	\N
120a02b3-2ce1-4dc2-ab15-0dcddfb18269	Artificial Intelligence	4df602f6-6142-477d-9245-8ae40c49cff2	\N
cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	Computer Science	80316235-f21b-4f82-a851-487072b121f5	\N
2ce3c25a-620d-49cb-89f8-ca0a049be905	Information Technology	80316235-f21b-4f82-a851-487072b121f5	\N
9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	Artificial Intelligence	80316235-f21b-4f82-a851-487072b121f5	\N
30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	Computer Science	f3b59378-7b08-40bd-a9fe-91a059905162	\N
465f3c25-3d78-470c-8a36-522aa9ec11cf	Information Technology	f3b59378-7b08-40bd-a9fe-91a059905162	\N
7a673248-c5c5-4e2c-b415-87a23736d1c7	Artificial Intelligence	f3b59378-7b08-40bd-a9fe-91a059905162	\N
2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	Computer Science	eed783f7-1785-48a2-bdb3-93f2fde91448	\N
86d13a7e-9125-4d91-828c-9cca4d31bace	Information Technology	eed783f7-1785-48a2-bdb3-93f2fde91448	\N
a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	Artificial Intelligence	eed783f7-1785-48a2-bdb3-93f2fde91448	\N
c7ae4601-26af-4a7b-b93a-74a6c994dc09	Computer Science	142022a4-9b55-4ddb-b862-01d4abf2d67d	\N
ea6eef8e-8870-41e6-af5c-9d0dd4eea549	Information Technology	142022a4-9b55-4ddb-b862-01d4abf2d67d	\N
70cc658f-2433-455a-a096-c6a6e8549fb2	Artificial Intelligence	142022a4-9b55-4ddb-b862-01d4abf2d67d	\N
941f8b93-1c5f-46f2-a4b0-4df5537f6983	Computer Science	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	\N
13d08e92-605e-4739-a74b-9da33dc59ce6	Information Technology	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	\N
0b2efd4d-fd66-494c-a123-f5758c8ab00c	Artificial Intelligence	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	\N
6c90a654-3c45-4796-a5d4-c782847f8772	Computer Science	7c8c170e-b150-4932-b395-4d0a8916ecc1	\N
7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	Information Technology	7c8c170e-b150-4932-b395-4d0a8916ecc1	\N
623199a1-43e1-446a-97ba-986da1f89a12	Artificial Intelligence	7c8c170e-b150-4932-b395-4d0a8916ecc1	\N
5f7d1ec2-9b4f-4691-ad42-1be59e3d4311	Civil Engineering	6e91aae8-6a9b-4b38-9476-68d92319dba3	\N
7ddef2d1-50b1-4d9d-b1ea-9cd3b474a755	Information Technology	01271020-47de-4363-b636-90de3b81e1b7	\N
f9c9aba0-29e9-4670-8b26-2258b5677622	Computer Science Engineering	01271020-47de-4363-b636-90de3b81e1b7	\N
1026a0b1-beaf-4513-b31d-945181bcfa07	Computer Science	fe4b4e54-a0f2-48a5-b892-c6e7493f51b0	\N
f9b03b4d-5b7f-4726-8c74-290ee896c008	Computer Science	761aee8c-a780-4c2c-9a1b-5f023d462faf	\N
0ab92ffa-cf85-43c5-9b36-68d2bf5f5d85	Computer Science	062db039-8d65-46c6-90c9-d8289161cfc8	\N
03df13aa-b840-4fba-8461-7278d7669f21	Computer Science	24fc2ee9-6703-4951-8ea9-e3b1182ca44c	\N
6c7860ff-99ac-4d0c-a209-7e45cdd89686	Computer Science	dfc1c660-a09f-42dd-9b91-4902c94c9d96	\N
56f6d369-d0b4-416b-b7a9-f0dc751cf3b5	Computer Science	a927a4ff-be99-4f50-b491-91cc7d6e0149	\N
67556692-ca7d-463d-9a43-54df33af1d5b	Computer Science	191e8c3f-625f-450a-aa78-e4095f350777	\N
5dfa0623-6eea-473d-a331-e5a97f969fd0	Computer Science	ef7447bc-527d-4ed9-9080-50355693aac6	\N
d71823d2-033e-46da-a1c5-12c20bafa4f4	Computer Science	255a2637-cb94-438c-b8e8-fd60009f8c27	\N
de6a08fb-3018-422d-b384-6e7dff4af315	Computer Science	692766ee-e05c-4e85-9e44-eb4bc294de58	\N
a5d619a0-b481-4e5b-988d-85589dd6168c	Computer Science	23b93d67-f127-4090-8fa3-0be5424bde3f	\N
ba66490c-4ec3-4181-b0ce-6a3342d0366a	Computer Science	fa0c6b00-2726-4c92-9a5a-4678a2f01360	\N
4e955f10-3c93-4f07-b325-0cab11aa0493	Computer Science	fa944855-fb86-4dc0-b620-985d3879b397	\N
027632d1-3166-4cd3-8463-7e03ae68e534	Computer Science	e80c3426-bf6e-4d35-b542-057a5431af4e	\N
7a920d00-8293-4558-9c43-04ca5f295124	Computer Science	10bf5956-4b74-4f97-922f-eaf3e08ed61c	\N
16c76429-22e0-412f-9272-3123c66dbe5a	Computer Science	7ebb6692-da05-4029-ae4d-96868a97ef3d	\N
42ae23c2-47db-4929-ac14-62b026bd019f	Computer Science	b2e4b0c0-9ba7-4ebb-b244-cc46e1aa565d	\N
8291d7ed-0e7c-4267-9ba8-4189816219fc	Computer Science	d9972968-7dda-4e07-8653-cf9975ffef3f	\N
bc5b07bf-96b1-4e0e-b711-0a6d1f7d67bc	Computer Science	6b718a1a-93f2-4cf9-9b72-5aec60b9ca15	\N
e0a4d971-42a0-4b6d-9511-714649eaca66	Computer Science	e39b03c6-619b-43ba-ad77-3bb86545928a	\N
40b8b0f0-8f8a-4504-ab85-3e41d974f5ba	Computer Science	3a7ce12a-24bb-4f4d-8c44-243c061e111f	\N
8f3a7ba3-4394-4778-b390-5b43f1fa44b1	Computer Science	8f785b96-29ff-49a1-bf73-7ea87eaeee34	\N
d829adc5-19d2-4474-b7ff-22884ee8be1a	Computer Science	782eb45b-10fc-4920-910d-6c3f3285d540	\N
11080b39-be3e-4c21-bb51-bc83e6b53998	Computer Science	36451365-c35b-4873-8af4-0d3c41de8bd1	\N
258b1705-9460-4337-871e-74d6a825e475	Computer Science	f7776757-407e-40c7-9b79-730356fee2bd	\N
d37ae460-4f11-4467-a93f-476f3bc5d9dd	Computer Science	2005b30f-c1b4-47d4-b144-7ac707457da0	\N
\.


--
-- TOC entry 5368 (class 0 OID 49616)
-- Dependencies: 230
-- Data for Name: enrollments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollments (student_id, course_id, semester) FROM stdin;
\.


--
-- TOC entry 5384 (class 0 OID 49941)
-- Dependencies: 246
-- Data for Name: faculty_impact_index; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculty_impact_index (id, faculty_id, score, category, mentoring_score, student_growth_score, snapshot_date) FROM stdin;
\.


--
-- TOC entry 5362 (class 0 OID 49511)
-- Dependencies: 224
-- Data for Name: faculty_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculty_profiles (user_id, employee_id, department_id, profile_photo_url, qualification, experience, research_papers_count, research_areas, biography) FROM stdin;
d945cb55-c4c3-4c1c-bdc1-e3f0627612d6	EMPKIT001	f945b515-a537-4ab1-a1da-7cd72141897c	\N	\N	\N	0	\N	\N
c5fb80c0-4385-41ee-b379-56285f0231e4	EMPKIT002	f945b515-a537-4ab1-a1da-7cd72141897c	\N	\N	\N	0	\N	\N
018ca201-4cf8-4c1b-a576-eee330e1c84a	EMPKIT003	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	\N	\N	\N	0	\N	\N
d6e84c53-e80b-45ff-a1fd-d7ec87f9d04e	EMPKIT004	f945b515-a537-4ab1-a1da-7cd72141897c	\N	\N	\N	0	\N	\N
797c9a73-e0b6-4f52-baa6-688d8ec72c4c	EMPKIT005	f945b515-a537-4ab1-a1da-7cd72141897c	\N	\N	\N	0	\N	\N
438b9aa9-39b3-4ee4-bf1d-20d3b79ebd05	EMPKIT006	4d6a5eee-7226-445a-a6aa-5135f8887140	\N	\N	\N	0	\N	\N
a7e412a2-34c1-46cb-86c1-0b36bb40c16e	EMPKIT007	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	\N	\N	\N	0	\N	\N
64231fe6-e91b-43fa-8d7b-060d4bfbb6ee	EMPKIT008	4d6a5eee-7226-445a-a6aa-5135f8887140	\N	\N	\N	0	\N	\N
b6c16b09-9a2e-40ba-864f-628dccd6ccaf	EMPKIT009	4d6a5eee-7226-445a-a6aa-5135f8887140	\N	\N	\N	0	\N	\N
6cc4a9ec-53ce-4554-a986-8ea49a40da86	EMPKIT010	f945b515-a537-4ab1-a1da-7cd72141897c	\N	\N	\N	0	\N	\N
ee78621b-47ee-4339-b469-e33c89aff3b0	EMPKIT011	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	\N	\N	\N	0	\N	\N
4a595638-db48-4eac-9d53-9b3b82c2d110	EMPKIT012	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	\N	\N	\N	0	\N	\N
b44c561d-fc89-413a-a012-7abd1230e4f6	EMPKIT013	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	\N	\N	\N	0	\N	\N
4382df8c-2f5a-4912-a3f8-432aaf31890d	EMPKIT014	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	\N	\N	\N	0	\N	\N
cf03e4cf-6353-451c-be5a-b6c950a9c23f	EMPKIT015	4d6a5eee-7226-445a-a6aa-5135f8887140	\N	\N	\N	0	\N	\N
afb10696-4ac0-4a44-894e-8eae828b590a	EMPKIT016	f945b515-a537-4ab1-a1da-7cd72141897c	\N	\N	\N	0	\N	\N
a1ece2ea-3c16-4608-add5-e807e4e1652d	EMPKIT017	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	\N	\N	\N	0	\N	\N
ed4430aa-571b-44cb-9f0a-15a5fe2fa2eb	EMPKIT018	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	\N	\N	\N	0	\N	\N
3a568bf8-343a-436c-a227-a74dbb8dbe44	EMPKIT019	f945b515-a537-4ab1-a1da-7cd72141897c	\N	\N	\N	0	\N	\N
358f1276-39e0-4ad6-98cb-6fee214df9aa	EMPKIT020	4d6a5eee-7226-445a-a6aa-5135f8887140	\N	\N	\N	0	\N	\N
ff737f31-ba81-4efb-ab48-04255f74c0b6	EMPSRM001	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	\N	\N	\N	0	\N	\N
25766653-8bb5-4cb3-a15f-95431b8f9fb5	EMPSRM002	72958370-78e8-4805-bbff-c8db9847d6e1	\N	\N	\N	0	\N	\N
73d91822-6bb0-4769-8ab9-acf74112282e	EMPSRM003	72958370-78e8-4805-bbff-c8db9847d6e1	\N	\N	\N	0	\N	\N
478d0ef0-3979-474a-b181-1c0b95670f75	EMPSRM004	72958370-78e8-4805-bbff-c8db9847d6e1	\N	\N	\N	0	\N	\N
081cbc26-3e8a-4865-9880-d525cfe6471e	EMPSRM005	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	\N	\N	\N	0	\N	\N
37be8732-9def-4b0d-b3c7-737017b724bb	EMPSRM006	bff398ef-9c99-4658-be03-0eabfdf6f9c4	\N	\N	\N	0	\N	\N
cf050f19-9fbc-4db4-b53e-5680d36a41e0	EMPSRM007	bff398ef-9c99-4658-be03-0eabfdf6f9c4	\N	\N	\N	0	\N	\N
9228c986-2cf4-4a1f-80c4-5393ff1fb917	EMPSRM008	72958370-78e8-4805-bbff-c8db9847d6e1	\N	\N	\N	0	\N	\N
5a500067-a553-42c9-97c0-4de9152c5cdd	EMPSRM009	72958370-78e8-4805-bbff-c8db9847d6e1	\N	\N	\N	0	\N	\N
988a63f6-2f13-46e9-b343-3cfaeac106e4	EMPSRM010	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	\N	\N	\N	0	\N	\N
e023565f-6cac-4f76-b9ad-1b7f60106688	EMPSRM011	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	\N	\N	\N	0	\N	\N
f2726a9a-b263-4834-af6a-c804fc8f6e37	EMPSRM012	bff398ef-9c99-4658-be03-0eabfdf6f9c4	\N	\N	\N	0	\N	\N
69ebc9f2-0fc9-40a6-95a5-c85607cbc3c5	EMPSRM013	bff398ef-9c99-4658-be03-0eabfdf6f9c4	\N	\N	\N	0	\N	\N
d84d85e4-7ad8-400a-afed-69f0b7b9c46f	EMPSRM014	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	\N	\N	\N	0	\N	\N
d40b98a4-bd3b-4720-a40b-c988fa18c65d	EMPSRM015	72958370-78e8-4805-bbff-c8db9847d6e1	\N	\N	\N	0	\N	\N
41ef9f4f-14af-4027-99e8-7cfdddb7459b	EMPSRM016	bff398ef-9c99-4658-be03-0eabfdf6f9c4	\N	\N	\N	0	\N	\N
9554fc5c-a083-471c-b1dd-6b852df92a35	EMPSRM017	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	\N	\N	\N	0	\N	\N
134c8195-028f-4392-8bcb-64fe1bafde9b	EMPSRM018	bff398ef-9c99-4658-be03-0eabfdf6f9c4	\N	\N	\N	0	\N	\N
18e53602-bdd3-4b5e-94ed-56a0553b95fd	EMPSRM019	bff398ef-9c99-4658-be03-0eabfdf6f9c4	\N	\N	\N	0	\N	\N
91f2a192-96af-4566-bd2c-6f400306258a	EMPSRM020	72958370-78e8-4805-bbff-c8db9847d6e1	\N	\N	\N	0	\N	\N
ec7dc995-3327-49be-8b82-b8b2e2ea690d	EMPREC001	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	\N	\N	\N	0	\N	\N
50fbeae0-5407-4d20-9418-e97ef10cec81	EMPREC002	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	\N	\N	\N	0	\N	\N
8fbdc1bd-0de5-4587-ac95-c3de6b6fd80d	EMPREC003	2ce3c25a-620d-49cb-89f8-ca0a049be905	\N	\N	\N	0	\N	\N
b12f0510-f50d-4e56-8b1b-e5c3c83f88a3	EMPREC004	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	\N	\N	\N	0	\N	\N
65902115-1979-4b00-8325-1073f17bfd7e	EMPREC005	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	\N	\N	\N	0	\N	\N
120974f9-2732-46b1-ad5b-6b35269e2b3b	EMPREC006	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	\N	\N	\N	0	\N	\N
900725e4-fb16-465c-80e2-9eb84d214130	EMPREC007	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	\N	\N	\N	0	\N	\N
35a72d9d-4d14-4f25-ad79-afce7869fa1f	EMPREC008	2ce3c25a-620d-49cb-89f8-ca0a049be905	\N	\N	\N	0	\N	\N
d7affde7-452a-482f-ba18-56c283f5589b	EMPREC009	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	\N	\N	\N	0	\N	\N
5c619fef-ca56-46c5-824f-83dc4a1aa6c8	EMPREC010	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	\N	\N	\N	0	\N	\N
ed56f9c9-bc01-4edd-a9bc-cd27d007146c	EMPREC011	2ce3c25a-620d-49cb-89f8-ca0a049be905	\N	\N	\N	0	\N	\N
e0435499-11d8-4732-bd82-0e5e6b6c0aa9	EMPREC012	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	\N	\N	\N	0	\N	\N
9c4f8ec6-54d9-40b7-918d-ef1d8e060fc5	EMPREC013	2ce3c25a-620d-49cb-89f8-ca0a049be905	\N	\N	\N	0	\N	\N
9df2690f-9857-4326-a204-c998133627d4	EMPREC014	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	\N	\N	\N	0	\N	\N
921268e1-465d-42ac-99a0-c043a4e1bee8	EMPREC015	2ce3c25a-620d-49cb-89f8-ca0a049be905	\N	\N	\N	0	\N	\N
2b0965be-4ba8-436c-b2bc-52c6128ca86e	EMPREC016	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	\N	\N	\N	0	\N	\N
95dbbab9-cefd-4614-a59d-c5e97a884eaa	EMPREC017	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	\N	\N	\N	0	\N	\N
d611f17b-a0aa-4f64-a40e-a14537f89bf9	EMPREC018	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	\N	\N	\N	0	\N	\N
9878941d-4272-477c-a1e5-3989816877d2	EMPREC019	2ce3c25a-620d-49cb-89f8-ca0a049be905	\N	\N	\N	0	\N	\N
ccf1aa68-7b7b-4209-95a2-b5bbd8995d88	EMPREC020	2ce3c25a-620d-49cb-89f8-ca0a049be905	\N	\N	\N	0	\N	\N
6525ef81-09b9-4000-a046-b888ee9d7fc7	EMPPSG001	465f3c25-3d78-470c-8a36-522aa9ec11cf	\N	\N	\N	0	\N	\N
370c3ddc-333e-4b74-9146-54e9e5bfe73b	EMPPSG002	7a673248-c5c5-4e2c-b415-87a23736d1c7	\N	\N	\N	0	\N	\N
7a7e2e74-0530-4a6a-90ef-f6e94ff1af19	EMPPSG003	7a673248-c5c5-4e2c-b415-87a23736d1c7	\N	\N	\N	0	\N	\N
c9b67b03-9261-4d5f-b4fc-00d2776cca06	EMPPSG004	7a673248-c5c5-4e2c-b415-87a23736d1c7	\N	\N	\N	0	\N	\N
6d9ac216-04f6-4db5-b1fe-6b0ff5f534d5	EMPPSG005	465f3c25-3d78-470c-8a36-522aa9ec11cf	\N	\N	\N	0	\N	\N
0fdd91c6-095c-4057-a1f5-d92a3d448fbb	EMPPSG006	7a673248-c5c5-4e2c-b415-87a23736d1c7	\N	\N	\N	0	\N	\N
aed84f32-4983-42e9-88d6-2c60f87e1c53	EMPPSG007	7a673248-c5c5-4e2c-b415-87a23736d1c7	\N	\N	\N	0	\N	\N
625c3045-78ff-4043-94e2-f85acc022ceb	EMPPSG008	465f3c25-3d78-470c-8a36-522aa9ec11cf	\N	\N	\N	0	\N	\N
16406945-3878-4378-95db-59e25607f1e0	EMPPSG009	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	\N	\N	\N	0	\N	\N
d073343b-0487-44d0-b973-4aac14301ae7	EMPPSG010	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	\N	\N	\N	0	\N	\N
c43884db-2d9f-41f8-9fa1-7bcde08ea780	EMPPSG011	7a673248-c5c5-4e2c-b415-87a23736d1c7	\N	\N	\N	0	\N	\N
51d56913-4592-4a74-80b8-953e3780f04c	EMPPSG012	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	\N	\N	\N	0	\N	\N
4dff792e-56c7-44c2-a85c-9b2d69737f8d	EMPPSG013	465f3c25-3d78-470c-8a36-522aa9ec11cf	\N	\N	\N	0	\N	\N
b3b33b6c-dfdf-45ed-89ac-56f64ed7c3f3	EMPPSG014	7a673248-c5c5-4e2c-b415-87a23736d1c7	\N	\N	\N	0	\N	\N
7888be9a-22c2-4f69-9492-90eff8bcaff4	EMPPSG015	465f3c25-3d78-470c-8a36-522aa9ec11cf	\N	\N	\N	0	\N	\N
f4a762a1-a756-49bf-987d-2786db7902fc	EMPPSG016	7a673248-c5c5-4e2c-b415-87a23736d1c7	\N	\N	\N	0	\N	\N
9b7d471b-337e-4486-ac75-8badcd1f0cc5	EMPPSG017	7a673248-c5c5-4e2c-b415-87a23736d1c7	\N	\N	\N	0	\N	\N
6acd19f7-3141-4487-8072-0c4313048238	EMPPSG018	7a673248-c5c5-4e2c-b415-87a23736d1c7	\N	\N	\N	0	\N	\N
71985b08-5476-45c2-ac6c-ac3eb3302935	EMPPSG019	465f3c25-3d78-470c-8a36-522aa9ec11cf	\N	\N	\N	0	\N	\N
a71d9900-cdf2-4d5d-8870-2540ae2349a9	EMPPSG020	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	\N	\N	\N	0	\N	\N
95cbb2d5-fb1d-4697-8881-264243d44927	EMPSSN001	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	\N	\N	\N	0	\N	\N
a8f899d7-9a3f-4c82-bceb-cefea8da4d23	EMPSSN002	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	\N	\N	\N	0	\N	\N
fd9c14e2-6b61-46c9-85a6-c55f533a6cb8	EMPSSN003	86d13a7e-9125-4d91-828c-9cca4d31bace	\N	\N	\N	0	\N	\N
5209baa7-28bd-4d33-bc02-b3f3dd59f71f	EMPSSN004	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	\N	\N	\N	0	\N	\N
0b0cee44-6401-4f79-96d1-1f51e8cc132f	EMPSSN005	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	\N	\N	\N	0	\N	\N
46c69628-005b-4d3e-933e-6563db97a16e	EMPSSN006	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	\N	\N	\N	0	\N	\N
02f9621f-f810-404d-9ecf-3d62549e9be2	EMPSSN007	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	\N	\N	\N	0	\N	\N
b32bc62b-1df3-4c7c-8663-8556df825a93	EMPSSN008	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	\N	\N	\N	0	\N	\N
28f913a1-1721-4040-b75a-a4454ef3268b	EMPSSN009	86d13a7e-9125-4d91-828c-9cca4d31bace	\N	\N	\N	0	\N	\N
b63d9346-43e6-47a0-b7e7-dc6e5a062528	EMPSSN010	86d13a7e-9125-4d91-828c-9cca4d31bace	\N	\N	\N	0	\N	\N
cdfd03ec-b86f-4fdc-9545-589a1dd38e6a	EMPSSN011	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	\N	\N	\N	0	\N	\N
9c3c6feb-6cd3-4278-9ef8-48cdc6252d6e	EMPSSN012	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	\N	\N	\N	0	\N	\N
ee7443d1-2af4-4e8a-a2c4-077770a804fc	EMPSSN013	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	\N	\N	\N	0	\N	\N
c9b1ad24-0f39-4373-abd1-4accf0285e88	EMPSSN014	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	\N	\N	\N	0	\N	\N
30674af4-b99d-4224-95a3-224ef4f3b908	EMPSSN015	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	\N	\N	\N	0	\N	\N
ec4c432f-1a2d-471d-8eec-de1109cea984	EMPSSN016	86d13a7e-9125-4d91-828c-9cca4d31bace	\N	\N	\N	0	\N	\N
edb8b7cf-06b6-4b46-b294-da57c2a04c47	EMPSSN017	86d13a7e-9125-4d91-828c-9cca4d31bace	\N	\N	\N	0	\N	\N
a4e5c26f-cec7-40d2-af91-e85f78fe786e	EMPSSN018	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	\N	\N	\N	0	\N	\N
b2e0b191-8940-4c11-8c45-73bc8982b77e	EMPSSN019	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	\N	\N	\N	0	\N	\N
7464c4ab-5300-4e1a-8387-99cfb66f8cb6	EMPSSN020	86d13a7e-9125-4d91-828c-9cca4d31bace	\N	\N	\N	0	\N	\N
278c10a1-ab7a-421e-9d64-632253d2ca86	EMPVIT001	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	\N	\N	\N	0	\N	\N
00a68344-4ae0-4cfd-ad6b-81811a8b7f18	EMPVIT002	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	\N	\N	\N	0	\N	\N
a42e71f9-1e90-4cc2-81c4-1c1184ffccf4	EMPVIT003	c7ae4601-26af-4a7b-b93a-74a6c994dc09	\N	\N	\N	0	\N	\N
66ba7e11-14ee-43d9-acf7-5c640a62be27	EMPVIT004	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	\N	\N	\N	0	\N	\N
5ccc0f45-a8dc-4aa4-bad5-95810b921e03	EMPVIT005	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	\N	\N	\N	0	\N	\N
8c74d6c7-2a8f-4723-8134-d269b411b286	EMPVIT006	c7ae4601-26af-4a7b-b93a-74a6c994dc09	\N	\N	\N	0	\N	\N
8d1cdcf9-c0b5-47c9-8c37-98b45373d025	EMPVIT007	c7ae4601-26af-4a7b-b93a-74a6c994dc09	\N	\N	\N	0	\N	\N
3c8de4ab-6b56-4431-8a42-a8c9127a7400	EMPVIT008	c7ae4601-26af-4a7b-b93a-74a6c994dc09	\N	\N	\N	0	\N	\N
a1b0b349-e690-4a53-87d5-9da8b9241569	EMPVIT009	c7ae4601-26af-4a7b-b93a-74a6c994dc09	\N	\N	\N	0	\N	\N
571ecbe1-44a2-482f-b01b-94135f6217e4	EMPVIT010	70cc658f-2433-455a-a096-c6a6e8549fb2	\N	\N	\N	0	\N	\N
6eb8e6b8-da8d-4e40-88b0-00a2c6d2cccc	EMPVIT011	c7ae4601-26af-4a7b-b93a-74a6c994dc09	\N	\N	\N	0	\N	\N
97c3a8e7-839f-4a76-990b-5672f43d9f3c	EMPVIT012	70cc658f-2433-455a-a096-c6a6e8549fb2	\N	\N	\N	0	\N	\N
10a27953-6269-478e-9053-97cf076ca514	EMPVIT013	70cc658f-2433-455a-a096-c6a6e8549fb2	\N	\N	\N	0	\N	\N
51a535de-f0bf-413a-bbf0-8962625b610b	EMPVIT014	70cc658f-2433-455a-a096-c6a6e8549fb2	\N	\N	\N	0	\N	\N
ba86f77a-4fed-41a1-b209-32969425869c	EMPVIT015	c7ae4601-26af-4a7b-b93a-74a6c994dc09	\N	\N	\N	0	\N	\N
7c1e139a-c932-481f-be55-cab2c6f9f3aa	EMPVIT016	70cc658f-2433-455a-a096-c6a6e8549fb2	\N	\N	\N	0	\N	\N
850b8578-7348-48d0-adb6-1cd6ea4e0747	EMPVIT017	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	\N	\N	\N	0	\N	\N
95e8a58c-c7bb-4670-9c1a-98548c58c79b	EMPVIT018	c7ae4601-26af-4a7b-b93a-74a6c994dc09	\N	\N	\N	0	\N	\N
ef32be91-a1b1-4db7-8a1e-3786f444d760	EMPVIT019	c7ae4601-26af-4a7b-b93a-74a6c994dc09	\N	\N	\N	0	\N	\N
14001f46-164a-43ce-b31c-69edfce2ead3	EMPVIT020	c7ae4601-26af-4a7b-b93a-74a6c994dc09	\N	\N	\N	0	\N	\N
35e82c69-35c2-42df-a58f-4ed2c0beeb4c	EMPAU001	0b2efd4d-fd66-494c-a123-f5758c8ab00c	\N	\N	\N	0	\N	\N
b5086141-15d2-4c9a-ad36-1f6d72c644d1	EMPAU002	941f8b93-1c5f-46f2-a4b0-4df5537f6983	\N	\N	\N	0	\N	\N
113ab573-7e12-4f5d-92e1-4e1fba18d20b	EMPAU003	13d08e92-605e-4739-a74b-9da33dc59ce6	\N	\N	\N	0	\N	\N
680bc756-a4a7-457d-95d1-f151b6995665	EMPAU004	941f8b93-1c5f-46f2-a4b0-4df5537f6983	\N	\N	\N	0	\N	\N
82cc0f31-e120-4f70-9293-5e391b6fdc28	EMPAU005	941f8b93-1c5f-46f2-a4b0-4df5537f6983	\N	\N	\N	0	\N	\N
4b2d4b61-9b32-455c-bc24-a136d23c2f56	EMPAU006	13d08e92-605e-4739-a74b-9da33dc59ce6	\N	\N	\N	0	\N	\N
daaf53c1-1782-49db-a583-e8f7342a2fcb	EMPAU007	13d08e92-605e-4739-a74b-9da33dc59ce6	\N	\N	\N	0	\N	\N
5c3785e8-f022-454b-8d2e-5eaba53c847b	EMPAU008	0b2efd4d-fd66-494c-a123-f5758c8ab00c	\N	\N	\N	0	\N	\N
5625a2f4-8e90-471f-9e6c-834cedf04a99	EMPAU009	0b2efd4d-fd66-494c-a123-f5758c8ab00c	\N	\N	\N	0	\N	\N
7dbf2d73-6957-46a5-8649-c69fbcc5a838	EMPAU010	0b2efd4d-fd66-494c-a123-f5758c8ab00c	\N	\N	\N	0	\N	\N
cb7e245f-e0d5-4317-b47b-0ea2e49424c3	EMPAU011	13d08e92-605e-4739-a74b-9da33dc59ce6	\N	\N	\N	0	\N	\N
1113251d-ab4b-4441-9510-ed161b4df79e	EMPAU012	0b2efd4d-fd66-494c-a123-f5758c8ab00c	\N	\N	\N	0	\N	\N
b561f271-d763-41ce-aadf-441e3eb47510	EMPAU013	941f8b93-1c5f-46f2-a4b0-4df5537f6983	\N	\N	\N	0	\N	\N
65efe612-317f-484c-9889-1afd3cf176d9	EMPAU014	941f8b93-1c5f-46f2-a4b0-4df5537f6983	\N	\N	\N	0	\N	\N
60ed70b3-233f-4f5c-aee2-c04fdefd1bc1	EMPAU015	941f8b93-1c5f-46f2-a4b0-4df5537f6983	\N	\N	\N	0	\N	\N
baafec5b-7de3-41bd-b15e-c1b46166f78c	EMPAU016	941f8b93-1c5f-46f2-a4b0-4df5537f6983	\N	\N	\N	0	\N	\N
a1785aa0-808d-46fd-85b9-e433f50bea38	EMPAU017	13d08e92-605e-4739-a74b-9da33dc59ce6	\N	\N	\N	0	\N	\N
b6bd6759-bb30-45ef-95d7-4bccb3918ba1	EMPAU018	941f8b93-1c5f-46f2-a4b0-4df5537f6983	\N	\N	\N	0	\N	\N
969ea4f6-3ea6-4a2f-94a2-2013269c4f03	EMPAU019	13d08e92-605e-4739-a74b-9da33dc59ce6	\N	\N	\N	0	\N	\N
fa306c1d-1af4-4f96-ba59-61ce4f4b5dda	EMPAU020	13d08e92-605e-4739-a74b-9da33dc59ce6	\N	\N	\N	0	\N	\N
189ca404-634a-4337-8ffd-4986d4e4016f	EMPMIT001	6c90a654-3c45-4796-a5d4-c782847f8772	\N	\N	\N	0	\N	\N
65797348-3299-4c52-8b31-d7c1885e5ede	EMPMIT002	623199a1-43e1-446a-97ba-986da1f89a12	\N	\N	\N	0	\N	\N
9af45fac-8c98-4251-ad11-9da7cd7130ec	EMPMIT003	623199a1-43e1-446a-97ba-986da1f89a12	\N	\N	\N	0	\N	\N
609872c4-928a-4211-90dd-7296502d6d64	EMPMIT004	6c90a654-3c45-4796-a5d4-c782847f8772	\N	\N	\N	0	\N	\N
54e30e6c-8e71-4bda-9728-4a5719ec3704	EMPMIT005	6c90a654-3c45-4796-a5d4-c782847f8772	\N	\N	\N	0	\N	\N
ef7c206c-ef82-4442-8d4c-06a47561f7f6	EMPMIT006	623199a1-43e1-446a-97ba-986da1f89a12	\N	\N	\N	0	\N	\N
817fd8bb-3649-4cad-a138-bbc33b9f8168	EMPMIT007	623199a1-43e1-446a-97ba-986da1f89a12	\N	\N	\N	0	\N	\N
4a3abbc7-11f2-4f18-ace9-044de8d042a3	EMPMIT008	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	\N	\N	\N	0	\N	\N
8f5010b1-dc20-4d9a-89f5-682f7823a731	EMPMIT009	623199a1-43e1-446a-97ba-986da1f89a12	\N	\N	\N	0	\N	\N
1cdd0888-1e0b-45c2-90c9-ad8a2baa1829	EMPMIT010	6c90a654-3c45-4796-a5d4-c782847f8772	\N	\N	\N	0	\N	\N
d06043c3-5d0b-4b1f-a80f-1a1e410496b8	EMPMIT011	623199a1-43e1-446a-97ba-986da1f89a12	\N	\N	\N	0	\N	\N
a73b36f0-ae0b-46e0-a291-c5783aaf90af	EMPMIT012	6c90a654-3c45-4796-a5d4-c782847f8772	\N	\N	\N	0	\N	\N
640ca562-cdac-4881-bc03-de9ab22d9dc1	EMPMIT013	6c90a654-3c45-4796-a5d4-c782847f8772	\N	\N	\N	0	\N	\N
d789c4fe-260e-4abb-9b36-3cf3edc932fc	EMPMIT014	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	\N	\N	\N	0	\N	\N
bb70a838-bdfd-4449-8d93-a01ece7c9813	EMPMIT015	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	\N	\N	\N	0	\N	\N
546c147d-2213-429a-9040-4ff4e81332ff	EMPMIT016	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	\N	\N	\N	0	\N	\N
cda5b176-3be1-4e28-8224-cd6221a81cab	EMPMIT017	6c90a654-3c45-4796-a5d4-c782847f8772	\N	\N	\N	0	\N	\N
5cc63dd2-de9d-4f75-806b-e64642cf8455	EMPMIT018	623199a1-43e1-446a-97ba-986da1f89a12	\N	\N	\N	0	\N	\N
b6957d55-4b7e-4408-8683-e4a5a978168f	EMPMIT019	6c90a654-3c45-4796-a5d4-c782847f8772	\N	\N	\N	0	\N	\N
c31ce07e-64a4-4244-84c9-92f288057137	EMPMIT020	623199a1-43e1-446a-97ba-986da1f89a12	\N	\N	\N	0	\N	\N
\.


--
-- TOC entry 5378 (class 0 OID 49818)
-- Dependencies: 240
-- Data for Name: gpa_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gpa_records (id, student_id, semester_id, gpa, credits_earned) FROM stdin;
\.


--
-- TOC entry 5357 (class 0 OID 49433)
-- Dependencies: 219
-- Data for Name: institutes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.institutes (id, institute_id, name, total_faculty, total_students, domain) FROM stdin;
6e91aae8-6a9b-4b38-9476-68d92319dba3	4e3ed073-ce01-4bea-9b90-77bb988cea10	Karpagam Institute of Technology	20	50	karpagamtech.ac.in
4df602f6-6142-477d-9245-8ae40c49cff2	694ce39e-8180-40e8-a7ff-a82039a9504d	SRM Institute of Science and Technology	20	50	srmist.edu.in
80316235-f21b-4f82-a851-487072b121f5	e89a7767-3595-450a-8439-9e056716675f	Rajalakshmi Engineering College	20	50	rajalakshmi.edu.in
f3b59378-7b08-40bd-a9fe-91a059905162	71115a84-89e8-4af9-88e1-a5a7b2bd8d3d	PSG College of Technology	20	50	psgtech.edu
eed783f7-1785-48a2-bdb3-93f2fde91448	107c5abe-f3ab-410f-b817-40419439e632	SSN College of Engineering	20	50	ssn.edu.in
142022a4-9b55-4ddb-b862-01d4abf2d67d	9444a521-692f-468c-8565-62c8a14e9d87	Vellore Institute of Technology	20	50	vit.ac.in
9db6c998-603a-4f6f-a6e7-44e4cf00d8be	1ae1bc8b-56d2-41ea-a024-d7452d1ccafb	Anna University	20	50	annauniv.edu
7c8c170e-b150-4932-b395-4d0a8916ecc1	bf3bb456-e638-4885-89ad-f16a08d80522	Madras Institute of Technology	20	50	mitindia.edu
01271020-47de-4363-b636-90de3b81e1b7	6d400a32-f51c-48c9-814a-dc89b6a24711	Panimalar College of Engineering	10	50	panimalar.edu.in
fe4b4e54-a0f2-48a5-b892-c6e7493f51b0	f81330fd-90a4-4f5c-a5e0-4c12c559bc0b	Test Institute	10	100	testfa62.edu
761aee8c-a780-4c2c-9a1b-5f023d462faf	39718b7f-1760-4e5f-a303-5436a52d4968	Test Institute	10	100	testbb08.edu
062db039-8d65-46c6-90c9-d8289161cfc8	7eedb75f-c417-4e68-ad54-265d404b73d1	Test Institute	10	100	test3e41.edu
24fc2ee9-6703-4951-8ea9-e3b1182ca44c	47189ca3-eba9-4c74-a88a-bff619b8e040	Test Institute	10	100	testd72a.edu
dfc1c660-a09f-42dd-9b91-4902c94c9d96	e62343eb-5bb3-4309-80ee-0a93c7688b33	Test Institute	10	100	testa94d.edu
a927a4ff-be99-4f50-b491-91cc7d6e0149	f6177384-48af-469d-bbf9-de2ca0bd31f2	Test Institute	10	100	test67b5.edu
191e8c3f-625f-450a-aa78-e4095f350777	76b9d34d-b6c6-41b2-b653-178c3882439e	Test Institute	10	100	test0b16.edu
ef7447bc-527d-4ed9-9080-50355693aac6	93432fbe-e6e9-4e74-bd88-167cbbfa3850	Test Institute	10	100	test0ea0.edu
255a2637-cb94-438c-b8e8-fd60009f8c27	6d7c9767-d55c-4763-8280-8f090a59183b	Test Institute	10	100	test22cf.edu
692766ee-e05c-4e85-9e44-eb4bc294de58	43431961-394e-4fc1-969e-474b91510062	Test Institute	10	100	test5dd5.edu
23b93d67-f127-4090-8fa3-0be5424bde3f	6cabdc02-cef5-4d2a-92a8-69b86c67a19f	Test Institute	10	100	test82f5.edu
fa0c6b00-2726-4c92-9a5a-4678a2f01360	cbb244f8-8744-4f35-8da6-10c0cc008cf5	Test Institute	10	100	testcb0f.edu
fa944855-fb86-4dc0-b620-985d3879b397	1c7c6e88-1671-4f56-b3df-d5f8fd94fe5b	Test Institute	10	100	test40e2.edu
e80c3426-bf6e-4d35-b542-057a5431af4e	147a5418-9cd5-4056-ad63-c9cc9174f1f6	Test Institute	10	100	testf4f7.edu
10bf5956-4b74-4f97-922f-eaf3e08ed61c	1d14b87d-0ac7-4b31-a189-6943dfe0cd80	Test Institute	10	100	testde51.edu
7ebb6692-da05-4029-ae4d-96868a97ef3d	755e311b-23c0-4c36-9b44-2ba71b63d298	Test Institute	10	100	test6802.edu
b2e4b0c0-9ba7-4ebb-b244-cc46e1aa565d	02e30eac-868d-4f80-82f9-1bf07d8baf07	Test Institute	10	100	testb3bf.edu
d9972968-7dda-4e07-8653-cf9975ffef3f	ad0bc6aa-cd61-4699-b1cf-0dfd57795fa6	Test Institute	10	100	testaae1.edu
6b718a1a-93f2-4cf9-9b72-5aec60b9ca15	81b639ee-454e-4d1b-9fe3-1aa8ab4779ae	Test Institute	10	100	test359e.edu
e39b03c6-619b-43ba-ad77-3bb86545928a	a5580090-b3de-4e41-a9f6-c64191db362d	Test Institute	10	100	testf026.edu
3a7ce12a-24bb-4f4d-8c44-243c061e111f	5d8d1d26-0d83-4cbe-942f-767428c7b220	Test Institute	10	100	test80fa.edu
8f785b96-29ff-49a1-bf73-7ea87eaeee34	0fefd9f0-09a6-43d2-a4b3-563564b55b66	Test Institute	10	100	test947e.edu
782eb45b-10fc-4920-910d-6c3f3285d540	63be729a-d009-4498-9f4c-aba4dd2e0f21	Test Institute	10	100	test06fb.edu
36451365-c35b-4873-8af4-0d3c41de8bd1	7733c327-08ff-40d5-973f-ac00e9597dd8	Test Institute	10	100	testa8ff.edu
f7776757-407e-40c7-9b79-730356fee2bd	66678a68-611a-4f58-86cd-8f50b7af2d5a	Test Institute	10	100	test8e7e.edu
2005b30f-c1b4-47d4-b144-7ac707457da0	b37f63d2-4f6c-4cb7-89ff-2a24396988b6	Test Institute	10	100	test87f2.edu
\.


--
-- TOC entry 5389 (class 0 OID 50024)
-- Dependencies: 251
-- Data for Name: institution_intelligence_score; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.institution_intelligence_score (id, institute_id, score, category, academic_factor, placement_factor, research_factor, snapshot_date) FROM stdin;
\.


--
-- TOC entry 5379 (class 0 OID 49838)
-- Dependencies: 241
-- Data for Name: internal_marks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.internal_marks (id, student_id, subject_id, internal_1, internal_2, assignment, model_exam) FROM stdin;
\.


--
-- TOC entry 5386 (class 0 OID 49973)
-- Dependencies: 248
-- Data for Name: internship_gap_analysis; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.internship_gap_analysis (id, department_id, academic_year, participation_rate, gap_score, snapshot_date) FROM stdin;
\.


--
-- TOC entry 5401 (class 0 OID 50210)
-- Dependencies: 263
-- Data for Name: learning_recommendations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.learning_recommendations (id, student_id, item_type, title, reason, status) FROM stdin;
\.


--
-- TOC entry 5363 (class 0 OID 49532)
-- Dependencies: 225
-- Data for Name: mentor_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mentor_assignments (id, faculty_id, department_id, batch_year) FROM stdin;
\.


--
-- TOC entry 5376 (class 0 OID 49773)
-- Dependencies: 238
-- Data for Name: mentor_feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mentor_feedback (id, student_id, mentor_id, feedback_type, content, created_at) FROM stdin;
\.


--
-- TOC entry 5366 (class 0 OID 49592)
-- Dependencies: 228
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, user_id, title, message, is_read, created_at) FROM stdin;
\.


--
-- TOC entry 5385 (class 0 OID 49957)
-- Dependencies: 247
-- Data for Name: placement_readiness; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.placement_readiness (id, student_id, score, category, cgpa_factor, internship_factor, project_factor, snapshot_date) FROM stdin;
\.


--
-- TOC entry 5394 (class 0 OID 50100)
-- Dependencies: 256
-- Data for Name: portfolio_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.portfolio_profiles (id, student_id, public_url_slug, is_public, theme, pdf_export_url, created_at) FROM stdin;
\.


--
-- TOC entry 5397 (class 0 OID 50153)
-- Dependencies: 259
-- Data for Name: recruiter_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recruiter_profiles (user_id, company_name, industry, is_verified) FROM stdin;
\.


--
-- TOC entry 5398 (class 0 OID 50167)
-- Dependencies: 260
-- Data for Name: recruiter_search_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recruiter_search_logs (id, recruiter_id, search_query, filters_used, "timestamp") FROM stdin;
\.


--
-- TOC entry 5395 (class 0 OID 50117)
-- Dependencies: 257
-- Data for Name: resume_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resume_profiles (id, student_id, ats_score, compatibility_feedback, resume_type, pdf_url, docx_url, generated_at) FROM stdin;
\.


--
-- TOC entry 5374 (class 0 OID 49744)
-- Dependencies: 236
-- Data for Name: risk_assessments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.risk_assessments (id, student_id, risk_score, risk_category, factors, updated_at) FROM stdin;
\.


--
-- TOC entry 5381 (class 0 OID 49880)
-- Dependencies: 243
-- Data for Name: semester_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.semester_results (id, student_id, subject_id, grade, credits, status) FROM stdin;
\.


--
-- TOC entry 5372 (class 0 OID 49713)
-- Dependencies: 234
-- Data for Name: semesters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.semesters (id, department_id, semester_number, academic_year, regulation, start_date, end_date) FROM stdin;
\.


--
-- TOC entry 5392 (class 0 OID 50069)
-- Dependencies: 254
-- Data for Name: skill_gap_analysis; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.skill_gap_analysis (id, student_id, target_role, missing_skills, weak_skills, gap_score, analysis_date) FROM stdin;
\.


--
-- TOC entry 5391 (class 0 OID 50054)
-- Dependencies: 253
-- Data for Name: skill_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.skill_profiles (id, student_id, skill_name, proficiency, is_verified, source) FROM stdin;
\.


--
-- TOC entry 5400 (class 0 OID 50195)
-- Dependencies: 262
-- Data for Name: student_digital_twins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_digital_twins (id, student_id, snapshot_data, updated_at) FROM stdin;
\.


--
-- TOC entry 5361 (class 0 OID 49481)
-- Dependencies: 223
-- Data for Name: student_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_profiles (user_id, enrollment_number, roll_number, department_id, batch_year, mentor_id, linkedin_url, gender, accommodation, father_name, father_mobile, father_occupation, mother_name, mother_mobile, mother_occupation, family_income, year_of_joining, year_of_passing, tenth_percentage, twelfth_percentage, school_name, school_address, home_address, aadhaar_number, aadhaar_certificate_url, community_certificate_url, bank_passbook_url, tenth_marksheet_url, twelfth_marksheet_url, public_profile_id, profile_status, rejection_reason) FROM stdin;
fcbc51f6-0c5a-414e-ad83-05d0907bf80e	ENRKIT0001	24kit001	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	797c9a73-e0b6-4f52-baa6-688d8ec72c4c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	bea258f2-435d-4ead-a726-ea8dbd463a24	PENDING	\N
84e25b70-a4d6-4474-9479-b08b9baf39d0	ENRKIT0002	24kit002	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	438b9aa9-39b3-4ee4-bf1d-20d3b79ebd05	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ade8d914-236f-4246-a94e-b7402db32083	PENDING	\N
d7b85c09-78e9-44ed-8525-8ebd26917d48	ENRKIT0003	24kit003	f945b515-a537-4ab1-a1da-7cd72141897c	2024	b6c16b09-9a2e-40ba-864f-628dccd6ccaf	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4b7b5e89-836d-4306-aed5-148cc1ed3428	PENDING	\N
1914e6fe-5969-48e9-afe3-46d97b503f9f	ENRKIT0004	24kit004	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	797c9a73-e0b6-4f52-baa6-688d8ec72c4c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	97d73836-513b-4b93-86d9-3cab9ea7c6a2	PENDING	\N
e8840667-6418-4f78-8cc8-e5badf9eaf5b	ENRKIT0005	24kit005	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	cf03e4cf-6353-451c-be5a-b6c950a9c23f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6a3f2d0f-7895-47bc-b7ea-92c50ef39b5a	PENDING	\N
00cc944b-7914-401b-b5a8-9389a68f1e7d	ENRKIT0006	24kit006	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	6cc4a9ec-53ce-4554-a986-8ea49a40da86	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	98883559-422d-4c11-aed6-ddc25fc8fbee	PENDING	\N
fde96dac-4e26-4ad8-a919-fa8cf09147bd	ENRKIT0007	24kit007	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	afb10696-4ac0-4a44-894e-8eae828b590a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ba86b248-f397-44a1-8e12-6a7eb978f561	PENDING	\N
ada27de4-d439-4a0c-aa87-d98074892310	ENRKIT0008	24kit008	f945b515-a537-4ab1-a1da-7cd72141897c	2024	4a595638-db48-4eac-9d53-9b3b82c2d110	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4dd99492-4522-443c-bb75-a6b2f8cdd5a8	PENDING	\N
62190dae-e8a5-4de3-a536-edfe5c64b8dd	ENRKIT0009	24kit009	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	6cc4a9ec-53ce-4554-a986-8ea49a40da86	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d5274bf5-0a21-4c54-93d1-ac091a86ac3c	PENDING	\N
a492622e-5f9d-42dc-bd26-b68afd4ee4c0	ENRKIT0010	24kit010	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	64231fe6-e91b-43fa-8d7b-060d4bfbb6ee	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f5a2bdad-db5b-4b3a-bca6-38d6fd428342	PENDING	\N
60156d1c-addf-440e-970f-2885a053347d	ENRKIT0011	24kit011	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	afb10696-4ac0-4a44-894e-8eae828b590a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	24c4c652-9c7d-4b55-8298-6e2a654375fe	PENDING	\N
b8bfae65-ef25-4267-bec0-e227ee9cfb95	ENRKIT0012	24kit012	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	d6e84c53-e80b-45ff-a1fd-d7ec87f9d04e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a38506c6-c761-4b39-a284-40e850ccc12f	PENDING	\N
2f12fbf5-4ce8-479d-90fe-f9bdef8961f7	ENRKIT0013	24kit013	f945b515-a537-4ab1-a1da-7cd72141897c	2024	a7e412a2-34c1-46cb-86c1-0b36bb40c16e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a6b3ef24-2220-4175-8c6a-84d1feb8e1a3	PENDING	\N
3fda667e-52a1-4326-83f6-f72a6d754666	ENRKIT0014	24kit014	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	6cc4a9ec-53ce-4554-a986-8ea49a40da86	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9134cf2a-3746-42ce-945a-50c59e783bf2	PENDING	\N
e19cb784-e5b6-488e-893c-16b2005086d7	ENRKIT0015	24kit015	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	3a568bf8-343a-436c-a227-a74dbb8dbe44	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	96d3efef-43a6-4156-8783-db99b671bf56	PENDING	\N
db54e9d4-257b-4567-a9ad-a78b4cd7585d	ENRKIT0016	24kit016	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	438b9aa9-39b3-4ee4-bf1d-20d3b79ebd05	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	915b2e42-a94d-49a7-b58b-49e1501ab637	PENDING	\N
aa843b89-2c7d-47e8-93f0-165fc66b48d7	ENRKIT0017	24kit017	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	cf03e4cf-6353-451c-be5a-b6c950a9c23f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	54c056c8-9bfe-4ef3-8531-965ebe93bec3	PENDING	\N
d6cc35e6-2b21-4991-aab2-ade10cec4f12	ENRKIT0018	24kit018	f945b515-a537-4ab1-a1da-7cd72141897c	2024	ee78621b-47ee-4339-b469-e33c89aff3b0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7b5c3d80-2904-446e-90bb-b7f6ce1f0cd3	PENDING	\N
ee5a1de0-c771-43a8-b108-1a3c6ee215b3	ENRKIT0019	24kit019	f945b515-a537-4ab1-a1da-7cd72141897c	2024	64231fe6-e91b-43fa-8d7b-060d4bfbb6ee	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6d5e1867-55ab-4561-9beb-c3a98a78e3de	PENDING	\N
1e247c62-c823-48fe-924a-9accba0bd232	ENRKIT0020	24kit020	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	797c9a73-e0b6-4f52-baa6-688d8ec72c4c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	47430aaf-46bf-40ab-8825-29f73e121d4e	PENDING	\N
a78dca52-8e16-47f2-b0d2-d74af9c53587	ENRKIT0021	24kit021	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	438b9aa9-39b3-4ee4-bf1d-20d3b79ebd05	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7e1e8fc9-c303-4b8f-8dae-1bda06352a68	PENDING	\N
447316b4-3276-4db0-a12b-9657b40aeb08	ENRKIT0022	24kit022	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	a1ece2ea-3c16-4608-add5-e807e4e1652d	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e34777c8-9bdc-458a-a3c6-a7bc9c63828f	PENDING	\N
3fb0aec5-211f-4538-b4f1-9a7503742c9a	ENRKIT0023	24kit023	f945b515-a537-4ab1-a1da-7cd72141897c	2024	ee78621b-47ee-4339-b469-e33c89aff3b0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a453bab0-6014-4f81-99c8-e567a2155c53	PENDING	\N
a4e7dad1-b6f5-4b29-ada5-fdb67bd3ecb5	ENRKIT0024	24kit024	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	afb10696-4ac0-4a44-894e-8eae828b590a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d064f6f6-f546-4783-80cd-c7dddfd6b77e	PENDING	\N
81b94239-c1dc-403f-a3d2-5ae05c1027db	ENRKIT0025	24kit025	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	d6e84c53-e80b-45ff-a1fd-d7ec87f9d04e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a840f8b1-8b6b-438f-89b8-8f615e882100	PENDING	\N
80a2fb36-68a3-4028-abfc-0213aa497f94	ENRKIT0026	24kit026	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	438b9aa9-39b3-4ee4-bf1d-20d3b79ebd05	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7e1ea109-8952-400b-8c0f-32884dba70e3	PENDING	\N
260928b8-8826-43ad-b2ac-2ac5f573bce9	ENRKIT0027	24kit027	f945b515-a537-4ab1-a1da-7cd72141897c	2024	d945cb55-c4c3-4c1c-bdc1-e3f0627612d6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	43310e7c-a168-4ae4-9c03-5a24b3b31167	PENDING	\N
d46acc07-f74e-40df-96e5-ad4d5755cf6e	ENRKIT0028	24kit028	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	b44c561d-fc89-413a-a012-7abd1230e4f6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9c2f731b-b4cb-409a-9307-375639b54fb6	PENDING	\N
a2cc566f-8d43-4997-9326-885c8be4ff70	ENRKIT0029	24kit029	f945b515-a537-4ab1-a1da-7cd72141897c	2024	ed4430aa-571b-44cb-9f0a-15a5fe2fa2eb	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	297c4e3d-9103-425b-a085-7dd4305b89ce	PENDING	\N
13683caa-d23c-400f-894d-eb567538e5c5	ENRKIT0030	24kit030	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	4382df8c-2f5a-4912-a3f8-432aaf31890d	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	67f52907-2834-479d-9a60-419280a127d2	PENDING	\N
f4914a26-39bc-4f1d-8f20-af48433781a7	ENRKIT0031	24kit031	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	64231fe6-e91b-43fa-8d7b-060d4bfbb6ee	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a2aba869-a05e-4701-a1fb-1ddaffd7ca1b	PENDING	\N
a05010c8-ad20-4e06-82e3-a8ca5aa987ae	ENRKIT0032	24kit032	f945b515-a537-4ab1-a1da-7cd72141897c	2024	4a595638-db48-4eac-9d53-9b3b82c2d110	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5090d2f4-033c-47a1-b9dd-f276656bbcc1	PENDING	\N
581d4b4e-5dae-45dc-b33f-d0bbd6a62d2f	ENRKIT0033	24kit033	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	4a595638-db48-4eac-9d53-9b3b82c2d110	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	074de2b7-1505-44d7-a5dd-186464bce9a2	PENDING	\N
323b6b31-0416-496b-b68e-26b4be7dcdf6	ENRKIT0034	24kit034	f945b515-a537-4ab1-a1da-7cd72141897c	2024	64231fe6-e91b-43fa-8d7b-060d4bfbb6ee	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a47205b6-5a3e-4c52-82db-b42479c2bf9b	PENDING	\N
00c5dc40-a3e2-4504-a61d-03b949909020	ENRKIT0035	24kit035	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	d6e84c53-e80b-45ff-a1fd-d7ec87f9d04e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4c9c6741-3d80-411e-ae51-326c919be41a	PENDING	\N
75dafcce-e746-4599-ad5b-32ec83a1fb60	ENRKIT0036	24kit036	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	438b9aa9-39b3-4ee4-bf1d-20d3b79ebd05	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	eb4d7cc4-3f84-4bed-835b-58a54018a450	PENDING	\N
d8c7e638-0b22-4f0c-815a-36ee4f7211cb	ENRKIT0037	24kit037	f945b515-a537-4ab1-a1da-7cd72141897c	2024	a7e412a2-34c1-46cb-86c1-0b36bb40c16e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b86f46cf-c385-4428-ade8-acfd32d43284	PENDING	\N
c1d203ae-7231-4fc9-8b1a-3e28304c6353	ENRKIT0038	24kit038	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	4a595638-db48-4eac-9d53-9b3b82c2d110	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	c14ab0fe-d9d7-4a24-9b5a-cbaed7556972	PENDING	\N
96c7cb17-de02-4e02-8756-c58333cd8779	ENRKIT0039	24kit039	f945b515-a537-4ab1-a1da-7cd72141897c	2024	438b9aa9-39b3-4ee4-bf1d-20d3b79ebd05	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8653889b-f38f-456c-99fa-24ede41f50f7	PENDING	\N
8081b8d9-54c1-43f4-8793-8351f045e3bc	ENRKIT0040	24kit040	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	b6c16b09-9a2e-40ba-864f-628dccd6ccaf	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0380af2a-66ea-427b-87f8-583a47cec978	PENDING	\N
f4066466-851c-416d-a304-e07202759e52	ENRKIT0041	24kit041	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	64231fe6-e91b-43fa-8d7b-060d4bfbb6ee	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	df1b9699-3fad-48b6-ae3c-9f5827306e55	PENDING	\N
36a3fae4-b0d1-492e-a78f-0c9fdabc2ef2	ENRKIT0042	24kit042	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	a7e412a2-34c1-46cb-86c1-0b36bb40c16e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	033d0ddc-ad71-4ea5-9086-ce147a393e51	PENDING	\N
cc59093d-5fc8-4f19-85b4-95c1080a0f4e	ENRKIT0043	24kit043	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	64231fe6-e91b-43fa-8d7b-060d4bfbb6ee	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1726fe30-8031-42b5-8449-ae87e6faf2a2	PENDING	\N
f7033f98-0c66-4ff3-a45f-4f6b2924d1a7	ENRKIT0044	24kit044	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	b6c16b09-9a2e-40ba-864f-628dccd6ccaf	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2b92dbc5-fd07-42ea-a286-981ca7fc0f22	PENDING	\N
cee3c6cf-d7de-4a00-97e5-e0745c380efa	ENRKIT0045	24kit045	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	d6e84c53-e80b-45ff-a1fd-d7ec87f9d04e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	440922a7-d914-426d-a5ad-689e6b986ece	PENDING	\N
efca4fc1-cabe-47e4-bc53-6676ee86e36e	ENRKIT0046	24kit046	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	cf03e4cf-6353-451c-be5a-b6c950a9c23f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	662198e9-9bfa-4285-a361-a712f13a7e55	PENDING	\N
3d219b52-dff4-4953-b4c5-ec6c1868f3f3	ENRKIT0047	24kit047	f945b515-a537-4ab1-a1da-7cd72141897c	2024	6cc4a9ec-53ce-4554-a986-8ea49a40da86	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7f364b23-e1d8-43fe-bc03-82a871b2af91	PENDING	\N
56a8c99b-5665-4efd-9bc6-e160d2eb92dd	ENRKIT0048	24kit048	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	018ca201-4cf8-4c1b-a576-eee330e1c84a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	45c39c74-937a-4acb-a876-cb2452c73363	PENDING	\N
e1db4481-0fc6-4729-a37e-60f667f67a4d	ENRKIT0049	24kit049	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8	2024	4a595638-db48-4eac-9d53-9b3b82c2d110	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f3bc7ec4-f291-427d-b7cc-c6def09fd433	PENDING	\N
b6c06c72-27c1-40a4-bf1c-6c1386480d6c	ENRKIT0050	24kit050	4d6a5eee-7226-445a-a6aa-5135f8887140	2024	438b9aa9-39b3-4ee4-bf1d-20d3b79ebd05	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e3aef7ac-4c30-487b-8e5c-3143cd0450f7	PENDING	\N
71097a7e-4fe4-4c06-a8e8-2fee180ce321	ENRSRM0001	24srm001	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	2024	ff737f31-ba81-4efb-ab48-04255f74c0b6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ef5c08a9-df18-4826-a927-87cdd03e484a	PENDING	\N
9bd73420-f791-4907-a31c-a3c8ed9ba78b	ENRSRM0002	24srm002	bff398ef-9c99-4658-be03-0eabfdf6f9c4	2024	081cbc26-3e8a-4865-9880-d525cfe6471e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5c38b0ee-fa66-4b5e-8d7f-d3ec1418a4e6	PENDING	\N
032183ec-32e7-4f55-925f-8dca6b7c0eaa	ENRSRM0003	24srm003	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	2024	f2726a9a-b263-4834-af6a-c804fc8f6e37	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ebdd0f3b-2bd6-4b0a-bab3-c9c2d95020e3	PENDING	\N
65a77d8a-4f58-47fe-b438-1a2f6d2659bb	ENRSRM0004	24srm004	72958370-78e8-4805-bbff-c8db9847d6e1	2024	5a500067-a553-42c9-97c0-4de9152c5cdd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0da7b71b-2473-4e6c-8a06-35e446578db8	PENDING	\N
1b765c11-628e-4ed6-b3cc-5952f3d082c5	ENRSRM0005	24srm005	72958370-78e8-4805-bbff-c8db9847d6e1	2024	5a500067-a553-42c9-97c0-4de9152c5cdd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a71c1677-2771-4464-8a05-8a00984eb1b6	PENDING	\N
a9fc73f6-8f81-4703-8be9-4428c3eb0b0d	ENRSRM0006	24srm006	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	2024	478d0ef0-3979-474a-b181-1c0b95670f75	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8f7b6193-6a9e-4a17-bffc-e334f939d59f	PENDING	\N
29c0ef73-d9a9-46f7-8c9e-e405468bf876	ENRSRM0007	24srm007	72958370-78e8-4805-bbff-c8db9847d6e1	2024	e023565f-6cac-4f76-b9ad-1b7f60106688	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4cb66250-f94a-457f-97ec-44f4273fb034	PENDING	\N
471b7ac0-c956-4983-b4b8-35552cde4b05	ENRSRM0008	24srm008	bff398ef-9c99-4658-be03-0eabfdf6f9c4	2024	69ebc9f2-0fc9-40a6-95a5-c85607cbc3c5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e9e00cfa-96d9-4343-99eb-f37a479be80f	PENDING	\N
3b98d25b-879f-47e1-ac23-4f55a215e300	ENRSRM0009	24srm009	bff398ef-9c99-4658-be03-0eabfdf6f9c4	2024	91f2a192-96af-4566-bd2c-6f400306258a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	46b1ded2-8b71-49b8-95c0-521363b5341d	PENDING	\N
bbf052d2-4ffe-4a22-bf8f-15264873d31f	ENRSRM0010	24srm010	72958370-78e8-4805-bbff-c8db9847d6e1	2024	37be8732-9def-4b0d-b3c7-737017b724bb	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f9c2b6de-a583-40b7-872a-9ad120babeb7	PENDING	\N
052031dc-d094-44b6-8d5c-7be69a8441f8	ENRSRM0011	24srm011	72958370-78e8-4805-bbff-c8db9847d6e1	2024	081cbc26-3e8a-4865-9880-d525cfe6471e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	bed00ee5-f3de-4c1f-977f-5231564eeab9	PENDING	\N
752ed4ec-d969-495e-9392-cd3076fe02db	ENRSRM0012	24srm012	bff398ef-9c99-4658-be03-0eabfdf6f9c4	2024	134c8195-028f-4392-8bcb-64fe1bafde9b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5a4467fa-f1ff-4656-b65d-ea38e3c737cf	PENDING	\N
26b45355-2756-4dbc-9b87-f2e00b6b4f27	ENRSRM0013	24srm013	72958370-78e8-4805-bbff-c8db9847d6e1	2024	69ebc9f2-0fc9-40a6-95a5-c85607cbc3c5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a3240053-16ca-451c-a41c-95d3c6b4e099	PENDING	\N
a35c48ad-f3a6-4f79-ae8c-48318994ac73	ENRSRM0014	24srm014	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	2024	f2726a9a-b263-4834-af6a-c804fc8f6e37	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	70ec961b-b79a-4d72-89a5-60036a32df53	PENDING	\N
c38ce2e7-204d-46d4-87d9-391968495636	ENRSRM0015	24srm015	72958370-78e8-4805-bbff-c8db9847d6e1	2024	e023565f-6cac-4f76-b9ad-1b7f60106688	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b6e20095-2879-490a-a10d-cd5481ee48d7	PENDING	\N
0b9b893a-8846-4b10-94d3-eded74e3111c	ENRSRM0016	24srm016	bff398ef-9c99-4658-be03-0eabfdf6f9c4	2024	5a500067-a553-42c9-97c0-4de9152c5cdd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	cad23e29-c7f8-4ee7-a0df-f5df5d93febe	PENDING	\N
d47ee77b-8937-418b-a4d0-68e296101d15	ENRSRM0017	24srm017	72958370-78e8-4805-bbff-c8db9847d6e1	2024	ff737f31-ba81-4efb-ab48-04255f74c0b6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b4c9fa45-945a-474f-8f9a-6eacf46aee7b	PENDING	\N
aefcf6e7-15b0-4a65-82f3-d5fe2505fe2d	ENRSRM0018	24srm018	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	2024	d84d85e4-7ad8-400a-afed-69f0b7b9c46f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	65e98a84-91bc-4c84-9329-bb92f5182dc7	PENDING	\N
ddcf953c-e06c-44d4-a6dd-de2086ed7324	ENRSRM0019	24srm019	bff398ef-9c99-4658-be03-0eabfdf6f9c4	2024	91f2a192-96af-4566-bd2c-6f400306258a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	246fa3dc-2df4-4d6b-a6b8-33a4728960bc	PENDING	\N
fd1fe2a0-f4b6-49a0-b16e-1e8577eecdef	ENRSRM0020	24srm020	bff398ef-9c99-4658-be03-0eabfdf6f9c4	2024	134c8195-028f-4392-8bcb-64fe1bafde9b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b1660d73-f51c-49fa-806f-53e6da9528f7	PENDING	\N
754d88fa-7837-4d53-8a28-22ede76818c0	ENRSRM0021	24srm021	72958370-78e8-4805-bbff-c8db9847d6e1	2024	988a63f6-2f13-46e9-b343-3cfaeac106e4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f0076b13-06fa-48a3-b438-9b2a6abd6f1f	PENDING	\N
ea0d9d30-7593-4557-993f-c56481673cc2	ENRSRM0022	24srm022	72958370-78e8-4805-bbff-c8db9847d6e1	2024	d84d85e4-7ad8-400a-afed-69f0b7b9c46f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f4c5c298-0eae-44c8-9515-813ed0a28ec9	PENDING	\N
4852b9e5-bd5b-410e-95cd-3bdc6c7d4a13	ENRSRM0023	24srm023	72958370-78e8-4805-bbff-c8db9847d6e1	2024	e023565f-6cac-4f76-b9ad-1b7f60106688	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2dfc14db-7cf0-418a-bece-9c924a41b719	PENDING	\N
79e2ff21-342e-4e8c-9af3-4abab2802af8	ENRSRM0024	24srm024	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	2024	988a63f6-2f13-46e9-b343-3cfaeac106e4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ec08583e-c870-4c6d-9c7e-1b5c7faff0da	PENDING	\N
98131218-9748-41a6-becd-636869979615	ENRSRM0025	24srm025	bff398ef-9c99-4658-be03-0eabfdf6f9c4	2024	e023565f-6cac-4f76-b9ad-1b7f60106688	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	86bbcc7d-9edc-48da-b4cc-8f329b99853a	PENDING	\N
563fa467-f8fa-47a6-94fb-9f69be5a8dba	ENRSRM0026	24srm026	bff398ef-9c99-4658-be03-0eabfdf6f9c4	2024	41ef9f4f-14af-4027-99e8-7cfdddb7459b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	13963552-1d13-4f19-b78c-b68315055cbf	PENDING	\N
974dfd1f-340b-4f53-b01d-79eccf913af2	ENRSRM0027	24srm027	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	2024	73d91822-6bb0-4769-8ab9-acf74112282e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	61e27999-6a69-4860-8cc8-f5193790a8c1	PENDING	\N
dd10af4b-4c5e-4844-9306-b0d651a29bdd	ENRSRM0028	24srm028	72958370-78e8-4805-bbff-c8db9847d6e1	2024	91f2a192-96af-4566-bd2c-6f400306258a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3772d7db-711c-4b7f-8eb4-8e4858381631	PENDING	\N
b64425d9-92ba-44c6-9203-fc6347a988b2	ENRSRM0029	24srm029	bff398ef-9c99-4658-be03-0eabfdf6f9c4	2024	37be8732-9def-4b0d-b3c7-737017b724bb	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e2f3218b-6988-466e-9017-28d2f160ebbc	PENDING	\N
7e212f08-02fd-4121-b2e9-4925ffa92f66	ENRSRM0030	24srm030	bff398ef-9c99-4658-be03-0eabfdf6f9c4	2024	9228c986-2cf4-4a1f-80c4-5393ff1fb917	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	87bb82d3-ad8f-4c07-9de8-b4a06c7c9053	PENDING	\N
2355a51c-2e2b-44b6-a21f-dfc7f08a15be	ENRSRM0031	24srm031	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	2024	478d0ef0-3979-474a-b181-1c0b95670f75	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	51d643dd-f4d0-49a5-bb8b-14eda2abbaef	PENDING	\N
57f565ff-96e1-406f-8be0-9844719a5c18	ENRSRM0032	24srm032	72958370-78e8-4805-bbff-c8db9847d6e1	2024	ff737f31-ba81-4efb-ab48-04255f74c0b6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	48d201e6-0e16-46af-8e6a-75dd1b958b81	PENDING	\N
0129b199-7759-4c48-8b8b-d0a63540ee1e	ENRSRM0033	24srm033	72958370-78e8-4805-bbff-c8db9847d6e1	2024	41ef9f4f-14af-4027-99e8-7cfdddb7459b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	513c00bf-14e4-41ae-b1c9-3e98775fad6b	PENDING	\N
f90c0e63-1696-4d4b-b3ed-163399fc2514	ENRSRM0034	24srm034	72958370-78e8-4805-bbff-c8db9847d6e1	2024	18e53602-bdd3-4b5e-94ed-56a0553b95fd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	153f475f-3bcf-48fa-8268-8680f2709332	PENDING	\N
7826db9f-52d0-4887-9aca-7035e1686218	ENRSRM0035	24srm035	72958370-78e8-4805-bbff-c8db9847d6e1	2024	d84d85e4-7ad8-400a-afed-69f0b7b9c46f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9c6b589c-1656-4046-a249-b85db5f8dcaa	PENDING	\N
880f3119-8169-4ffc-9da7-d66d651006ec	ENRSRM0036	24srm036	72958370-78e8-4805-bbff-c8db9847d6e1	2024	18e53602-bdd3-4b5e-94ed-56a0553b95fd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	db22f13b-b814-450a-a167-0e9f989b4dbc	PENDING	\N
3d9b3bac-e192-4c9d-9795-87ba23b76aa3	ENRSRM0037	24srm037	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	2024	134c8195-028f-4392-8bcb-64fe1bafde9b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	45a5421b-1df3-4f3d-aac2-bfcad3e42448	PENDING	\N
ff8ed635-5188-4d0e-8c12-042cbfc16fe5	ENRSRM0038	24srm038	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	2024	91f2a192-96af-4566-bd2c-6f400306258a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	732ef271-de1d-4ccd-8f05-47577389820e	PENDING	\N
33f78969-5d33-488e-9fa7-52c0d41c96b2	ENRSRM0039	24srm039	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	2024	e023565f-6cac-4f76-b9ad-1b7f60106688	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50977108-2919-4bcb-a1a2-175c14732d0f	PENDING	\N
ca60d543-c996-4f17-b0b1-a6d1349df074	ENRSRM0040	24srm040	bff398ef-9c99-4658-be03-0eabfdf6f9c4	2024	18e53602-bdd3-4b5e-94ed-56a0553b95fd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	37627c4d-a20f-4c00-b585-cfb3e09640c4	PENDING	\N
b13b09b1-eba6-4a05-a0e3-f5173ce1cb64	ENRSRM0041	24srm041	72958370-78e8-4805-bbff-c8db9847d6e1	2024	cf050f19-9fbc-4db4-b53e-5680d36a41e0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2fecd149-ed17-416f-9b20-2cf353f1b68d	PENDING	\N
3ba1088f-da95-4c97-94c5-f25355824132	ENRSRM0042	24srm042	bff398ef-9c99-4658-be03-0eabfdf6f9c4	2024	37be8732-9def-4b0d-b3c7-737017b724bb	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	fa5d192c-908b-41a6-b524-5e56a7ab7d5e	PENDING	\N
735eb6ea-6b33-4bb4-8d25-0b593c22225d	ENRSRM0043	24srm043	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	2024	f2726a9a-b263-4834-af6a-c804fc8f6e37	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	86b628c4-c25d-4552-aa01-8afb7c75fe4a	PENDING	\N
42cd237d-75e9-458a-8596-a16471970d13	ENRSRM0044	24srm044	72958370-78e8-4805-bbff-c8db9847d6e1	2024	134c8195-028f-4392-8bcb-64fe1bafde9b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	eeda1ee0-743d-4c94-b957-596e3858deca	PENDING	\N
b031fd8d-40e7-4faf-b857-025fd59be574	ENRSRM0045	24srm045	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	2024	d84d85e4-7ad8-400a-afed-69f0b7b9c46f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a3844bf4-0221-40da-beaa-e110e4bc7b24	PENDING	\N
03c8308c-51cc-412c-b092-bda99e3851bb	ENRSRM0046	24srm046	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	2024	18e53602-bdd3-4b5e-94ed-56a0553b95fd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a0f7fbd9-70cf-41a8-aadb-4dec8561b3e6	PENDING	\N
70ab0c9e-e622-4fcb-ba74-2c71d715d1b4	ENRSRM0047	24srm047	72958370-78e8-4805-bbff-c8db9847d6e1	2024	25766653-8bb5-4cb3-a15f-95431b8f9fb5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	64ce0e83-7e58-42de-89e8-b6c5b926369b	PENDING	\N
e2855780-d2a5-43b9-92b7-519db5d4c4c9	ENRSRM0048	24srm048	120a02b3-2ce1-4dc2-ab15-0dcddfb18269	2024	081cbc26-3e8a-4865-9880-d525cfe6471e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	567e3b85-493e-4a0e-9c4f-c045d9ec63e9	PENDING	\N
3377cfe9-6ab8-419a-8923-93df45e0abfc	ENRSRM0049	24srm049	bff398ef-9c99-4658-be03-0eabfdf6f9c4	2024	f2726a9a-b263-4834-af6a-c804fc8f6e37	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7b077b96-2831-441b-ba59-581116593cf9	PENDING	\N
6fc48a4a-324f-49fa-997a-4481085e5b95	ENRSRM0050	24srm050	72958370-78e8-4805-bbff-c8db9847d6e1	2024	25766653-8bb5-4cb3-a15f-95431b8f9fb5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d347ba4e-7d79-44a6-a469-bd0fa8c84f77	PENDING	\N
e732d210-e31a-49c0-a366-8bc1146643ed	ENRREC0002	24rec002	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	ed56f9c9-bc01-4edd-a9bc-cd27d007146c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f996b9a8-dc7c-4f95-8cc9-413629e883c5	PENDING	\N
11cd6318-c8e6-4f9f-b847-670bc105205f	ENRREC0003	24rec003	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	ec7dc995-3327-49be-8b82-b8b2e2ea690d	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	11a30d32-672c-44b1-bffc-c62a9085eb79	PENDING	\N
b9f2c161-be1c-4b31-a491-2fd1f9d0c260	ENRREC0004	24rec004	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	9c4f8ec6-54d9-40b7-918d-ef1d8e060fc5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ada9ff90-346d-4f91-9e1b-57db9ac3199c	PENDING	\N
d422b091-6a17-4322-8866-5cd9b7268e15	ENRREC0005	24rec005	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	d7affde7-452a-482f-ba18-56c283f5589b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	377d0584-c0c7-4576-97cd-91e89dde5b47	PENDING	\N
106abc1f-a757-4d83-8c53-7e2264e6db9c	ENRREC0006	24rec006	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	2024	e0435499-11d8-4732-bd82-0e5e6b6c0aa9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	21fc0ae5-b447-4cb1-b538-337d71be9f72	PENDING	\N
0f492f2b-2b6a-4544-8d56-adccd1061cff	ENRREC0008	24rec008	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	ed56f9c9-bc01-4edd-a9bc-cd27d007146c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5f55cd61-f343-4e92-9315-21ce457a0e49	PENDING	\N
ab2bdd3a-ab1a-426b-b05d-f1d13b938b53	ENRREC0011	24rec011	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	ec7dc995-3327-49be-8b82-b8b2e2ea690d	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	27c7ddda-aa34-47e0-8b23-81795b403b66	PENDING	\N
30ad386a-ca28-41b1-b15f-f6a178381787	ENRREC0012	24rec012	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	95dbbab9-cefd-4614-a59d-c5e97a884eaa	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	cc5602e0-204a-4c17-be77-a33a519697b1	PENDING	\N
ebf298d2-8cb9-496d-bf94-e5c4b3ef4988	ENRREC0013	24rec013	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	2024	9878941d-4272-477c-a1e5-3989816877d2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5922d5f5-0dfd-466e-903b-cd5a10eba813	PENDING	\N
c08def5e-c543-426d-a478-e9adbd232498	ENRREC0014	24rec014	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	921268e1-465d-42ac-99a0-c043a4e1bee8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	965732f1-27c9-4537-90be-6a35028b0411	PENDING	\N
1795a03f-8247-4a31-9481-ef3a9c2d2047	ENRREC0015	24rec015	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	2024	ed56f9c9-bc01-4edd-a9bc-cd27d007146c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3de85774-bca7-4984-addc-4e075a66c92a	PENDING	\N
9f65654c-0bc2-4751-acb2-e68ed0dc9143	ENRREC0016	24rec016	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	2b0965be-4ba8-436c-b2bc-52c6128ca86e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5f910d38-9149-4bf0-bf91-44fd37a5f473	PENDING	\N
595a2aff-909e-443a-874d-e5305049232b	ENRREC0018	24rec018	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	d611f17b-a0aa-4f64-a40e-a14537f89bf9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	90e07c06-dfca-4aa3-909f-2c0af37565ed	PENDING	\N
067cba02-8ac2-4847-af07-bb6ef1dc8caa	ENRREC0019	24rec019	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	65902115-1979-4b00-8325-1073f17bfd7e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3bcc8691-6749-4a40-a257-9deaba83fe60	PENDING	\N
3da7596d-996a-4250-9c69-4411faaeb2f6	ENRREC0020	24rec020	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	2024	921268e1-465d-42ac-99a0-c043a4e1bee8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2048b235-c4b9-4f44-97ed-31180f3faf36	PENDING	\N
b3da3ba1-1382-4cc5-8438-c096ee6f3b12	ENRREC0021	24rec021	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	2b0965be-4ba8-436c-b2bc-52c6128ca86e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5bd26ad2-f00a-4227-9292-1c956ad80c4d	PENDING	\N
6eeda03f-cc36-4893-bacc-02aca7abc6ea	ENRREC0022	24rec022	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	2b0965be-4ba8-436c-b2bc-52c6128ca86e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f8924fb7-7123-4ecd-984d-41e17ce724ab	PENDING	\N
07b813ec-a4d8-47b3-9afc-2c7ed6e291d4	ENRREC0007	24rec007	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	ed56f9c9-bc01-4edd-a9bc-cd27d007146c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d914b7e3-3400-4642-a586-173095370cd6	APPROVED	\N
9085e0c0-9861-4947-8c47-4978498f8dea	ENRREC0009	24rec009	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	5c619fef-ca56-46c5-824f-83dc4a1aa6c8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	dd925543-f6ba-48ed-b334-b05afe4e243a	APPROVED	\N
678c8dd1-cf7b-405f-a453-f16b3da2ff4b	ENRREC0010	24rec010	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	95dbbab9-cefd-4614-a59d-c5e97a884eaa	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	894704ed-a560-4a84-a224-84484a5dc2a3	APPROVED	\N
2c74d0a9-4f73-4681-8eeb-dec290748d68	ENRREC0017	24rec017	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	9df2690f-9857-4326-a204-c998133627d4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	88b6e6f1-2967-4c50-8632-78082dcb4700	APPROVED	\N
c7bda684-43d9-4eeb-81cf-26cfe6068054	ENRREC0023	24rec023	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	e0435499-11d8-4732-bd82-0e5e6b6c0aa9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d8014dbb-e5e2-46d0-860b-e8315602e25c	PENDING	\N
21cde788-e038-4dba-8788-deda16bab7bf	ENRREC0024	24rec024	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	e0435499-11d8-4732-bd82-0e5e6b6c0aa9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b5789bdd-a0c0-4f0d-94fd-59249855f3af	PENDING	\N
84bf366c-f148-4158-9be8-9d1bb14bfe68	ENRREC0025	24rec025	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	e0435499-11d8-4732-bd82-0e5e6b6c0aa9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	339a2f8d-0038-4776-aa9a-24d0ad806287	PENDING	\N
8d75a1cd-7a9c-4d5f-b44c-e194a168fae6	ENRREC0026	24rec026	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	900725e4-fb16-465c-80e2-9eb84d214130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0ed4b288-ae1f-4fd2-84a1-b94f5665fcab	PENDING	\N
085de86f-b71c-4f88-80f5-92ff74236d27	ENRREC0027	24rec027	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	e0435499-11d8-4732-bd82-0e5e6b6c0aa9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f92a4450-a408-491c-bef8-b67dbca72c14	PENDING	\N
0ad4056e-5a86-4249-8deb-cd1c00f758e8	ENRREC0028	24rec028	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	ed56f9c9-bc01-4edd-a9bc-cd27d007146c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	070d625a-98f4-4981-b632-5932cb917762	PENDING	\N
34107d12-93d0-4de7-8359-1e6ab87022e3	ENRREC0029	24rec029	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	9c4f8ec6-54d9-40b7-918d-ef1d8e060fc5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	536fc49b-6a51-4603-bab9-639a71195b17	PENDING	\N
bcb945c6-946e-4423-869b-e7e2d6b34ae5	ENRREC0030	24rec030	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	9878941d-4272-477c-a1e5-3989816877d2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b7f5dd6e-9f54-452b-a89a-7fab1a119e3d	PENDING	\N
288e82f3-514c-46cc-80d2-38c45559b875	ENRREC0031	24rec031	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	b12f0510-f50d-4e56-8b1b-e5c3c83f88a3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8070da34-3737-449e-aa8e-33be17f1600e	PENDING	\N
e2dcf024-a033-40bb-a9c4-cd398238043e	ENRREC0032	24rec032	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	9df2690f-9857-4326-a204-c998133627d4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2c3b4e39-7867-4e0d-b9cf-3ca8835dc9b7	PENDING	\N
7ec9c354-52d3-41ad-9ba8-d1a8a9697340	ENRREC0033	24rec033	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	2024	ed56f9c9-bc01-4edd-a9bc-cd27d007146c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	94c701e2-663a-42f3-aea1-e910487d2be0	PENDING	\N
0d7bff47-d8b5-4822-bf38-62a63475b5e4	ENRREC0034	24rec034	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	d611f17b-a0aa-4f64-a40e-a14537f89bf9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	11bba8cb-ac83-493b-9627-bb9bf2f2bded	PENDING	\N
82ee3e81-c4f1-41a7-99e1-a5d28a464145	ENRREC0035	24rec035	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	8fbdc1bd-0de5-4587-ac95-c3de6b6fd80d	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	cb413c14-239b-436e-9fb0-3f9ff7104c4c	PENDING	\N
3646d0e8-2551-41b7-8150-877bb57a85a3	ENRREC0036	24rec036	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	50fbeae0-5407-4d20-9418-e97ef10cec81	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	bc11734d-b716-482e-980f-f96954b80652	PENDING	\N
6c69362e-5aee-41ae-9592-12ffabb1770c	ENRREC0037	24rec037	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	d7affde7-452a-482f-ba18-56c283f5589b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7048a9c4-dbb8-42b6-808a-1f3eb560279b	PENDING	\N
004ab06f-bfb6-4724-aaf7-9f897ad947a8	ENRREC0038	24rec038	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	900725e4-fb16-465c-80e2-9eb84d214130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8440ec21-cbfa-4cad-bdfe-89547640cc0f	PENDING	\N
c858b44d-328f-478b-a99b-1182f7a8ce4b	ENRREC0039	24rec039	2ce3c25a-620d-49cb-89f8-ca0a049be905	2024	65902115-1979-4b00-8325-1073f17bfd7e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7d02cead-cd2f-4d2f-9b6d-4c0dcb3b3441	PENDING	\N
139623e1-3d21-42ab-be76-62dad05f5e35	ENRREC0040	24rec040	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	2024	ec7dc995-3327-49be-8b82-b8b2e2ea690d	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1dcbc4cd-f7ac-49c3-a532-d0a44cb28850	PENDING	\N
1f9dafa9-12c5-45ae-9c30-0acd268d8b83	ENRREC0041	24rec041	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	35a72d9d-4d14-4f25-ad79-afce7869fa1f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9415e982-7b29-451d-9617-d2a67de1c96d	PENDING	\N
868eb765-11d6-4dff-bea4-4de990b73cdb	ENRREC0042	24rec042	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	921268e1-465d-42ac-99a0-c043a4e1bee8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	bb2736d6-257d-457f-b468-9768d5f914a5	PENDING	\N
168205c2-489b-4e62-befb-9212b6ff304e	ENRREC0043	24rec043	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	2024	8fbdc1bd-0de5-4587-ac95-c3de6b6fd80d	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9be9fac2-b619-41d4-a7ec-3d80719aff80	PENDING	\N
450e916e-edc9-4419-852d-8f652571f074	ENRREC0044	24rec044	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	2024	9878941d-4272-477c-a1e5-3989816877d2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6ba0fdda-9f57-4747-a231-d5b993340b69	PENDING	\N
75bd7049-9392-4fd1-936c-a3242e8cc2a5	ENRREC0045	24rec045	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	2024	900725e4-fb16-465c-80e2-9eb84d214130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	36ee517c-1d1a-484f-a18b-1058da31a560	PENDING	\N
cab1c05b-8ef9-4064-adfa-4e65f4513db0	ENRREC0046	24rec046	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	9c4f8ec6-54d9-40b7-918d-ef1d8e060fc5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0be4b8c9-2abf-49d9-864e-7476c593c75d	PENDING	\N
5ea3735b-975f-4897-a977-01a1618690f0	ENRREC0047	24rec047	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2	2024	b12f0510-f50d-4e56-8b1b-e5c3c83f88a3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0555c095-a3bc-495e-b9c0-da3b99cabc0b	PENDING	\N
eebed014-451a-46f2-b6c9-c8432e8f7750	ENRREC0048	24rec048	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	5c619fef-ca56-46c5-824f-83dc4a1aa6c8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4e973c34-1e5a-4882-9489-8a2fd517c45f	PENDING	\N
8f775f04-a051-4e7b-ae06-a27cbe30a865	ENRREC0049	24rec049	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	921268e1-465d-42ac-99a0-c043a4e1bee8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ba4dde73-99bc-4ae4-882c-a0cb7d6fda45	PENDING	\N
b7e523ca-140a-4446-8090-e85dc22df548	ENRREC0050	24rec050	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	2b0965be-4ba8-436c-b2bc-52c6128ca86e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f82291fd-9056-4fe8-91d4-356e5ac974bc	PENDING	\N
a706b206-c285-43b2-9020-281fa72a307d	ENRPSG0001	24psg001	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	6525ef81-09b9-4000-a046-b888ee9d7fc7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	86af07b9-e43c-4bf4-820f-c2a43a438450	PENDING	\N
13b1ca6c-5107-4b10-86fb-4dbc861c5785	ENRPSG0002	24psg002	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	16406945-3878-4378-95db-59e25607f1e0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1d6ffda6-8493-4d8e-93f5-70a15529e72e	PENDING	\N
097e8c0f-af53-4d82-8e71-388d7536afe8	ENRPSG0003	24psg003	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	d073343b-0487-44d0-b973-4aac14301ae7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2935f56b-f96f-4cfd-a801-a0786925044f	PENDING	\N
dd3f82ab-7640-4605-82d3-df3d0ad4c714	ENRPSG0004	24psg004	7a673248-c5c5-4e2c-b415-87a23736d1c7	2024	6acd19f7-3141-4487-8072-0c4313048238	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	578219b4-65d3-499a-add0-29d583aca6cb	PENDING	\N
61dd9e14-280d-4c0d-b22f-cc5dbf43b87b	ENRPSG0005	24psg005	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	c9b67b03-9261-4d5f-b4fc-00d2776cca06	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	c49884f8-6251-4076-b476-c2d9828ca3ff	PENDING	\N
832adce5-584a-45e3-9a7a-52e467a514f0	ENRPSG0006	24psg006	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	a71d9900-cdf2-4d5d-8870-2540ae2349a9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	94a10bf5-3367-4294-a236-b7e2afb1aaa3	PENDING	\N
b0330a03-a6cc-43ff-bab4-c8463cbad0e3	ENRPSG0007	24psg007	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	aed84f32-4983-42e9-88d6-2c60f87e1c53	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	07d6b1e1-8be7-4886-b77b-3a1aa1f0828d	PENDING	\N
356a81d0-73d6-490a-bdcb-1f6084730e34	ENRPSG0008	24psg008	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	d073343b-0487-44d0-b973-4aac14301ae7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f607dffa-8f9b-470e-89f7-3bef2bf815b2	PENDING	\N
5ab82f86-cd4c-4edd-97a5-592371bc9b97	ENRPSG0009	24psg009	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	9b7d471b-337e-4486-ac75-8badcd1f0cc5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1111d63c-c2b0-4114-b0d7-4b7588e14cb9	PENDING	\N
8579f9f3-a709-4ece-bdbe-0d65d881f897	ENRPSG0010	24psg010	7a673248-c5c5-4e2c-b415-87a23736d1c7	2024	71985b08-5476-45c2-ac6c-ac3eb3302935	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e1a0a768-d843-4899-b1c6-676af8aab8ff	PENDING	\N
0fb96ea7-7403-4a68-b03c-745fa59ed9b5	ENRPSG0011	24psg011	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	0fdd91c6-095c-4057-a1f5-d92a3d448fbb	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3880feaf-7461-4649-934e-61e10b7454fa	PENDING	\N
33b7f954-4596-4474-8e28-ed666030b2cb	ENRPSG0012	24psg012	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	6525ef81-09b9-4000-a046-b888ee9d7fc7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	fa7588f2-ff6c-46dc-8709-f5f9c7a0c1da	PENDING	\N
27f90f3f-d7a6-4b54-97b6-4d971824ba3c	ENRPSG0013	24psg013	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	c43884db-2d9f-41f8-9fa1-7bcde08ea780	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3ae34073-1365-43bc-a877-fe67d0018516	PENDING	\N
bb0c3a95-75d8-44a8-93d0-6dc9cf95614c	ENRPSG0014	24psg014	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	71985b08-5476-45c2-ac6c-ac3eb3302935	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a531f184-dc35-4e58-a20d-40a95e3ac89a	PENDING	\N
888a26e6-a176-44de-8384-20338aaff1a6	ENRPSG0015	24psg015	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	71985b08-5476-45c2-ac6c-ac3eb3302935	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ba9ac273-185d-4168-b445-3228679dae49	PENDING	\N
ce020559-5424-4def-9030-b468de88d52c	ENRPSG0016	24psg016	7a673248-c5c5-4e2c-b415-87a23736d1c7	2024	71985b08-5476-45c2-ac6c-ac3eb3302935	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	26126a0f-f40a-4106-a105-9014e8a11075	PENDING	\N
39d0cbaa-b30c-42f1-ba91-de53ceefa648	ENRPSG0017	24psg017	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	625c3045-78ff-4043-94e2-f85acc022ceb	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	acc39a42-a46c-4c18-a838-f955284b3eac	PENDING	\N
6a6a5644-9203-4158-9fce-e62089be689b	ENRPSG0018	24psg018	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	c9b67b03-9261-4d5f-b4fc-00d2776cca06	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b1462798-7ede-48d2-b68f-a0eeea5c2722	PENDING	\N
813f0654-b2bc-43c3-9142-381635359dcb	ENRPSG0019	24psg019	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	f4a762a1-a756-49bf-987d-2786db7902fc	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9c77f7af-8a0b-4f8e-8434-399fbac41d7c	PENDING	\N
0dee2922-64a8-4a03-ba08-08398c69b50c	ENRPSG0020	24psg020	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	625c3045-78ff-4043-94e2-f85acc022ceb	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a80b69ed-fce7-430e-817c-d58a1dee5955	PENDING	\N
aad404d0-e59f-4f29-9ba0-3ce7be7e5784	ENRPSG0021	24psg021	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	aed84f32-4983-42e9-88d6-2c60f87e1c53	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	07cbc615-3069-4638-b2d2-f9e1b243ccdb	PENDING	\N
f2c4cf97-1da3-4a14-bb7e-1ff4fa74ad83	ENRPSG0022	24psg022	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	d073343b-0487-44d0-b973-4aac14301ae7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	cbcca48e-b892-47d3-b04e-ec839ac11ded	PENDING	\N
63865441-e7b0-4594-b977-8c0910452ff9	ENRPSG0023	24psg023	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	51d56913-4592-4a74-80b8-953e3780f04c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3ef1f5b4-0a0a-490c-9e71-5c2186c48efc	PENDING	\N
54d6fab5-65ad-4612-8d3d-cb40fc3cda82	ENRPSG0024	24psg024	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	6d9ac216-04f6-4db5-b1fe-6b0ff5f534d5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d4424173-c0a6-42d0-8acc-4aaf7fe9d5f0	PENDING	\N
91302cc6-b769-473b-9901-2dd4b09857cc	ENRPSG0025	24psg025	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	d073343b-0487-44d0-b973-4aac14301ae7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	12651d3e-c466-4262-a09e-5033c84c50ab	PENDING	\N
05628c6b-33b3-404b-ad9c-6c3e82bfb854	ENRPSG0026	24psg026	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	6d9ac216-04f6-4db5-b1fe-6b0ff5f534d5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5062e6ac-9ca6-4be3-a07f-f6a973f07098	PENDING	\N
a06da390-0509-4779-a446-0c5330b1a6af	ENRPSG0027	24psg027	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	f4a762a1-a756-49bf-987d-2786db7902fc	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	cc30e11c-73b2-46df-b2b3-6029f5406c95	PENDING	\N
4f35eaa6-1991-4f4b-91a8-02a42ad77902	ENRPSG0028	24psg028	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	370c3ddc-333e-4b74-9146-54e9e5bfe73b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	18bd30a9-fc60-4808-ad25-4f190c2fa61e	PENDING	\N
dda432fd-a6cc-41ef-bedc-d2b4eb30dddf	ENRPSG0029	24psg029	7a673248-c5c5-4e2c-b415-87a23736d1c7	2024	a71d9900-cdf2-4d5d-8870-2540ae2349a9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5467fb87-aff6-4fb4-a085-9244cebd6175	PENDING	\N
7cf72462-b57e-4437-9c07-c342a9aaee59	ENRPSG0030	24psg030	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	625c3045-78ff-4043-94e2-f85acc022ceb	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6fc238cb-b0df-4b19-94ab-35567c36376e	PENDING	\N
53d33802-006f-4384-8357-ad2b07747a95	ENRPSG0031	24psg031	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	9b7d471b-337e-4486-ac75-8badcd1f0cc5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5c505faa-1d9a-4b44-9a47-7747e093a8fe	PENDING	\N
dc8a5ae0-407a-4657-9311-48d6a9c32cda	ENRPSG0032	24psg032	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	0fdd91c6-095c-4057-a1f5-d92a3d448fbb	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	307a8d63-07f7-480e-9ffd-b5f94203e1f7	PENDING	\N
5bf7b8ae-f292-4ce4-b842-be366a30e10b	ENRPSG0033	24psg033	7a673248-c5c5-4e2c-b415-87a23736d1c7	2024	c9b67b03-9261-4d5f-b4fc-00d2776cca06	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	cbb8f1ee-7252-48cf-8f7d-68d3948c91e1	PENDING	\N
4861a414-f3a9-4d12-bca7-24b120580853	ENRPSG0034	24psg034	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	f4a762a1-a756-49bf-987d-2786db7902fc	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	30d8ecd4-1225-48b4-9e66-1cf3b94f17d5	PENDING	\N
d38817b4-473d-48e6-84e4-14011255aa51	ENRPSG0035	24psg035	7a673248-c5c5-4e2c-b415-87a23736d1c7	2024	f4a762a1-a756-49bf-987d-2786db7902fc	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	df8d15cd-eaf3-4d63-b041-6a0ce1cfae27	PENDING	\N
64bd08da-6d70-43b8-b327-1b929f1c040b	ENRPSG0036	24psg036	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	6d9ac216-04f6-4db5-b1fe-6b0ff5f534d5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f3aab9d7-37a1-4775-9ae4-1b773b0db693	PENDING	\N
84e6e999-062b-44f5-bab6-8cf501435c95	ENRPSG0037	24psg037	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	6d9ac216-04f6-4db5-b1fe-6b0ff5f534d5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	910f17f9-2b10-4612-b81e-228f81a7c33e	PENDING	\N
d8f91407-2f00-48d0-8688-2a696c43dc09	ENRPSG0038	24psg038	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	c43884db-2d9f-41f8-9fa1-7bcde08ea780	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	81a72f27-0042-44f4-9ba4-dab609517b66	PENDING	\N
42e51291-cfc2-476c-beaf-aaabcf36d1d2	ENRPSG0039	24psg039	7a673248-c5c5-4e2c-b415-87a23736d1c7	2024	f4a762a1-a756-49bf-987d-2786db7902fc	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	62300d24-7969-4ffc-a726-532a72326e5f	PENDING	\N
6a141bae-2bb3-4c93-8286-f6b0edf5a67a	ENRPSG0040	24psg040	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	6525ef81-09b9-4000-a046-b888ee9d7fc7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b3f9a806-e342-45f5-b544-073d71d17b2d	PENDING	\N
88ffe32c-c6d1-4614-9156-ad0b59707e68	ENRPSG0041	24psg041	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	4dff792e-56c7-44c2-a85c-9b2d69737f8d	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	fe8a0be2-f2fb-44a5-ad96-c87629aca4de	PENDING	\N
0e049a51-c589-442f-9613-46412f616824	ENRPSG0042	24psg042	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	c43884db-2d9f-41f8-9fa1-7bcde08ea780	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8ba2005f-1a8e-43d8-b5f9-0f5ea6dc9e2e	PENDING	\N
5fe9e1d9-4c5b-47f7-ae09-1f8aa81973b1	ENRPSG0043	24psg043	7a673248-c5c5-4e2c-b415-87a23736d1c7	2024	6525ef81-09b9-4000-a046-b888ee9d7fc7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3d3ea2b7-5e56-49a5-afcd-9b81dfebfbd8	PENDING	\N
5d22bc54-7d3f-4e86-bbf9-bdf7f0bf97bb	ENRPSG0044	24psg044	7a673248-c5c5-4e2c-b415-87a23736d1c7	2024	7888be9a-22c2-4f69-9492-90eff8bcaff4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1523bbd1-8870-40c1-a8e3-9f877df00bbb	PENDING	\N
2ab66a75-b1b2-4189-a415-67db5f20ba5b	ENRPSG0045	24psg045	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	7a7e2e74-0530-4a6a-90ef-f6e94ff1af19	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7bd2e20a-bc9c-4d72-a01c-e0224c89724e	PENDING	\N
b87b1f07-67b7-4462-ae93-0be47fe3ead2	ENRPSG0046	24psg046	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8	2024	16406945-3878-4378-95db-59e25607f1e0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b5dfe186-acce-4de9-8697-2306fd0f72df	PENDING	\N
e315016a-f6e9-4838-8b29-a441c14fa7eb	ENRPSG0047	24psg047	465f3c25-3d78-470c-8a36-522aa9ec11cf	2024	625c3045-78ff-4043-94e2-f85acc022ceb	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3749f029-1672-4af7-bf3a-e7989d858eea	PENDING	\N
32699670-1f97-4955-b471-b303934ef223	ENRPSG0048	24psg048	7a673248-c5c5-4e2c-b415-87a23736d1c7	2024	16406945-3878-4378-95db-59e25607f1e0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	c8a0260d-4899-4e7c-af32-12c13809481a	PENDING	\N
e18c2438-d8a3-44c2-b035-aa2cca1f75d7	ENRPSG0049	24psg049	7a673248-c5c5-4e2c-b415-87a23736d1c7	2024	71985b08-5476-45c2-ac6c-ac3eb3302935	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d7fce711-cbb0-48a0-9464-e4dd9c99a0a1	PENDING	\N
08c5f162-d73b-49f7-b265-680735cb98b5	ENRPSG0050	24psg050	7a673248-c5c5-4e2c-b415-87a23736d1c7	2024	0fdd91c6-095c-4057-a1f5-d92a3d448fbb	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d8c26750-cfc7-4ab2-8bbf-b350bada23e8	PENDING	\N
2529945b-60e5-4816-9e66-3a3b2e719289	ENRSSN0001	24ssn001	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	b32bc62b-1df3-4c7c-8663-8556df825a93	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	931a72e1-96f2-43c2-8371-3ad07ae8df35	PENDING	\N
f41bc048-17d5-4a2f-900e-7112f3dd963f	ENRSSN0002	24ssn002	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	fd9c14e2-6b61-46c9-85a6-c55f533a6cb8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	495c0e27-138d-4c2f-837c-39946bdf805f	PENDING	\N
ecc232b4-8e89-48bb-b91b-9238dbf0a814	ENRSSN0004	24ssn004	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	2024	cdfd03ec-b86f-4fdc-9545-589a1dd38e6a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	aeaff253-93db-417c-8275-b369914bed2d	PENDING	\N
e6272156-ea99-4531-bce7-b1f278421328	ENRSSN0005	24ssn005	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	2024	a8f899d7-9a3f-4c82-bceb-cefea8da4d23	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	76eebacb-df87-4003-b8ce-3fd263625895	PENDING	\N
35645d6f-bdc1-49f9-b369-4d24d790b045	ENRSSN0006	24ssn006	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	b32bc62b-1df3-4c7c-8663-8556df825a93	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3fc55bdb-154c-43bc-9abf-d8ec3d855d39	PENDING	\N
149068f7-7e3a-445a-8f41-c493e0021cba	ENRSSN0007	24ssn007	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	2024	9c3c6feb-6cd3-4278-9ef8-48cdc6252d6e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0294a4f9-0d04-4910-ac52-0e2779ea1c4c	PENDING	\N
9d6db31c-418e-41b8-81f1-a3867e9e27f1	ENRSSN0008	24ssn008	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	30674af4-b99d-4224-95a3-224ef4f3b908	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8506cb51-8d2b-49cf-8a16-c17781c825ec	PENDING	\N
7aa4adc5-208e-4bd9-8b32-53260d6b9651	ENRSSN0009	24ssn009	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	fd9c14e2-6b61-46c9-85a6-c55f533a6cb8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	c0fd8f8c-a36f-42d9-a41a-3943f931c1c9	PENDING	\N
3e739f2a-f218-409e-8f6b-04fb98a3ff6a	ENRSSN0010	24ssn010	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	2024	46c69628-005b-4d3e-933e-6563db97a16e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	48c0c9b4-5e46-4bb2-8617-36f30f477804	PENDING	\N
a0f50e7b-ff31-4aba-8204-ffba7ee537bd	ENRSSN0011	24ssn011	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	2024	7464c4ab-5300-4e1a-8387-99cfb66f8cb6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	104a8208-48ce-4e54-9e20-c81a59ef933a	PENDING	\N
6a327570-e5f3-4a3b-9519-f93a0bcae508	ENRSSN0012	24ssn012	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	c9b1ad24-0f39-4373-abd1-4accf0285e88	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	05694f83-ba25-4e7a-a95a-9249174d7d9b	PENDING	\N
b72f1fca-7143-4e64-8729-9db35c1debc6	ENRSSN0013	24ssn013	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	2024	a4e5c26f-cec7-40d2-af91-e85f78fe786e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d1faf32b-85ad-4cf6-b2b3-294ff603d121	PENDING	\N
2692f4e1-27f2-436a-a13c-e209338eb65e	ENRSSN0014	24ssn014	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	2024	edb8b7cf-06b6-4b46-b294-da57c2a04c47	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	07100006-b058-46ac-9796-a5d41caf0f20	PENDING	\N
75c430fa-4a23-4094-97fb-2b02a1f238a8	ENRSSN0015	24ssn015	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	2024	95cbb2d5-fb1d-4697-8881-264243d44927	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	dc775fcc-86b4-405b-b15a-b5f151d2f321	PENDING	\N
8ec0b9b8-1964-45d7-b8a5-b38e07d5424a	ENRSSN0016	24ssn016	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	2024	c9b1ad24-0f39-4373-abd1-4accf0285e88	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2f80a81f-cf30-449a-b8c8-e8d1065cd248	PENDING	\N
92874652-f3e3-450a-be39-2c92970fcb98	ENRSSN0017	24ssn017	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	2024	0b0cee44-6401-4f79-96d1-1f51e8cc132f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	615d5705-ba4b-46d1-88a1-c364e3ef913b	PENDING	\N
e310d997-30e7-41ef-98ec-9a5357ae4a11	ENRSSN0018	24ssn018	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	a4e5c26f-cec7-40d2-af91-e85f78fe786e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6730d6fd-ab75-4b35-bdc0-67be6638dfcf	PENDING	\N
c84f1041-7061-4538-a548-abb978b06f1a	ENRSSN0019	24ssn019	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	2024	ec4c432f-1a2d-471d-8eec-de1109cea984	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f441701a-e381-4c95-8f21-59cfb950e0c9	PENDING	\N
14b0e47f-f090-4bd4-b187-a9c39f061f1f	ENRSSN0020	24ssn020	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	ec4c432f-1a2d-471d-8eec-de1109cea984	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2d122dc7-c868-42cd-8baa-6fbf126679b6	PENDING	\N
61673962-df2d-413b-81d1-e6a0ef3c05f4	ENRSSN0021	24ssn021	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	2024	b63d9346-43e6-47a0-b7e7-dc6e5a062528	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	396c675e-5bb8-4a49-96fc-e2c149da1e3f	PENDING	\N
5987b2b3-99a2-49a4-a599-954784931aaf	ENRSSN0022	24ssn022	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	b32bc62b-1df3-4c7c-8663-8556df825a93	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6a21cc85-02c8-4b3d-b309-275115914246	PENDING	\N
5b65ab34-7122-41ed-810c-d6f1b5bda905	ENRSSN0023	24ssn023	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	2024	a4e5c26f-cec7-40d2-af91-e85f78fe786e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4f3a38cd-6ca4-4541-a32d-527357a940ea	PENDING	\N
995fd8ae-7c21-4472-a138-94dff118a625	ENRSSN0024	24ssn024	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	0b0cee44-6401-4f79-96d1-1f51e8cc132f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7e5c45db-c6fe-4709-9bc0-326ac37a7d63	PENDING	\N
fd382a69-dd9a-4ab8-99d8-52981cb3a8be	ENRSSN0025	24ssn025	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	2024	b2e0b191-8940-4c11-8c45-73bc8982b77e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	527eff8d-96a4-40a3-bf62-04f5ac416d9b	PENDING	\N
663eab20-27e6-45b5-85a3-bca85724ca83	ENRSSN0026	24ssn026	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	2024	9c3c6feb-6cd3-4278-9ef8-48cdc6252d6e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0b322ab3-5bfd-42da-bd77-131101dc4c40	PENDING	\N
f90c652d-2157-4c53-aae4-1faf62ce1d37	ENRSSN0027	24ssn027	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	30674af4-b99d-4224-95a3-224ef4f3b908	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	94306870-59e1-4ca3-a0f3-df135f723a35	PENDING	\N
116dfc18-08a9-4e8b-855e-c9997c9ca214	ENRSSN0028	24ssn028	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	2024	9c3c6feb-6cd3-4278-9ef8-48cdc6252d6e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d8c28ef3-1dfa-4477-a8c8-48055748a3e2	PENDING	\N
8460a887-1405-4bf4-9640-9e97dded7ba6	ENRSSN0029	24ssn029	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	5209baa7-28bd-4d33-bc02-b3f3dd59f71f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	64263656-bd27-4ee8-8338-12c9dae02661	PENDING	\N
928c6b8f-748b-4149-ad64-0c0f4d1c77eb	ENRSSN0030	24ssn030	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	2024	b63d9346-43e6-47a0-b7e7-dc6e5a062528	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7fc088ef-52a5-4df4-befa-83ccafd89e1c	PENDING	\N
c890166c-60e0-4e22-a7e4-48f68e7c0563	ENRSSN0031	24ssn031	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	2024	fd9c14e2-6b61-46c9-85a6-c55f533a6cb8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	526b70fe-6f4a-43f5-8ef8-88c09b930cb4	PENDING	\N
c2609d0e-8bbb-491c-b020-d5623a3be330	ENRSSN0032	24ssn032	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	2024	ee7443d1-2af4-4e8a-a2c4-077770a804fc	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3a848254-38d0-4556-9c0c-5c55858dc1be	PENDING	\N
bbac4295-78e0-488b-b2b4-1e32767a70d8	ENRSSN0033	24ssn033	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	cdfd03ec-b86f-4fdc-9545-589a1dd38e6a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	de41cb04-f9db-41d2-96c8-cc0e24438247	PENDING	\N
a929661f-f7ed-4680-b42c-6059c56131a2	ENRSSN0034	24ssn034	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	2024	c9b1ad24-0f39-4373-abd1-4accf0285e88	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	aefc2a8f-9e7f-4523-9613-03c072b59b43	PENDING	\N
d24a6124-e918-437d-9533-140eae12d152	ENRSSN0035	24ssn035	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	cdfd03ec-b86f-4fdc-9545-589a1dd38e6a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4d8888ab-700b-4b2c-a7c6-a7d4ad6dc374	PENDING	\N
f0757d96-8896-484d-a7dd-0f9560265f5b	ENRSSN0036	24ssn036	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	02f9621f-f810-404d-9ecf-3d62549e9be2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	807f426c-d227-438d-a4a5-968a797182ed	PENDING	\N
f6606c0f-6feb-46ce-bebd-c442cd7b1b5f	ENRSSN0037	24ssn037	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	c9b1ad24-0f39-4373-abd1-4accf0285e88	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f8d07d46-9321-4fdc-b3a1-00f1732605df	PENDING	\N
37cfc757-62f5-40cf-ac1a-281f1665c676	ENRSSN0038	24ssn038	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	2024	5209baa7-28bd-4d33-bc02-b3f3dd59f71f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a13165b2-3271-499e-81a9-64387d0f5e2e	PENDING	\N
5855785c-0339-45d1-b756-b22b33572c0a	ENRSSN0039	24ssn039	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	edb8b7cf-06b6-4b46-b294-da57c2a04c47	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	29695ec7-c9a2-426e-9514-4ff249aaa748	PENDING	\N
601210ab-c0b7-469a-9f59-3af956a80d11	ENRSSN0040	24ssn040	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	2024	95cbb2d5-fb1d-4697-8881-264243d44927	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4b7fbb11-3fa6-4b1a-8a97-40c4caf6e417	PENDING	\N
f222637d-576b-484f-be3a-fe240becf9f8	ENRSSN0041	24ssn041	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	2024	9c3c6feb-6cd3-4278-9ef8-48cdc6252d6e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	eb3e59de-a2fe-4ed2-8aff-13fe61b9c6f8	PENDING	\N
899c9576-50a6-4593-9ade-96ddf984fa6f	ENRSSN0042	24ssn042	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	2024	a4e5c26f-cec7-40d2-af91-e85f78fe786e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	00dc09c8-cb81-42fe-9805-266608ee18f1	PENDING	\N
2754de4c-8e31-473a-ad21-b9ad5d5bd832	ENRSSN0043	24ssn043	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	fd9c14e2-6b61-46c9-85a6-c55f533a6cb8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e5e0516b-88f8-423b-a511-df1c8fa955e3	PENDING	\N
3020a5bd-efef-46d3-87d7-0fa8ba467f25	ENRSSN0044	24ssn044	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	9c3c6feb-6cd3-4278-9ef8-48cdc6252d6e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	13f2150f-f795-4143-83c6-0a8bcb35c24a	PENDING	\N
4eff22cf-d2a4-472d-b010-8baf28bf657d	ENRSSN0045	24ssn045	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	2024	fd9c14e2-6b61-46c9-85a6-c55f533a6cb8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	c7162a4d-a8dd-4223-8656-1c8633503464	PENDING	\N
f8b67a9e-2cbf-453b-8868-19e379eed4ec	ENRSSN0046	24ssn046	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	2024	ec4c432f-1a2d-471d-8eec-de1109cea984	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2b8f6869-92e1-4400-a688-61b6e2b81254	PENDING	\N
1e0f154d-1fc7-425b-bb46-b1fb91fc69c5	ENRSSN0047	24ssn047	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	95cbb2d5-fb1d-4697-8881-264243d44927	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	694f1c35-67ab-405c-985d-ac3a2b86901d	PENDING	\N
99410e75-3803-48c9-9728-de536adc804b	ENRSSN0048	24ssn048	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524	2024	28f913a1-1721-4040-b75a-a4454ef3268b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	06561399-aaa9-4f6c-8968-c5643d0c753f	PENDING	\N
22a78617-9376-4cb8-a4bb-d102ddacd98a	ENRSSN0049	24ssn049	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	95cbb2d5-fb1d-4697-8881-264243d44927	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1891dac9-5a83-41c4-b2ef-1e2fd52e22f2	PENDING	\N
d96681c1-44f1-46d4-b69a-539039abf323	ENRSSN0050	24ssn050	86d13a7e-9125-4d91-828c-9cca4d31bace	2024	edb8b7cf-06b6-4b46-b294-da57c2a04c47	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	333a7c8f-51be-44c7-bc25-2ff9982a8a5d	PENDING	\N
39a7fe44-33ea-4d2f-b35d-b7497f67298e	ENRVIT0001	24vit001	70cc658f-2433-455a-a096-c6a6e8549fb2	2024	a1b0b349-e690-4a53-87d5-9da8b9241569	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	69d4993f-2ee3-46f8-841e-1c46bfdfd990	PENDING	\N
0cdd724e-26ac-4576-a2e7-19ba68c2b4f4	ENRVIT0002	24vit002	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	3c8de4ab-6b56-4431-8a42-a8c9127a7400	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d69f110a-5902-4514-bab6-05583ac9c978	PENDING	\N
2f4b86fc-c12e-4272-bca2-29b8e2e296f9	ENRVIT0003	24vit003	70cc658f-2433-455a-a096-c6a6e8549fb2	2024	a1b0b349-e690-4a53-87d5-9da8b9241569	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	db17db99-8a54-42bd-8354-c40944307594	PENDING	\N
2d24a7b4-cd80-4e5d-9c83-c9cce59a696d	ENRVIT0004	24vit004	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	5ccc0f45-a8dc-4aa4-bad5-95810b921e03	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	dfa2b8aa-7d15-4e17-bd6a-8ceb5e90cf01	PENDING	\N
e93cc718-f45a-4af4-8147-4c4d9448fcfb	ENRVIT0005	24vit005	70cc658f-2433-455a-a096-c6a6e8549fb2	2024	5ccc0f45-a8dc-4aa4-bad5-95810b921e03	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	51d3dbd9-262f-44b5-91d5-b618e6f657a2	PENDING	\N
7770dfaa-b9dd-4dfc-a7f7-7bc8910e6dcf	ENRVIT0006	24vit006	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	ef32be91-a1b1-4db7-8a1e-3786f444d760	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	05577e83-d0ca-42b3-97b6-76089ce305a3	PENDING	\N
d01f4c88-909e-4462-8463-acd67faba4ba	ENRVIT0007	24vit007	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	2024	6eb8e6b8-da8d-4e40-88b0-00a2c6d2cccc	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	17c7ad29-5c6d-42ce-a964-1b1601bc32b5	PENDING	\N
2da7984e-22b8-44f4-89b1-de02630f631a	ENRVIT0008	24vit008	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	a42e71f9-1e90-4cc2-81c4-1c1184ffccf4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a235a2f2-6ddf-4988-bf09-11b1a273a192	PENDING	\N
07c23644-2fa6-4f9f-9216-15f016be0af8	ENRVIT0009	24vit009	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	14001f46-164a-43ce-b31c-69edfce2ead3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ace326ce-a387-42b5-b606-cd54730512b5	PENDING	\N
dbd29a50-37f5-442c-9e6b-b4096302c8be	ENRVIT0010	24vit010	70cc658f-2433-455a-a096-c6a6e8549fb2	2024	571ecbe1-44a2-482f-b01b-94135f6217e4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9da29b6d-1c87-4b0e-a53f-d5041ce4264b	PENDING	\N
c2856db6-3f99-423f-a053-8629eb47ecf3	ENRVIT0011	24vit011	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	ba86f77a-4fed-41a1-b209-32969425869c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6a981fa5-0815-4d6b-ac27-a0719fe5b99d	PENDING	\N
91e445fe-306f-46bd-8a63-9ea158e0ef9c	ENRVIT0012	24vit012	70cc658f-2433-455a-a096-c6a6e8549fb2	2024	7c1e139a-c932-481f-be55-cab2c6f9f3aa	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	443ede2b-9dfc-4262-aeaa-92f7c66ae9b3	PENDING	\N
28bb6d85-16e6-4e29-bb87-6f6d2263a576	ENRVIT0013	24vit013	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	2024	14001f46-164a-43ce-b31c-69edfce2ead3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5300ecfe-262a-4aaa-8780-9edf1d27b646	PENDING	\N
cb3cd778-a185-4007-94ab-0be1a593dda3	ENRVIT0014	24vit014	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	2024	571ecbe1-44a2-482f-b01b-94135f6217e4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1418bda2-ad25-460e-9058-ef883bc94a11	PENDING	\N
6bdbb26e-2adc-49dd-9651-f4cf7ca4495d	ENRVIT0015	24vit015	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	ba86f77a-4fed-41a1-b209-32969425869c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0d8221bd-d801-42fb-9028-15de64cfc182	PENDING	\N
7cb91386-5134-436b-a99d-427c0defed94	ENRVIT0016	24vit016	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	2024	ba86f77a-4fed-41a1-b209-32969425869c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b1797a8f-2358-4b5d-bd7e-84842f2d7948	PENDING	\N
113afb99-e0de-41d8-a581-851912f74aef	ENRVIT0017	24vit017	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	2024	a42e71f9-1e90-4cc2-81c4-1c1184ffccf4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8a1580bb-a7c3-4a31-849d-6154d64f7c79	PENDING	\N
e4d06e66-206b-4312-88c6-39e0607d53e7	ENRVIT0018	24vit018	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	2024	8c74d6c7-2a8f-4723-8134-d269b411b286	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5c30aa05-8998-4f4a-9f5b-bd017fd5543b	PENDING	\N
e1fe31b5-418a-408f-8a2b-ab81efac9372	ENRVIT0019	24vit019	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	97c3a8e7-839f-4a76-990b-5672f43d9f3c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	344de262-74cb-4c57-a4d5-062aa31867bb	PENDING	\N
0e88345c-4614-4391-a4cb-087b5b4a8766	ENRVIT0020	24vit020	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	2024	8d1cdcf9-c0b5-47c9-8c37-98b45373d025	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	827a318f-4be2-46d7-a446-3fc5d244fde3	PENDING	\N
a5486d8d-8105-4d3a-ad6f-9aa50b76b293	ENRVIT0021	24vit021	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	51a535de-f0bf-413a-bbf0-8962625b610b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a4dbbca8-4caa-40ee-92cc-a81382a23b12	PENDING	\N
f99d4f32-4017-4203-99c1-e8d43379ccd2	ENRVIT0022	24vit022	70cc658f-2433-455a-a096-c6a6e8549fb2	2024	3c8de4ab-6b56-4431-8a42-a8c9127a7400	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	327a82d9-872a-4633-a8f8-e7ef6ebb5303	PENDING	\N
8a2c6956-d29c-48b0-8b64-9360a623e05d	ENRVIT0023	24vit023	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	8c74d6c7-2a8f-4723-8134-d269b411b286	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	bc345202-2751-49b4-84a0-962b6fc781e4	PENDING	\N
a6134de7-ad87-4c75-ac98-2cc44fd84442	ENRVIT0024	24vit024	70cc658f-2433-455a-a096-c6a6e8549fb2	2024	ef32be91-a1b1-4db7-8a1e-3786f444d760	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	46e1798c-67dc-43a3-9dd7-3ee55b489266	PENDING	\N
7786f3e2-2430-41ce-baaa-ab23089e20b7	ENRVIT0025	24vit025	70cc658f-2433-455a-a096-c6a6e8549fb2	2024	6eb8e6b8-da8d-4e40-88b0-00a2c6d2cccc	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	66d850b8-1d26-48b6-89ab-0366ebaf9d7c	PENDING	\N
4021a80f-0121-4c56-80d2-e679adf83347	ENRVIT0026	24vit026	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	8c74d6c7-2a8f-4723-8134-d269b411b286	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2afb14a2-e36b-4fa5-b2f8-5c11eb7fbfdb	PENDING	\N
95d4aad0-4edb-4ff2-b4a3-1bb6ba2c765e	ENRVIT0027	24vit027	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	a1b0b349-e690-4a53-87d5-9da8b9241569	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	696428ab-6da9-498f-bd3f-84ef2a84d705	PENDING	\N
965ee92e-90bc-4429-bf52-723051e39e91	ENRVIT0028	24vit028	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	2024	8d1cdcf9-c0b5-47c9-8c37-98b45373d025	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d61f0304-283f-4af1-afd2-3ed33f850015	PENDING	\N
873bc9db-0852-4f87-a6d6-17fc261cba7b	ENRVIT0029	24vit029	70cc658f-2433-455a-a096-c6a6e8549fb2	2024	10a27953-6269-478e-9053-97cf076ca514	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	c7698609-dbdc-433b-8df8-72c6126c5a78	PENDING	\N
1b380eb0-9a08-4a9d-95a3-d4201d12016e	ENRVIT0030	24vit030	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	8d1cdcf9-c0b5-47c9-8c37-98b45373d025	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	bd55e758-edd6-43c9-9a5b-c9abbd8cfffe	PENDING	\N
08a1032a-5bd8-4082-80bf-06949cdaa47b	ENRVIT0031	24vit031	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	2024	3c8de4ab-6b56-4431-8a42-a8c9127a7400	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	cc2db805-e38a-44e7-b7ab-029f273631ac	PENDING	\N
c2ab3355-c251-4745-ad4e-71783709d874	ENRVIT0032	24vit032	70cc658f-2433-455a-a096-c6a6e8549fb2	2024	97c3a8e7-839f-4a76-990b-5672f43d9f3c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	77e47437-fc0e-4188-8093-77a2946bec8c	PENDING	\N
3931aa5c-90c5-4a9d-ae31-24e235ce6e33	ENRVIT0033	24vit033	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	8c74d6c7-2a8f-4723-8134-d269b411b286	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	81b1a1da-5f71-4b31-8895-f4cfb76e127d	PENDING	\N
348031ee-3a52-41c7-86c5-4bd27ebbc7bf	ENRVIT0034	24vit034	70cc658f-2433-455a-a096-c6a6e8549fb2	2024	8d1cdcf9-c0b5-47c9-8c37-98b45373d025	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	11069055-a27d-4ede-8e9a-8cc2c4a8048b	PENDING	\N
68093b8b-e3e7-49f0-b84a-705514e27a7c	ENRVIT0035	24vit035	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	2024	51a535de-f0bf-413a-bbf0-8962625b610b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3b604b9e-3965-4a09-91ac-c919a548ea5f	PENDING	\N
33aab51c-6650-4241-8327-c71a78994769	ENRVIT0036	24vit036	70cc658f-2433-455a-a096-c6a6e8549fb2	2024	a1b0b349-e690-4a53-87d5-9da8b9241569	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1af3b3e3-71b0-4305-b8ae-630a7474c39a	PENDING	\N
05af0740-f3d0-4284-9880-a175f0bce1d8	ENRVIT0037	24vit037	70cc658f-2433-455a-a096-c6a6e8549fb2	2024	a42e71f9-1e90-4cc2-81c4-1c1184ffccf4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1286ab19-ea4e-444d-a755-5993c0c4d82d	PENDING	\N
3e27c29b-9130-4710-baf5-1a98c9ae775b	ENRVIT0038	24vit038	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	2024	278c10a1-ab7a-421e-9d64-632253d2ca86	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	130f6cbe-6259-4b1f-9d75-a2d56e96b0e7	PENDING	\N
787af013-9ea0-4572-8e12-5ff74f339487	ENRVIT0039	24vit039	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	95e8a58c-c7bb-4670-9c1a-98548c58c79b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1729f1d2-a1bd-4309-9f24-216f27907e62	PENDING	\N
b3db9bb5-5594-43d5-a175-4e79be62860f	ENRVIT0040	24vit040	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	2024	278c10a1-ab7a-421e-9d64-632253d2ca86	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	87d3bbf1-5edc-48b6-9cd2-adcf23d85780	PENDING	\N
b3497f27-efe8-4b99-a05d-4f8fa8b5d2a9	ENRVIT0041	24vit041	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	571ecbe1-44a2-482f-b01b-94135f6217e4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0b85ce94-6975-42d2-86f2-536988ccbd54	PENDING	\N
53965429-d334-43fa-afa5-71704950db47	ENRVIT0042	24vit042	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	2024	ef32be91-a1b1-4db7-8a1e-3786f444d760	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	060d8dd6-d5dd-4b4b-baa5-552753b5cc8c	PENDING	\N
bdfcc577-9d60-4e75-8312-de417981bf3f	ENRVIT0043	24vit043	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	2024	278c10a1-ab7a-421e-9d64-632253d2ca86	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4736b07f-059f-456f-855d-076e591f3cb3	PENDING	\N
b61cd563-dd64-4185-bf3b-8d20d78eefe7	ENRVIT0044	24vit044	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	3c8de4ab-6b56-4431-8a42-a8c9127a7400	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2888a52c-5c4c-40fa-9d3c-9f71e3c3ea6c	PENDING	\N
07d0719b-156c-4818-8dee-517c14ae04ca	ENRVIT0045	24vit045	70cc658f-2433-455a-a096-c6a6e8549fb2	2024	571ecbe1-44a2-482f-b01b-94135f6217e4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8fefebad-b757-48ca-8f1e-63de232802f8	PENDING	\N
dad75074-d244-4bc7-9ab8-11c21b167f08	ENRVIT0046	24vit046	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	51a535de-f0bf-413a-bbf0-8962625b610b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e58e4263-f2f7-4a56-838a-70c258bfe299	PENDING	\N
6122e3be-ab95-41a7-aa1a-65fdf5b99b1e	ENRVIT0047	24vit047	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	2024	ba86f77a-4fed-41a1-b209-32969425869c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f146cb90-1550-46c3-abf0-8a1ac17296ec	PENDING	\N
40862d86-31ce-4b29-8853-f84f2db9b825	ENRVIT0048	24vit048	c7ae4601-26af-4a7b-b93a-74a6c994dc09	2024	5ccc0f45-a8dc-4aa4-bad5-95810b921e03	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f66c34ff-2875-4956-bc51-1255d25528c8	PENDING	\N
5c1f3fd3-ef7d-4237-8493-55a68637c0bd	ENRVIT0049	24vit049	70cc658f-2433-455a-a096-c6a6e8549fb2	2024	10a27953-6269-478e-9053-97cf076ca514	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	77db2314-1bc9-4f0c-99ed-fa27047f0838	PENDING	\N
567d2fe8-84c4-48c2-85e2-00d2abda15c4	ENRVIT0050	24vit050	ea6eef8e-8870-41e6-af5c-9d0dd4eea549	2024	a42e71f9-1e90-4cc2-81c4-1c1184ffccf4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b0c3ed55-a68a-445e-ae9a-95858ac66021	PENDING	\N
a0ac4e29-7283-4453-a561-801660c62232	ENRAU0001	24au001	13d08e92-605e-4739-a74b-9da33dc59ce6	2024	969ea4f6-3ea6-4a2f-94a2-2013269c4f03	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	22a6f499-d94c-4121-a7be-251155485ebc	PENDING	\N
ba1bb061-ad0b-491f-8c0f-ad2a5e42b125	ENRAU0002	24au002	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	fa306c1d-1af4-4f96-ba59-61ce4f4b5dda	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a56c89b9-dc05-4986-910a-b18c5355df35	PENDING	\N
6e8542af-4521-4103-966a-515bc93b146c	ENRAU0003	24au003	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	113ab573-7e12-4f5d-92e1-4e1fba18d20b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a31a8aa0-0cfd-450b-923d-3c1de5da3f6e	PENDING	\N
b00136e4-3b90-4b33-9413-096707450cb1	ENRAU0004	24au004	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	5625a2f4-8e90-471f-9e6c-834cedf04a99	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	44855d88-adf8-454a-b329-8ad978cd5763	PENDING	\N
ca887d00-ccf2-4a21-8277-2eff295fbad9	ENRAU0005	24au005	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	1113251d-ab4b-4441-9510-ed161b4df79e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	870ee5b1-de06-425f-b608-b8bda7805924	PENDING	\N
079c6ac3-23ee-4b34-ab46-38f726bd8b5f	ENRAU0006	24au006	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	680bc756-a4a7-457d-95d1-f151b6995665	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	acf57385-5464-4b30-8731-02385c600272	PENDING	\N
f56aa239-a002-487a-a3c2-896e976f05d5	ENRAU0007	24au007	13d08e92-605e-4739-a74b-9da33dc59ce6	2024	5625a2f4-8e90-471f-9e6c-834cedf04a99	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9bffd8ea-81c8-47cd-995c-d9b708889ad1	PENDING	\N
0d00b7d4-1b71-4306-b066-27d6257ab842	ENRAU0008	24au008	13d08e92-605e-4739-a74b-9da33dc59ce6	2024	5c3785e8-f022-454b-8d2e-5eaba53c847b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	983a2487-44f8-4f26-bc6e-e208d5a0b93f	PENDING	\N
6951a74b-183f-43f6-af2b-3c370dc6bd6a	ENRAU0009	24au009	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	b5086141-15d2-4c9a-ad36-1f6d72c644d1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b0aecd27-97b4-46a7-8e8e-81bad8f93ef5	PENDING	\N
49258256-ea55-42cf-9ffa-e3dc02f6a66f	ENRAU0010	24au010	13d08e92-605e-4739-a74b-9da33dc59ce6	2024	65efe612-317f-484c-9889-1afd3cf176d9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a3677105-2122-40d8-807c-496ca2fa967f	PENDING	\N
5b5703b9-bec9-4c42-8c93-1ec5fb40aee6	ENRAU0011	24au011	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	4b2d4b61-9b32-455c-bc24-a136d23c2f56	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3f27c9ac-4427-40d1-ad30-36a6a2c49aef	PENDING	\N
7304b00c-0580-4d0b-a289-35a44fb4e7ee	ENRAU0012	24au012	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	b5086141-15d2-4c9a-ad36-1f6d72c644d1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	cd3b2cc1-d170-4f50-a69f-fdf8139149a6	PENDING	\N
149a761b-f289-4684-a181-87389ecdffe5	ENRAU0013	24au013	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	b5086141-15d2-4c9a-ad36-1f6d72c644d1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	c2890cf5-900c-4b0f-a9d4-feb54ab8befb	PENDING	\N
19c391fe-a0ba-4161-9353-8db872a4c73e	ENRAU0014	24au014	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	113ab573-7e12-4f5d-92e1-4e1fba18d20b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6db01a21-f18f-4e09-88fc-7b4e6f6f487a	PENDING	\N
83b4c898-a8c4-4eaa-935c-739894c66666	ENRAU0015	24au015	13d08e92-605e-4739-a74b-9da33dc59ce6	2024	fa306c1d-1af4-4f96-ba59-61ce4f4b5dda	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	df69c493-6c97-47fe-ac75-02c6f2155fb8	PENDING	\N
bff9341d-42a1-4524-9c26-326a8160f013	ENRAU0016	24au016	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	baafec5b-7de3-41bd-b15e-c1b46166f78c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1d8ca995-6601-4caf-b99a-39cb8187339a	PENDING	\N
00671688-79bd-4649-8a79-704c7702ce73	ENRAU0017	24au017	13d08e92-605e-4739-a74b-9da33dc59ce6	2024	82cc0f31-e120-4f70-9293-5e391b6fdc28	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9d0337b6-0784-4de3-9601-8e92db6cc2d5	PENDING	\N
11b75cd9-ad5b-4cb1-b50f-6a70ce1d3755	ENRAU0018	24au018	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	cb7e245f-e0d5-4317-b47b-0ea2e49424c3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ec84aafb-f557-4d26-9f5c-4d245214a5f1	PENDING	\N
0fa9c178-02e0-4430-a823-1232e4c78eff	ENRAU0019	24au019	13d08e92-605e-4739-a74b-9da33dc59ce6	2024	4b2d4b61-9b32-455c-bc24-a136d23c2f56	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ae53346e-b43e-4282-93d3-8610a6b6db57	PENDING	\N
39757592-d46c-4b6c-90d2-0c2949cc8110	ENRAU0020	24au020	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	cb7e245f-e0d5-4317-b47b-0ea2e49424c3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	189d7b42-5a22-4b97-af20-40c97afc99b7	PENDING	\N
bbba9241-bffc-4bae-ab8e-1b3536655f89	ENRAU0021	24au021	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	b6bd6759-bb30-45ef-95d7-4bccb3918ba1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	22f749a0-52fc-490f-bbbd-d77962b8d22c	PENDING	\N
d8561a9a-5238-4c04-be36-cbce96b53f88	ENRAU0022	24au022	13d08e92-605e-4739-a74b-9da33dc59ce6	2024	65efe612-317f-484c-9889-1afd3cf176d9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1eb52e74-056c-405c-99e7-bfc891bf8d33	PENDING	\N
90282e8d-0c29-40d6-bcaa-2e82c202b8d8	ENRAU0023	24au023	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	7dbf2d73-6957-46a5-8649-c69fbcc5a838	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5f0d2748-01d5-4d17-adea-7bb38933f92b	PENDING	\N
38188ec7-afff-4815-9ce3-c69c36e2e025	ENRAU0024	24au024	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	60ed70b3-233f-4f5c-aee2-c04fdefd1bc1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7c9beb17-566f-4490-a236-bbcc00fa8f18	PENDING	\N
f22048e2-9f50-4146-9809-8d12eb1d253f	ENRAU0025	24au025	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	fa306c1d-1af4-4f96-ba59-61ce4f4b5dda	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e842b78b-bfb1-4c65-8c3c-a6c01b24511b	PENDING	\N
a156bdfa-759b-4d71-a35e-697158d7130d	ENRAU0026	24au026	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	35e82c69-35c2-42df-a58f-4ed2c0beeb4c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6a03339c-c9e2-448b-9902-d1cdc3919ebc	PENDING	\N
3ae24e76-b88b-459d-966b-31bb3fc4ba7f	ENRAU0027	24au027	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	4b2d4b61-9b32-455c-bc24-a136d23c2f56	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	c8a50880-5578-4e4c-819d-cf93a80faeea	PENDING	\N
4c37371b-2462-4f56-b426-d24c1bfe17b0	ENRAU0028	24au028	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	65efe612-317f-484c-9889-1afd3cf176d9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	50112b47-f031-49f0-be98-1ca489f16f99	PENDING	\N
06ae3e3f-dbc2-4c86-9e1d-30e0ac4d6c1c	ENRAU0029	24au029	13d08e92-605e-4739-a74b-9da33dc59ce6	2024	35e82c69-35c2-42df-a58f-4ed2c0beeb4c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	fbcd8940-1ef9-4888-b758-1b4b4a9b7e6a	PENDING	\N
efe203b6-4f27-4ce7-941a-470268c6e0d7	ENRAU0030	24au030	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	5c3785e8-f022-454b-8d2e-5eaba53c847b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	db268949-8ccc-482f-b801-1b8bc4fba527	PENDING	\N
3addcfba-ebb1-415c-badf-729742ac501d	ENRAU0031	24au031	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	60ed70b3-233f-4f5c-aee2-c04fdefd1bc1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b0864742-62d9-4e7d-8873-3c76570ad4aa	PENDING	\N
ac8d2d6d-432f-4b40-8a28-53484793592f	ENRAU0032	24au032	13d08e92-605e-4739-a74b-9da33dc59ce6	2024	969ea4f6-3ea6-4a2f-94a2-2013269c4f03	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	714d7888-5417-47cf-94f3-8ce50d37fadf	PENDING	\N
10a53da3-1323-4785-bba1-9be7dfe8afd4	ENRAU0033	24au033	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	35e82c69-35c2-42df-a58f-4ed2c0beeb4c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f99739a1-309c-4112-860f-58394e888f2a	PENDING	\N
dde414b7-d96e-41d5-bf23-492d24e42156	ENRAU0034	24au034	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	60ed70b3-233f-4f5c-aee2-c04fdefd1bc1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	17d4e578-a0a1-4150-983a-8ef6700dc60c	PENDING	\N
eb4dec80-5e08-4cf0-a513-b24db3e4e244	ENRAU0035	24au035	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	969ea4f6-3ea6-4a2f-94a2-2013269c4f03	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d08c199c-7d09-4fbb-a74e-a5d9a8a3b363	PENDING	\N
ccd888a7-fd83-47e0-83db-1def6621d72e	ENRAU0036	24au036	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	35e82c69-35c2-42df-a58f-4ed2c0beeb4c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	44eca26e-5445-45af-82b7-118babd33d3d	PENDING	\N
8d34541e-37a2-416a-a35c-ee84ad788971	ENRAU0037	24au037	13d08e92-605e-4739-a74b-9da33dc59ce6	2024	baafec5b-7de3-41bd-b15e-c1b46166f78c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	694d279e-14b0-4a64-8703-edd9a3f02fd4	PENDING	\N
2cfc724e-91db-44b2-b551-adfd0a9914ee	ENRAU0038	24au038	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	82cc0f31-e120-4f70-9293-5e391b6fdc28	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e4f96820-b982-4299-a4d7-6e1dd0781bc9	PENDING	\N
8f3486b4-e23d-4346-a5fe-663f3c7a07d4	ENRAU0039	24au039	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	680bc756-a4a7-457d-95d1-f151b6995665	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7ad09082-87f6-45a8-ae87-d17d85fa84b4	PENDING	\N
ff54ba39-977d-4fb3-a3c5-bc8c56f28301	ENRAU0040	24au040	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	65efe612-317f-484c-9889-1afd3cf176d9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	13b6a93a-e9f4-42c9-a547-dec68c73ceb5	PENDING	\N
1ef62c63-82f5-4f8c-957e-e1ce7527af9e	ENRAU0041	24au041	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	b561f271-d763-41ce-aadf-441e3eb47510	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9ac34f63-e93c-4217-a32b-58d049f81745	PENDING	\N
289449ea-ab9f-4a78-ba56-039ec7be37dc	ENRAU0042	24au042	13d08e92-605e-4739-a74b-9da33dc59ce6	2024	b561f271-d763-41ce-aadf-441e3eb47510	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1a1bff24-3292-4a21-9daa-99765fd264f4	PENDING	\N
372f8e16-a83d-48a2-9dd1-87ae774d63db	ENRAU0043	24au043	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	b6bd6759-bb30-45ef-95d7-4bccb3918ba1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b88a2fb7-d7ea-491c-8e0f-ead389d6e3ca	PENDING	\N
362ed4de-5766-4291-861c-c134ae4120c2	ENRAU0044	24au044	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	daaf53c1-1782-49db-a583-e8f7342a2fcb	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	fd6bee56-746f-4a19-bd9d-f5a62cdfe6b2	PENDING	\N
cb5e1795-4638-4472-acf3-4fdeeafed4ca	ENRAU0045	24au045	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	fa306c1d-1af4-4f96-ba59-61ce4f4b5dda	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9ea44703-cd4d-4e17-bb9a-f6c20e16987c	PENDING	\N
c5b94181-d17d-4145-8243-f8b0306043b5	ENRAU0046	24au046	13d08e92-605e-4739-a74b-9da33dc59ce6	2024	baafec5b-7de3-41bd-b15e-c1b46166f78c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2472497d-9c98-4a8f-89b7-1beb82ad026a	PENDING	\N
aa259707-d9a6-4efb-8c63-c5dd0dc313f5	ENRAU0047	24au047	0b2efd4d-fd66-494c-a123-f5758c8ab00c	2024	4b2d4b61-9b32-455c-bc24-a136d23c2f56	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e89f3eec-ae46-4813-a517-51f49cdb5370	PENDING	\N
ae2a0b09-735b-4d98-811d-2c518f546d1f	ENRAU0048	24au048	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	60ed70b3-233f-4f5c-aee2-c04fdefd1bc1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6e8913c4-1f0b-49ee-96e1-f672057dfd08	PENDING	\N
0383f8ff-1b35-4a7a-9371-18acedacab41	ENRAU0049	24au049	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	5c3785e8-f022-454b-8d2e-5eaba53c847b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	49abc60c-fab9-425e-a2fa-e3849bee0a33	PENDING	\N
d21f33bb-8005-40cd-bbf4-866c264464d7	ENRAU0050	24au050	941f8b93-1c5f-46f2-a4b0-4df5537f6983	2024	1113251d-ab4b-4441-9510-ed161b4df79e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e02ba5b7-abcc-4d14-adca-24c10c38338b	PENDING	\N
29461ff9-4f88-4766-8bfe-04b80c917112	ENRMIT0001	24mit001	623199a1-43e1-446a-97ba-986da1f89a12	2024	bb70a838-bdfd-4449-8d93-a01ece7c9813	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ec73d379-6809-4957-a1bb-bd1f8c1d3b31	PENDING	\N
5b98c4d5-a7a1-48aa-b115-29df7fc70bf2	ENRMIT0002	24mit002	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	a73b36f0-ae0b-46e0-a291-c5783aaf90af	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	c170286e-b5ae-4f25-98e7-a533a65c431d	PENDING	\N
31d8fc8c-209b-4a24-a7b5-7068e19f9b38	ENRMIT0003	24mit003	623199a1-43e1-446a-97ba-986da1f89a12	2024	817fd8bb-3649-4cad-a138-bbc33b9f8168	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b418cf10-0d49-4ad5-ad0a-f7e9791b2caa	PENDING	\N
294d3a80-c06d-405b-b2a3-cdfe642ee043	ENRMIT0004	24mit004	6c90a654-3c45-4796-a5d4-c782847f8772	2024	bb70a838-bdfd-4449-8d93-a01ece7c9813	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	33c2493d-6ad8-48ed-b63d-0f5d849a9ca1	PENDING	\N
9623f730-ce29-4f27-8248-fe7040baa8ee	ENRMIT0005	24mit005	6c90a654-3c45-4796-a5d4-c782847f8772	2024	9af45fac-8c98-4251-ad11-9da7cd7130ec	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5db6daa7-69e4-4bca-aeea-0d05419c05d4	PENDING	\N
277bcb2a-98fb-4501-90e4-4fdff3e2462a	ENRMIT0006	24mit006	623199a1-43e1-446a-97ba-986da1f89a12	2024	cda5b176-3be1-4e28-8224-cd6221a81cab	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	ab400878-ab2a-4726-bd8a-b442d436727f	PENDING	\N
525089a5-7a07-462e-be95-4fb1d9a4591d	ENRMIT0007	24mit007	623199a1-43e1-446a-97ba-986da1f89a12	2024	65797348-3299-4c52-8b31-d7c1885e5ede	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	659434d3-db24-48e7-9563-d1d61cf26923	PENDING	\N
e4b0e4b9-b72f-4bd1-b904-7d6dd9e17f1f	ENRMIT0008	24mit008	623199a1-43e1-446a-97ba-986da1f89a12	2024	ef7c206c-ef82-4442-8d4c-06a47561f7f6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0cf22ce5-862e-48a3-9626-55a4f9868745	PENDING	\N
ccfbbc6d-d4ee-471d-9c92-f34b9b4c3c6b	ENRMIT0009	24mit009	6c90a654-3c45-4796-a5d4-c782847f8772	2024	189ca404-634a-4337-8ffd-4986d4e4016f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0d35de20-924a-400c-bbc4-ab26bad4c3d6	PENDING	\N
70d2acf9-8844-4a85-aab1-9cbab2ae2a6c	ENRMIT0010	24mit010	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	d06043c3-5d0b-4b1f-a80f-1a1e410496b8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	974bcef6-eb8e-4ad7-a3c3-4294035f48d9	PENDING	\N
b2d9b4fa-e4a2-462e-98e2-9213a2701113	ENRMIT0011	24mit011	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	609872c4-928a-4211-90dd-7296502d6d64	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	52d53e2a-87ce-4eb9-bfd7-771bd4b711cf	PENDING	\N
34ed842a-34bd-4fd5-98d2-ba036f21262c	ENRMIT0012	24mit012	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	1cdd0888-1e0b-45c2-90c9-ad8a2baa1829	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6ab8b17f-f824-45ab-89a7-a136467b6199	PENDING	\N
4cb69805-b2b9-4726-9a07-9abb1ebcc1b9	ENRMIT0013	24mit013	623199a1-43e1-446a-97ba-986da1f89a12	2024	9af45fac-8c98-4251-ad11-9da7cd7130ec	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0b3326b4-a92d-4338-a3d2-bdf49e7d6fff	PENDING	\N
eaa09757-a063-42ea-ba76-fef7ddfc7288	ENRMIT0014	24mit014	623199a1-43e1-446a-97ba-986da1f89a12	2024	189ca404-634a-4337-8ffd-4986d4e4016f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1733261e-c7c3-4b62-bbdd-3fd771b48c6e	PENDING	\N
50261cf4-65e2-4540-a7bb-02800f00c91c	ENRMIT0015	24mit015	6c90a654-3c45-4796-a5d4-c782847f8772	2024	a73b36f0-ae0b-46e0-a291-c5783aaf90af	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	89fec09c-3b5f-4324-ba8b-7544d29f1e09	PENDING	\N
98aca28e-725b-4774-bd4d-076aef645917	ENRMIT0016	24mit016	6c90a654-3c45-4796-a5d4-c782847f8772	2024	1cdd0888-1e0b-45c2-90c9-ad8a2baa1829	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	cffa838d-fa9b-4486-a9ca-d653ecffeae6	PENDING	\N
4d881d4b-2574-4078-9132-7f226bf19370	ENRMIT0017	24mit017	623199a1-43e1-446a-97ba-986da1f89a12	2024	65797348-3299-4c52-8b31-d7c1885e5ede	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	076334d9-0672-4e93-bb82-531a7e47ce46	PENDING	\N
b4cc2036-aeb3-4156-bd2c-5fa078ae2b03	ENRMIT0018	24mit018	623199a1-43e1-446a-97ba-986da1f89a12	2024	d789c4fe-260e-4abb-9b36-3cf3edc932fc	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	894982dc-7bef-4855-bb17-5d3804f28c2f	PENDING	\N
99c68751-cf91-4bdb-b259-e216ec7c8e80	ENRMIT0019	24mit019	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	9af45fac-8c98-4251-ad11-9da7cd7130ec	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	dd1453ad-8eb3-4d43-82be-fb240cbda064	PENDING	\N
0a640b65-f015-4d9e-88df-d6b7f5c52ae6	ENRMIT0020	24mit020	6c90a654-3c45-4796-a5d4-c782847f8772	2024	609872c4-928a-4211-90dd-7296502d6d64	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	593d97e6-6e2d-43d1-9c64-77b5fbabfa99	PENDING	\N
0412b83f-2370-478d-bd2c-59e131cff05c	ENRMIT0021	24mit021	6c90a654-3c45-4796-a5d4-c782847f8772	2024	a73b36f0-ae0b-46e0-a291-c5783aaf90af	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	cf31169e-f9eb-4b09-814c-ab5f5fac9c34	PENDING	\N
0bcd9909-96a2-45da-8eb2-3659c33a73a7	ENRMIT0022	24mit022	6c90a654-3c45-4796-a5d4-c782847f8772	2024	cda5b176-3be1-4e28-8224-cd6221a81cab	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	14903a66-226a-4bcd-ba3a-e9711a9624f5	PENDING	\N
2a2f57ab-91a2-4170-a52c-6eeff7f7561e	ENRMIT0023	24mit023	623199a1-43e1-446a-97ba-986da1f89a12	2024	c31ce07e-64a4-4244-84c9-92f288057137	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	c4dff321-8f4f-4b15-a398-665fe6cfe37d	PENDING	\N
b94f432c-1f4c-4c08-84fe-a56646af8d69	ENRMIT0024	24mit024	623199a1-43e1-446a-97ba-986da1f89a12	2024	640ca562-cdac-4881-bc03-de9ab22d9dc1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f4e2def3-0eae-4357-9819-9dee70900629	PENDING	\N
9558ac05-eb3f-471c-b211-ca9da5e03dd1	ENRMIT0025	24mit025	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	c31ce07e-64a4-4244-84c9-92f288057137	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0987e425-8333-444a-ac26-7cb147f48ace	PENDING	\N
3a281b6c-4483-48e9-a546-c4d570faeabc	ENRMIT0026	24mit026	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	c31ce07e-64a4-4244-84c9-92f288057137	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	460e4bed-6ccd-4e83-8abc-0ceef64e557a	PENDING	\N
12e254e4-c3aa-4d16-85bd-cbd5b4a21992	ENRMIT0027	24mit027	6c90a654-3c45-4796-a5d4-c782847f8772	2024	8f5010b1-dc20-4d9a-89f5-682f7823a731	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	05d18be8-e0ed-4c53-92bd-f9cc302f44a6	PENDING	\N
f95c6db3-9c8d-43ac-af37-1e9c74c27785	ENRMIT0028	24mit028	623199a1-43e1-446a-97ba-986da1f89a12	2024	bb70a838-bdfd-4449-8d93-a01ece7c9813	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	48d43c5a-1206-47dd-9d83-e85387e121b4	PENDING	\N
0396aaf7-b9cf-4022-8874-46c9bc2cf0ae	ENRMIT0029	24mit029	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	bb70a838-bdfd-4449-8d93-a01ece7c9813	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5fe22e90-19cf-43b7-9eaf-15479bbb054d	PENDING	\N
d4556ca0-2b73-4255-b441-71a44a571a37	ENRMIT0030	24mit030	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	640ca562-cdac-4881-bc03-de9ab22d9dc1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1fcc438b-5c59-41be-b938-1cd1b3a7d49f	PENDING	\N
dc835e73-95ae-402a-a986-dafb928cfdba	ENRMIT0031	24mit031	623199a1-43e1-446a-97ba-986da1f89a12	2024	b6957d55-4b7e-4408-8683-e4a5a978168f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2d79f900-cb2d-4d94-b408-16ffa842ea3a	PENDING	\N
76d40782-d4a2-426d-ba9c-fb5360eb7d35	ENRMIT0032	24mit032	6c90a654-3c45-4796-a5d4-c782847f8772	2024	4a3abbc7-11f2-4f18-ace9-044de8d042a3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d9863afe-54d6-4a16-a952-16c223b64530	PENDING	\N
1bcf86a8-e289-4b96-b25b-021935837cb0	ENRMIT0033	24mit033	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	cda5b176-3be1-4e28-8224-cd6221a81cab	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	35dc2307-96f3-44d1-9743-6bf097d72f74	PENDING	\N
1f0424b6-612b-4046-801b-031c0abf6369	ENRMIT0034	24mit034	6c90a654-3c45-4796-a5d4-c782847f8772	2024	8f5010b1-dc20-4d9a-89f5-682f7823a731	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a5a886c1-1675-4ab3-b777-5b477a284f4e	PENDING	\N
f17357c7-aba9-4dd0-82f7-5c814f2739f2	ENRMIT0035	24mit035	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	4a3abbc7-11f2-4f18-ace9-044de8d042a3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	409b0962-43ad-4aa4-a989-7cb51df95bb2	PENDING	\N
c544dcf8-b02b-4e04-b940-cc3a0532906d	ENRMIT0036	24mit036	6c90a654-3c45-4796-a5d4-c782847f8772	2024	8f5010b1-dc20-4d9a-89f5-682f7823a731	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5db3178e-9511-482b-83f6-1cb2a362bfb4	PENDING	\N
5519bb06-83b7-4b0e-84e8-02424d0a70a1	ENRMIT0037	24mit037	623199a1-43e1-446a-97ba-986da1f89a12	2024	189ca404-634a-4337-8ffd-4986d4e4016f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9272340c-d639-4503-810a-41ad0667b863	PENDING	\N
f4a6b343-f9f0-46bd-a2a7-778ec1705333	ENRMIT0038	24mit038	623199a1-43e1-446a-97ba-986da1f89a12	2024	d06043c3-5d0b-4b1f-a80f-1a1e410496b8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e987fbd2-976c-4feb-9de9-80b00a09ac01	PENDING	\N
f959907a-3723-4090-9d38-f76d93c7ebf6	ENRMIT0039	24mit039	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	609872c4-928a-4211-90dd-7296502d6d64	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	28ab8e13-97fc-4978-9868-3237472e636e	PENDING	\N
8876b7d6-670a-4428-aed6-899738f98168	ENRMIT0040	24mit040	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	cda5b176-3be1-4e28-8224-cd6221a81cab	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d097bbe2-778c-42b3-8323-bcff91fd7ab8	PENDING	\N
1a152506-72c9-4e55-a515-459be177e4e5	ENRMIT0041	24mit041	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	817fd8bb-3649-4cad-a138-bbc33b9f8168	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	78171046-43dc-425e-976e-b0231962fb4b	PENDING	\N
002cff7f-4a54-4c2a-947e-441797943482	ENRMIT0042	24mit042	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	609872c4-928a-4211-90dd-7296502d6d64	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	90d8bfcd-af58-4f83-9457-50db8bb16ecd	PENDING	\N
c508c5dd-da36-4fd8-b7b6-5b61e4ca25d5	ENRMIT0043	24mit043	6c90a654-3c45-4796-a5d4-c782847f8772	2024	817fd8bb-3649-4cad-a138-bbc33b9f8168	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e2f4978b-0f10-452e-a3e5-01e154f38375	PENDING	\N
a024e21a-e7c4-4d8b-b16f-98ce33da1d55	ENRMIT0044	24mit044	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	817fd8bb-3649-4cad-a138-bbc33b9f8168	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e7253808-5b03-4a96-887f-9e06f64c6d25	PENDING	\N
67d7f19f-f4d0-4606-b59e-f2af1bef701d	ENRMIT0045	24mit045	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	c31ce07e-64a4-4244-84c9-92f288057137	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a0fd7696-0157-416b-8025-5ec2542f795c	PENDING	\N
747e468e-c722-447c-a688-82a85c90caf3	ENRMIT0046	24mit046	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024	2024	c31ce07e-64a4-4244-84c9-92f288057137	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	577c26a1-0c28-45ca-95be-aa57655e36f7	PENDING	\N
70ca6cfc-3a04-47dc-b679-d87282b4f366	ENRMIT0047	24mit047	6c90a654-3c45-4796-a5d4-c782847f8772	2024	9af45fac-8c98-4251-ad11-9da7cd7130ec	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	57cca79d-77d1-4e6d-8742-7ed0fbbe40bf	PENDING	\N
589d39c3-0d34-40a9-830a-16a320119d3b	ENRMIT0048	24mit048	623199a1-43e1-446a-97ba-986da1f89a12	2024	640ca562-cdac-4881-bc03-de9ab22d9dc1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	843a9010-35d7-463c-8b88-af2594dfc50e	PENDING	\N
d43cbdee-9fc0-431e-8624-f303df4c6216	ENRMIT0049	24mit049	623199a1-43e1-446a-97ba-986da1f89a12	2024	bb70a838-bdfd-4449-8d93-a01ece7c9813	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8e3eb60c-e921-4c76-8678-4084a50f9ca1	PENDING	\N
f1117f1b-38cc-4825-91e7-acacfb3cdf57	ENRMIT0050	24mit050	6c90a654-3c45-4796-a5d4-c782847f8772	2024	9af45fac-8c98-4251-ad11-9da7cd7130ec	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b2ae24a4-9fb6-4a00-80c2-f8a66aff03c1	PENDING	\N
ba31340a-ba7e-4b28-a631-5fdcdf505e52	ENR4335da	\N	1026a0b1-beaf-4513-b31d-945181bcfa07	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	bb32e836-f31c-470f-b5ec-2fbf52fb6e97	PENDING	\N
aeb5781b-429b-4242-9fdb-38dbc6e87f38	ENR35171a	\N	1026a0b1-beaf-4513-b31d-945181bcfa07	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7899cc0b-62ce-4f81-8028-a4a6dee38a8f	PENDING	\N
065c86a9-2ee4-4f6b-a59c-b9326fc0fafb	ENReeb3d7	\N	f9b03b4d-5b7f-4726-8c74-290ee896c008	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f650f4c3-2926-4465-b7f8-2e992f91a178	PENDING	\N
53c77baa-295a-45a6-a90d-a713a43c1e53	ENR3ef48d	\N	0ab92ffa-cf85-43c5-9b36-68d2bf5f5d85	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	efabfc55-8fcb-4850-bf4b-03f59064dda7	PENDING	\N
9775fbc0-1f3c-4f9d-95e8-0e48d6752086	ENR253d15	\N	0ab92ffa-cf85-43c5-9b36-68d2bf5f5d85	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1fc9142c-2af6-4dc4-83c5-c926793b86de	PENDING	\N
b59a697f-f67e-4307-bd61-ed36917cfd5b	ENR84a414	\N	03df13aa-b840-4fba-8461-7278d7669f21	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5e652046-4158-4bcb-bf76-0d2032301c53	PENDING	\N
76dfde8a-075b-44dc-9ee8-dc8f93c6f6f6	ENR219a68	\N	6c7860ff-99ac-4d0c-a209-7e45cdd89686	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d1530339-cd16-47be-8919-1bfa0bad5a13	PENDING	\N
dad137fa-2d9e-48df-8247-a63ef5e20732	ENR824b5a	\N	6c7860ff-99ac-4d0c-a209-7e45cdd89686	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	83d7cd24-82d8-4154-a91c-db205a3dc7c4	PENDING	\N
f593445f-21e9-437a-ac0a-f09341d44cef	ENR2a8c5e	\N	56f6d369-d0b4-416b-b7a9-f0dc751cf3b5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	fac49e65-625a-423b-92a2-5844ab7c5e29	PENDING	\N
08589901-0057-4b52-a431-b9090807af86	ENRcd6281	\N	67556692-ca7d-463d-9a43-54df33af1d5b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	20116039-1adb-4f77-a9bd-e31dc28acb22	PENDING	\N
50a7913b-1309-47c2-98e5-58c3d3e6272b	ENR1c188b	\N	67556692-ca7d-463d-9a43-54df33af1d5b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	908d2535-dbb9-430b-a063-1d31eef2549a	PENDING	\N
102096c5-f659-446d-8022-f4b620a7589c	ENRaaaf26	\N	5dfa0623-6eea-473d-a331-e5a97f969fd0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2aca9c8e-f0e7-4072-8174-8681cfe24d94	PENDING	\N
06553638-d000-4f68-adad-9b4d323cd194	ENRSSN0003	24ssn003	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8	2024	b2e0b191-8940-4c11-8c45-73bc8982b77e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8e26e37d-45c6-4547-ad0e-993069a3a6e0	APPROVED	\N
0cae0790-e00a-43f2-94f5-5b55d33f0909	ENR60b0d4	\N	d71823d2-033e-46da-a1c5-12c20bafa4f4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a54b0cdc-1e6e-4723-9329-8aff107ce7b3	PENDING	\N
c7af27ae-59b8-4f1d-9217-c29cb8e0b999	ENRf54ccb	\N	d71823d2-033e-46da-a1c5-12c20bafa4f4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	637f7ac6-a7fa-47d3-9163-842b38de2ab8	PENDING	\N
bca185f7-55bc-4219-a7bb-1fefe34a9d1c	ENRadcfb3	\N	de6a08fb-3018-422d-b384-6e7dff4af315	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	529c9c30-6329-41ab-aa77-70320226aa54	PENDING	\N
4a0612fd-1aed-4d8d-b84d-ba2c59267cfb	ENRd5d9ac	\N	a5d619a0-b481-4e5b-988d-85589dd6168c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3629e13b-4e08-40f7-9f9b-52fe6fa5d7fe	PENDING	\N
2cbc8a21-0d95-4017-8a78-c5b31a6a3c48	ENR166109	\N	a5d619a0-b481-4e5b-988d-85589dd6168c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3890624f-8ba4-4b59-b80f-109bfc9c6f30	PENDING	\N
61368e4f-ffe9-46b3-a22e-d2a5ea9adc09	ENRb0edf8	\N	ba66490c-4ec3-4181-b0ce-6a3342d0366a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	61be6058-a364-44b9-87d6-2cc87d7b6c04	PENDING	\N
9030cfd4-3968-4eb7-b7f1-aed308bd26e4	ENR885363	\N	4e955f10-3c93-4f07-b325-0cab11aa0493	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	54230f27-55e9-4ece-8241-94dcec182297	PENDING	\N
ebeb3922-01d7-4d16-98be-d824e77ec2d3	ENRc4f441	\N	4e955f10-3c93-4f07-b325-0cab11aa0493	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f9707206-b916-4271-995d-d211d738a1d5	PENDING	\N
4cce8634-6f55-4de9-857c-0f245c893979	ENR681cd9	\N	027632d1-3166-4cd3-8463-7e03ae68e534	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1e6657b7-ed15-44ec-b11e-3bd0922b626e	PENDING	\N
0ab7c80e-e828-40bf-8aa8-3f5a6b65ecae	ENR77b2f6	\N	7a920d00-8293-4558-9c43-04ca5f295124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	bd689ea8-53d3-46a1-aacf-4bd6b746d927	PENDING	\N
5bbb177a-f1e6-4b67-93b9-c3ea6484c205	ENRac4877	\N	7a920d00-8293-4558-9c43-04ca5f295124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a80faa5d-8c87-4611-a788-9f9349d74fd8	PENDING	\N
7b6469a6-e2b3-4f20-ae06-68bf7e77f28b	ENR011d83	\N	16c76429-22e0-412f-9272-3123c66dbe5a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6e8f103b-093f-411a-af54-2ae45d75fb3d	PENDING	\N
233ee444-cd4d-4542-8aaa-1e5d55605f81	ENRf303c0	\N	42ae23c2-47db-4929-ac14-62b026bd019f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	674844b5-a948-4a03-ab77-40399bac8f91	PENDING	\N
7528838a-9b1c-4429-a50f-d67a22d71afc	ENRaf5239	\N	42ae23c2-47db-4929-ac14-62b026bd019f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b69cd5a0-836f-4308-91d3-5ecdab8b8cb9	PENDING	\N
9f926d82-77f8-411e-8619-876308fede35	ENR581a57	\N	8291d7ed-0e7c-4267-9ba8-4189816219fc	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6e685f61-52f5-4b14-941c-de274b3047f8	PENDING	\N
46deae43-ad61-4049-9103-aabae3297c73	ENR8712cd	\N	bc5b07bf-96b1-4e0e-b711-0a6d1f7d67bc	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	474ef46f-9e6a-416c-9389-627552a94788	PENDING	\N
b37204bb-46ac-4d75-a3cd-b580382a4823	ENR487a47	\N	bc5b07bf-96b1-4e0e-b711-0a6d1f7d67bc	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1eaf6b5d-bd58-4b07-a01f-b85113ab692c	PENDING	\N
3caa152d-a7ce-4f86-bf13-2037b4e4879e	ENRffb9c8	\N	e0a4d971-42a0-4b6d-9511-714649eaca66	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	691408b2-c580-4e93-acbe-e69f678a02b3	PENDING	\N
b567386e-7668-4080-8357-7becc6ea714a	ENRREC0001	24rec001	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212	2024	e0435499-11d8-4732-bd82-0e5e6b6c0aa9	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	c037a47a-b13b-4629-af3f-0e14e3331020	APPROVED	\N
14f17dc7-e135-4e2a-8877-58dca2c968f9	ENR9b5c31	\N	40b8b0f0-8f8a-4504-ab85-3e41d974f5ba	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	426c97e3-cc13-475a-88a6-5c028cb1b834	PENDING	\N
94a97cd6-2591-4bec-9a3f-b573a4c72233	ENRb10d13	\N	40b8b0f0-8f8a-4504-ab85-3e41d974f5ba	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	b3a8b3a3-ea01-4652-ac85-f579c8874c96	PENDING	\N
0abbf1d1-be23-4415-a4cf-8822589fea34	ENR47fafe	\N	8f3a7ba3-4394-4778-b390-5b43f1fa44b1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	554ddbcf-7812-43a6-8291-da45d7ecd063	PENDING	\N
d1e2d40f-c013-49c3-91d2-c544580aaf62	ENRefa1f7	\N	d829adc5-19d2-4474-b7ff-22884ee8be1a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	e67a3872-52b3-4da4-99c1-9bc6e60e4efe	PENDING	\N
260c9b8c-84dd-49a2-a5e1-37439cfb6f0d	ENR63c34e	\N	d829adc5-19d2-4474-b7ff-22884ee8be1a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	96dbdf13-5b6e-4311-9562-7ff531aa3c59	PENDING	\N
473e90ea-4841-452a-a1c5-8d43c44fa6c5	ENR637a29	\N	11080b39-be3e-4c21-bb51-bc83e6b53998	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	027637d3-509d-4b40-9449-90fad5b2d881	PENDING	\N
f034d950-7d5c-4ef6-b664-375e2066b458	ENRf84e25	\N	258b1705-9460-4337-871e-74d6a825e475	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7e99544e-2618-4071-a2de-f6b9bc18f05b	PENDING	\N
e7d98ad0-2d43-4969-9b7d-a37632f1feaf	ENRa6faff	\N	258b1705-9460-4337-871e-74d6a825e475	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	d5979ad7-c038-460b-a33d-9c38ec907c22	PENDING	\N
aa0cc309-8a20-4dc3-bd74-515e82353e9a	ENR85b38c	\N	d37ae460-4f11-4467-a93f-476f3bc5d9dd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	a833eeab-caa0-401d-9fee-73140ceb6404	PENDING	\N
\.


--
-- TOC entry 5399 (class 0 OID 50181)
-- Dependencies: 261
-- Data for Name: student_success_index; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_success_index (id, student_id, score, category, cgpa_factor, attendance_factor, achievements_factor, crs_factor, pri_factor, research_factor, skill_factor, snapshot_date) FROM stdin;
\.


--
-- TOC entry 5387 (class 0 OID 49990)
-- Dependencies: 249
-- Data for Name: student_success_predictions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_success_predictions (id, student_id, improvement_probability, dropout_risk, requires_intervention, confidence_score, explanation, snapshot_date) FROM stdin;
\.


--
-- TOC entry 5377 (class 0 OID 49795)
-- Dependencies: 239
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subjects (id, semester_id, subject_code, subject_name, credits, department_id) FROM stdin;
\.


--
-- TOC entry 5371 (class 0 OID 49670)
-- Dependencies: 233
-- Data for Name: submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.submissions (id, assignment_id, student_id, content_url, submitted_at, grade, feedback) FROM stdin;
\.


--
-- TOC entry 5359 (class 0 OID 49457)
-- Dependencies: 221
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, hashed_password, role, mobile_number, is_active, created_at, institute_id, department_id) FROM stdin;
b5f032ff-0e83-4b92-bfaa-588d6d87304e	admin@karpagamtech.ac.in	$2b$12$KKT6OOMVU9IXR4x9WSmF8uyBZwa2ZQ1h8u5tTf.QXbv9oU6AEAzJS	ADMIN	9876543278	t	2026-06-13 07:15:26.009487	6e91aae8-6a9b-4b38-9476-68d92319dba3	\N
d945cb55-c4c3-4c1c-bdc1-e3f0627612d6	faculty1@karpagamtech.ac.in	$2b$12$zXFuq1SBMI9bnWcL7OaHGOEpIGP/ZOLGoy6JLeKJsSzKxVqLIICjS	FACULTY	9988776601	t	2026-06-13 07:15:26.297509	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
c5fb80c0-4385-41ee-b379-56285f0231e4	faculty2@karpagamtech.ac.in	$2b$12$jtxCSAw519cOo2SyXAUsiuia/ZEt528IIjD/lA5ldKiQiyjNVpeMK	FACULTY	9988776602	t	2026-06-13 07:15:26.582604	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
018ca201-4cf8-4c1b-a576-eee330e1c84a	faculty3@karpagamtech.ac.in	$2b$12$qF6S/QkhxYDTS6BN6Zq05uimlgWmM9Zvu2t/rlemBHsd6qgTshBPu	FACULTY	9988776603	t	2026-06-13 07:15:26.878963	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
d6e84c53-e80b-45ff-a1fd-d7ec87f9d04e	faculty4@karpagamtech.ac.in	$2b$12$mWT6J6Kq.puSGZ/VwRCGE.7A/MjHPEK1JQRkFPLxCmFb6GWEZ5Uh6	FACULTY	9988776604	t	2026-06-13 07:15:27.164256	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
797c9a73-e0b6-4f52-baa6-688d8ec72c4c	faculty5@karpagamtech.ac.in	$2b$12$r/X0D3QWmZt1.HVvlNn4Be74L/t/94lkHKKwMzFld3sN7z5RgrMEq	FACULTY	9988776605	t	2026-06-13 07:15:27.436127	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
438b9aa9-39b3-4ee4-bf1d-20d3b79ebd05	faculty6@karpagamtech.ac.in	$2b$12$yPmhjotKttWM3sf61/u4FuJeo8v88c0YcBygJwdXTvjPVTalHshI.	FACULTY	9988776606	t	2026-06-13 07:15:27.716675	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
a7e412a2-34c1-46cb-86c1-0b36bb40c16e	faculty7@karpagamtech.ac.in	$2b$12$qRT84RnM5lQcKReMYI/wjO8n0vJoz.KqDYLFmwDbOocR0vQBqElVW	FACULTY	9988776607	t	2026-06-13 07:15:28.170288	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
64231fe6-e91b-43fa-8d7b-060d4bfbb6ee	faculty8@karpagamtech.ac.in	$2b$12$o5i8Igdkf0TRRNrjtd59ZO5r2ofgh8/Vx1dAzYnRmAkDT.RPAq1SG	FACULTY	9988776608	t	2026-06-13 07:15:28.722743	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
b6c16b09-9a2e-40ba-864f-628dccd6ccaf	faculty9@karpagamtech.ac.in	$2b$12$WrzKZgH7J9/RPWO1J8zFMuTbmRnUDV5vbB9nME0qum6wpTBl7ha6K	FACULTY	9988776609	t	2026-06-13 07:15:29.300994	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
6cc4a9ec-53ce-4554-a986-8ea49a40da86	faculty10@karpagamtech.ac.in	$2b$12$CP0qkEKO4BxaY221aKppYehQYmBoQkIhalHL4.e6hr9sU70f0dGoa	FACULTY	9988776610	t	2026-06-13 07:15:29.92335	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
ee78621b-47ee-4339-b469-e33c89aff3b0	faculty11@karpagamtech.ac.in	$2b$12$Fq5EbBtSUKz5lC5rowmU1OqCiEP3Dt/FQ4SBaGWxTynQFSpkN7ePu	FACULTY	9988776611	t	2026-06-13 07:15:30.569935	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
4a595638-db48-4eac-9d53-9b3b82c2d110	faculty12@karpagamtech.ac.in	$2b$12$gzScORfWbwFoLGcP.yv3Vu0/Z7XqXFk7Nkt.DgOtFK05LRrDRYPsG	FACULTY	9988776612	t	2026-06-13 07:15:31.184317	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
b44c561d-fc89-413a-a012-7abd1230e4f6	faculty13@karpagamtech.ac.in	$2b$12$ydLLIHER0u7JzIXQJn2pEOHAmGQ0Ekohdecnx5VpolgRw0g8gjGsW	FACULTY	9988776613	t	2026-06-13 07:15:31.83766	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
4382df8c-2f5a-4912-a3f8-432aaf31890d	faculty14@karpagamtech.ac.in	$2b$12$E1bbmggDR1W5VZfm3IN5KebnS1xWXkoi2h8BgZhQWpveSnzGM5/ve	FACULTY	9988776614	t	2026-06-13 07:15:32.437422	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
cf03e4cf-6353-451c-be5a-b6c950a9c23f	faculty15@karpagamtech.ac.in	$2b$12$3oEZsbW61/zO1AJuv9VfEe96HJTvcIwoxSSyv2l6eyK3a8Lf1Ub1G	FACULTY	9988776615	t	2026-06-13 07:15:32.995502	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
afb10696-4ac0-4a44-894e-8eae828b590a	faculty16@karpagamtech.ac.in	$2b$12$bIex0TnKmhBBwuXf.coK1OA6ckWp4OEwQ1DlLWVvx3FiNhZ5SMeiq	FACULTY	9988776616	t	2026-06-13 07:15:33.567486	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
a1ece2ea-3c16-4608-add5-e807e4e1652d	faculty17@karpagamtech.ac.in	$2b$12$IF99ZKK5FMEFUe7qkD5TuOZmzOtAsrjKiXh1pRd8IGjTpQ6zxgecW	FACULTY	9988776617	t	2026-06-13 07:15:34.148381	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
ed4430aa-571b-44cb-9f0a-15a5fe2fa2eb	faculty18@karpagamtech.ac.in	$2b$12$SPnghsRT/jLjNXYDQdPZBeqVGddvPrkrMwckXyvd0xl/mrAcVzhKW	FACULTY	9988776618	t	2026-06-13 07:15:34.681206	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
3a568bf8-343a-436c-a227-a74dbb8dbe44	faculty19@karpagamtech.ac.in	$2b$12$DYdkYu53R2MDHqPLnMwd8.0vhskd61nD2pkvcuLpmTKWf8ALdcp1e	FACULTY	9988776619	t	2026-06-13 07:15:35.275159	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
358f1276-39e0-4ad6-98cb-6fee214df9aa	faculty20@karpagamtech.ac.in	$2b$12$IDSzuvb.WExpmnNFs.oIY.sNXf/67i5RIrUEBQPOh7ZiVXy1DOTPy	FACULTY	9988776620	t	2026-06-13 07:15:35.843457	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
fcbc51f6-0c5a-414e-ad83-05d0907bf80e	24kit001@karpagamtech.ac.in	$2b$12$O6QDunrPyB5a11m8qbIgn.C0oUjHAwqgVR.AtQwOfnkBkyOkyLdu6	STUDENT	9000000001	t	2026-06-13 07:15:36.414712	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
84e25b70-a4d6-4474-9479-b08b9baf39d0	24kit002@karpagamtech.ac.in	$2b$12$KqLKrq9tbzN8pN9v.hX2QunKlVU6aAwOy/Bj/JIys1SA9RTkJTEsy	STUDENT	9000000002	t	2026-06-13 07:15:37.017795	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
d7b85c09-78e9-44ed-8525-8ebd26917d48	24kit003@karpagamtech.ac.in	$2b$12$GiVFlpLQmkJweQ8mIY/r1.iRjLJw1304U0YB8TRN0KS/ZHLOW1f2m	STUDENT	9000000003	t	2026-06-13 07:15:37.547638	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
1914e6fe-5969-48e9-afe3-46d97b503f9f	24kit004@karpagamtech.ac.in	$2b$12$io3PDC5sOv.nJ.1bx559reSqneOlR/7cJI3Hwzmo8S7mxRj7XJ1kq	STUDENT	9000000004	t	2026-06-13 07:15:37.836833	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
e8840667-6418-4f78-8cc8-e5badf9eaf5b	24kit005@karpagamtech.ac.in	$2b$12$.Q.kPS091w2orJyZ5MO5J.9FXXblzu04FN8wdc84.hPc39nWYEteq	STUDENT	9000000005	t	2026-06-13 07:15:38.201666	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
00cc944b-7914-401b-b5a8-9389a68f1e7d	24kit006@karpagamtech.ac.in	$2b$12$T6JhUba03bXAZdidAyVN3ugho6Zjg1tpaTzrojvqfVNzd2HATGz9C	STUDENT	9000000006	t	2026-06-13 07:15:38.682418	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
fde96dac-4e26-4ad8-a919-fa8cf09147bd	24kit007@karpagamtech.ac.in	$2b$12$t3JsnEhPEDDOLgmtGCBgMOwrunLCJAW3B3cQkUfToz5dDSvQZupDi	STUDENT	9000000007	t	2026-06-13 07:15:39.157947	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
ada27de4-d439-4a0c-aa87-d98074892310	24kit008@karpagamtech.ac.in	$2b$12$1zTQUcQ2Y4A4hdHK4INqMuFwygvw9K95qlfwav6YWcmaDO9C9crAG	STUDENT	9000000008	t	2026-06-13 07:15:39.691787	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
62190dae-e8a5-4de3-a536-edfe5c64b8dd	24kit009@karpagamtech.ac.in	$2b$12$DHNuyKwvISxn4xTHeg1jSOZFcwRLNj8jj.dIuxqKbK8NjumJjyjOS	STUDENT	9000000009	t	2026-06-13 07:15:40.066442	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
a492622e-5f9d-42dc-bd26-b68afd4ee4c0	24kit010@karpagamtech.ac.in	$2b$12$jX4qEKcZ.WJLGO3sAW9GoO4zowbONPLjo8SjC00ie/Q3cOrhOc0sS	STUDENT	9000000010	t	2026-06-13 07:15:40.432442	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
60156d1c-addf-440e-970f-2885a053347d	24kit011@karpagamtech.ac.in	$2b$12$hKNV9YO4W61C9ZkRdLDSSunhV3nUyIdhjXWIWJ/b/oJeE/BedcWym	STUDENT	9000000011	t	2026-06-13 07:15:40.729147	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
b8bfae65-ef25-4267-bec0-e227ee9cfb95	24kit012@karpagamtech.ac.in	$2b$12$yUCBoQQ2ej5dXSZKSUzm6O18WLz93Egqm.0f6Kw9SakodMS5zx3yK	STUDENT	9000000012	t	2026-06-13 07:15:40.996537	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
2f12fbf5-4ce8-479d-90fe-f9bdef8961f7	24kit013@karpagamtech.ac.in	$2b$12$lhDRuBxOC2ncbCGCxDHC/erot8WM3iF.GVgZIS14hcriAfqMcaZhC	STUDENT	9000000013	t	2026-06-13 07:15:41.290267	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
3fda667e-52a1-4326-83f6-f72a6d754666	24kit014@karpagamtech.ac.in	$2b$12$Rfu1XAGJskDJXh8Uz16/c.vgFOPLh/.gFr43JuMeu4LwE.9Fvd6p6	STUDENT	9000000014	t	2026-06-13 07:15:41.59364	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
e19cb784-e5b6-488e-893c-16b2005086d7	24kit015@karpagamtech.ac.in	$2b$12$mDyKR6fLt1JgXAJ/6aZAz.r6k0ZIQBL4YiwXlhLrIBNYaLXnZU3tS	STUDENT	9000000015	t	2026-06-13 07:15:41.896325	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
db54e9d4-257b-4567-a9ad-a78b4cd7585d	24kit016@karpagamtech.ac.in	$2b$12$dvRh/y0TXonVwUhxPDUoM.IiybPSRVB/6xjLqcSMJSgYlYpfQbJlu	STUDENT	9000000016	t	2026-06-13 07:15:42.245573	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
aa843b89-2c7d-47e8-93f0-165fc66b48d7	24kit017@karpagamtech.ac.in	$2b$12$5LFdPc4Diw7DEFmR1g/pJelzcQefMBxC4fa3tWDy1/SrSLg7yHP1.	STUDENT	9000000017	t	2026-06-13 07:15:42.598748	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
d6cc35e6-2b21-4991-aab2-ade10cec4f12	24kit018@karpagamtech.ac.in	$2b$12$ZtW5RArMd21yVs51TYjnoOMHXSePrqMgE/vrDD1pZyPZdONYrELfe	STUDENT	9000000018	t	2026-06-13 07:15:42.905811	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
ee5a1de0-c771-43a8-b108-1a3c6ee215b3	24kit019@karpagamtech.ac.in	$2b$12$JGyyrHyaRbuMLOHZHmzaD.zfX5fFmmaZKoJvAcP6K8/rl..d79GuO	STUDENT	9000000019	t	2026-06-13 07:15:43.197838	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
1e247c62-c823-48fe-924a-9accba0bd232	24kit020@karpagamtech.ac.in	$2b$12$9sz/5tmB8ng9xjEiJH0szOUGmIaLh.kLE7BuOQI7wrNKL1IRE2kiy	STUDENT	9000000020	t	2026-06-13 07:15:43.471386	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
a78dca52-8e16-47f2-b0d2-d74af9c53587	24kit021@karpagamtech.ac.in	$2b$12$Ec3woDMru0E/BulhxFdl2eCAISaBIoWkcvCNHC/DU0xcBuhDgWvfC	STUDENT	9000000021	t	2026-06-13 07:15:43.74251	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
447316b4-3276-4db0-a12b-9657b40aeb08	24kit022@karpagamtech.ac.in	$2b$12$o2yLcsuCpW4f8GE4aYWn0uzj.HbzJStNyEfpGl06klvxuLF1gEpyG	STUDENT	9000000022	t	2026-06-13 07:15:44.018935	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
3fb0aec5-211f-4538-b4f1-9a7503742c9a	24kit023@karpagamtech.ac.in	$2b$12$w5Wcple6Uk4UEyTrRmscw.BVXMU.7K1gZXftUGLvMhvRtGZGnylHG	STUDENT	9000000023	t	2026-06-13 07:15:44.350824	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
a4e7dad1-b6f5-4b29-ada5-fdb67bd3ecb5	24kit024@karpagamtech.ac.in	$2b$12$27DrkAHpgs/Ue0jjYIqPfeHBtnMi4uN6cOkOVOFRLjHsAPo3L/Bh.	STUDENT	9000000024	t	2026-06-13 07:15:44.64789	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
81b94239-c1dc-403f-a3d2-5ae05c1027db	24kit025@karpagamtech.ac.in	$2b$12$bX9HhTPHC/QwMuhHBnDH1.VNgm5Os1Pc46rQfPNqfanusQWjau7Vi	STUDENT	9000000025	t	2026-06-13 07:15:44.922562	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
80a2fb36-68a3-4028-abfc-0213aa497f94	24kit026@karpagamtech.ac.in	$2b$12$MynZ7Le1LOyYYX9NAqFJfOTdLsMXj0O2pGHJi1Ju680FMccBminde	STUDENT	9000000026	t	2026-06-13 07:15:45.200667	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
260928b8-8826-43ad-b2ac-2ac5f573bce9	24kit027@karpagamtech.ac.in	$2b$12$gRBNP4CtzuZawQl4ODNkouV9jfzgxwGmwQcUpT7cI/KYle223uFBi	STUDENT	9000000027	t	2026-06-13 07:15:45.519593	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
d46acc07-f74e-40df-96e5-ad4d5755cf6e	24kit028@karpagamtech.ac.in	$2b$12$tf4DPCtAgaGgKv.DJ03p5eYM.KaO1TUVYemgm7BKxFULecStaNzfa	STUDENT	9000000028	t	2026-06-13 07:15:45.803426	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
a2cc566f-8d43-4997-9326-885c8be4ff70	24kit029@karpagamtech.ac.in	$2b$12$WedLDEuno1mOg/KCyCA4t.tLDp4k6NJP/gWsgkGsNOYQddB9nEFeG	STUDENT	9000000029	t	2026-06-13 07:15:46.073684	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
13683caa-d23c-400f-894d-eb567538e5c5	24kit030@karpagamtech.ac.in	$2b$12$GiqqOxRUvpUKKmDo1YeM/Oh6alUp0ieiLQJqAUIR9YH5MGaoZmqGC	STUDENT	9000000030	t	2026-06-13 07:15:46.345036	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
f4914a26-39bc-4f1d-8f20-af48433781a7	24kit031@karpagamtech.ac.in	$2b$12$AjEEbTcnNRq1kcmqyouxKO3sGTMbyJwgUAKonLGclpHFC49OepTqu	STUDENT	9000000031	t	2026-06-13 07:15:46.775607	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
a05010c8-ad20-4e06-82e3-a8ca5aa987ae	24kit032@karpagamtech.ac.in	$2b$12$tOtdlyOS2JfxjQT3qJFOwuzip4iehg6acVKwfHtWvO1Sk7oE3BEve	STUDENT	9000000032	t	2026-06-13 07:15:47.362751	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
581d4b4e-5dae-45dc-b33f-d0bbd6a62d2f	24kit033@karpagamtech.ac.in	$2b$12$xcSQE3FxJxqNARREFaHOZOBcQlImk5TBromLxZTpHy0hm0u1u0MlO	STUDENT	9000000033	t	2026-06-13 07:15:47.845774	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
323b6b31-0416-496b-b68e-26b4be7dcdf6	24kit034@karpagamtech.ac.in	$2b$12$ZKVTHswC.0ZnyxbeD6gF0uPp4uu5/IHl3ZTnuGrEeUoOZB4xpE3a6	STUDENT	9000000034	t	2026-06-13 07:15:48.118367	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
00c5dc40-a3e2-4504-a61d-03b949909020	24kit035@karpagamtech.ac.in	$2b$12$urZt98xIcKEqyN5sI2cv5uxF6WlIECmwqgH/cbiSu.HeU79TeIMvK	STUDENT	9000000035	t	2026-06-13 07:15:48.408682	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
75dafcce-e746-4599-ad5b-32ec83a1fb60	24kit036@karpagamtech.ac.in	$2b$12$FGSMtHSYUXr7Fr0Rxejj8uM9o6mZg2DBLRI7t/ez93MLfGEw1XRVm	STUDENT	9000000036	t	2026-06-13 07:15:48.805086	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
d8c7e638-0b22-4f0c-815a-36ee4f7211cb	24kit037@karpagamtech.ac.in	$2b$12$lUYhyBgcQYiln3GibwEhledZLhwhmqFQIH0FACvI705jPuqctbZNC	STUDENT	9000000037	t	2026-06-13 07:15:49.160331	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
c1d203ae-7231-4fc9-8b1a-3e28304c6353	24kit038@karpagamtech.ac.in	$2b$12$pVM55Q.aLp5hZzF31bsnw.lFl971Up/0/mVsD8XY8ZLx/B2Ac7F3u	STUDENT	9000000038	t	2026-06-13 07:15:49.451989	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
96c7cb17-de02-4e02-8756-c58333cd8779	24kit039@karpagamtech.ac.in	$2b$12$gSz4xUAes2yiBEO64ACxTe19RsDRCyQPLeomMjyTIpgGK.z/hqVG2	STUDENT	9000000039	t	2026-06-13 07:15:49.762467	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
8081b8d9-54c1-43f4-8793-8351f045e3bc	24kit040@karpagamtech.ac.in	$2b$12$g.7iQ6LfYEJrrouhrvp6xuTBBFpyIwjBHUHOxREqIfFB0zoHXCR4q	STUDENT	9000000040	t	2026-06-13 07:15:50.064937	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
f4066466-851c-416d-a304-e07202759e52	24kit041@karpagamtech.ac.in	$2b$12$qRK9Te2dQmMCX1W3s9ZUZOgpVqsXn03S.cuAbASOtKQKMjQmGpzSa	STUDENT	9000000041	t	2026-06-13 07:15:50.363165	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
36a3fae4-b0d1-492e-a78f-0c9fdabc2ef2	24kit042@karpagamtech.ac.in	$2b$12$iv3V1ErO9oXlqur6mW.6SOomh0jzRynwDC4EMGGu6hy1rbM7CxY2e	STUDENT	9000000042	t	2026-06-13 07:15:50.654069	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
cc59093d-5fc8-4f19-85b4-95c1080a0f4e	24kit043@karpagamtech.ac.in	$2b$12$qEYI2CXfX1ufAUxkl9DUU.7pTEE3TpdRaH17YpaphOtRzeVa9HJG2	STUDENT	9000000043	t	2026-06-13 07:15:50.955954	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
f7033f98-0c66-4ff3-a45f-4f6b2924d1a7	24kit044@karpagamtech.ac.in	$2b$12$lA0plSJG1kjPBBjOi9FFp.Z2/mNZo/t/VuP0n9zOcU01qneND5TA6	STUDENT	9000000044	t	2026-06-13 07:15:51.247906	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
cee3c6cf-d7de-4a00-97e5-e0745c380efa	24kit045@karpagamtech.ac.in	$2b$12$ysfOIe8tQbv1fSiukva1xesmrKYJcfmwxEI70GCcQP9hJUC10wmeu	STUDENT	9000000045	t	2026-06-13 07:15:51.577722	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
efca4fc1-cabe-47e4-bc53-6676ee86e36e	24kit046@karpagamtech.ac.in	$2b$12$yv9j0y.ePOmTmpfBJK4yCuHb.74QnTS7N01L4kVazDyjA4NOb0myO	STUDENT	9000000046	t	2026-06-13 07:15:51.878587	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
3d219b52-dff4-4953-b4c5-ec6c1868f3f3	24kit047@karpagamtech.ac.in	$2b$12$OwjBh6CSj/0hRbtymtYFMu8n/bLnoBdj2QlalismZsltIuXdzhf3O	STUDENT	9000000047	t	2026-06-13 07:15:52.178625	6e91aae8-6a9b-4b38-9476-68d92319dba3	f945b515-a537-4ab1-a1da-7cd72141897c
56a8c99b-5665-4efd-9bc6-e160d2eb92dd	24kit048@karpagamtech.ac.in	$2b$12$Js4N780SHx6W7KEGFhOnLuTZRK7Djzgz1er2bJFfl2MgJRKhdre86	STUDENT	9000000048	t	2026-06-13 07:15:52.460318	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
e1db4481-0fc6-4729-a37e-60f667f67a4d	24kit049@karpagamtech.ac.in	$2b$12$vH.9eE8YWZDN/RacwqiITeS/XXmhithWaRr2KZWDid/ujdMHJ62sS	STUDENT	9000000049	t	2026-06-13 07:15:52.759381	6e91aae8-6a9b-4b38-9476-68d92319dba3	58e6b5d6-48fa-4bdf-b6b0-998605cd7ba8
b6c06c72-27c1-40a4-bf1c-6c1386480d6c	24kit050@karpagamtech.ac.in	$2b$12$5zz2QDSi7F9QlIkZShNkK.wxG52RMBV1znf/XMbFyLBda8q9emyl6	STUDENT	9000000050	t	2026-06-13 07:15:53.036328	6e91aae8-6a9b-4b38-9476-68d92319dba3	4d6a5eee-7226-445a-a6aa-5135f8887140
3e95051e-dee7-4dfd-aa35-723f94d87db8	admin@srmist.edu.in	$2b$12$FT6iEE57DxeU5Mh5KMU5duei4V/L9jyB5uVWmTqv6v9jDTfzgvdOq	ADMIN	9876543262	t	2026-06-13 07:15:53.318077	4df602f6-6142-477d-9245-8ae40c49cff2	\N
ff737f31-ba81-4efb-ab48-04255f74c0b6	faculty1@srmist.edu.in	$2b$12$34qLmh3ZxcdzwR3CLEsivetpAztxyGMWnoqXUz.8SdWFz1tCVotH2	FACULTY	9988776601	t	2026-06-13 07:15:53.603306	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
25766653-8bb5-4cb3-a15f-95431b8f9fb5	faculty2@srmist.edu.in	$2b$12$vu9c/M7ltSt/MdQkaSefb.BfFTmQ9XuRHT6Z3FrJH3wwuQNg3fIYO	FACULTY	9988776602	t	2026-06-13 07:15:53.927989	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
73d91822-6bb0-4769-8ab9-acf74112282e	faculty3@srmist.edu.in	$2b$12$bDs2WiYITQOF0GhJ0x8p4ukkD9GjdFsGFfeXaMAlq/rhsPSMGYwCq	FACULTY	9988776603	t	2026-06-13 07:15:54.203466	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
478d0ef0-3979-474a-b181-1c0b95670f75	faculty4@srmist.edu.in	$2b$12$/SaOUU63TFJvSgYoBMmEVeFQ4CbkIE5h1bNkRkNz7SKhmWmHjGubS	FACULTY	9988776604	t	2026-06-13 07:15:54.494583	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
081cbc26-3e8a-4865-9880-d525cfe6471e	faculty5@srmist.edu.in	$2b$12$0q.dLxiwyC8/bBR.KrfTwe4LvfYGVcA0ND7RG5Hmiz02o8X6eIlfy	FACULTY	9988776605	t	2026-06-13 07:15:54.770267	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
37be8732-9def-4b0d-b3c7-737017b724bb	faculty6@srmist.edu.in	$2b$12$tFPR.hI/AZeOBs9RgbeG.OMU//VoxPSrXaIU0gUoW/0ZCosYsSyVS	FACULTY	9988776606	t	2026-06-13 07:15:55.250314	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
cf050f19-9fbc-4db4-b53e-5680d36a41e0	faculty7@srmist.edu.in	$2b$12$sJuOitF7yUwk2qTWyFuYu.x9Pjva43vAdfgzM1CSTTu8i3SLTnn3u	FACULTY	9988776607	t	2026-06-13 07:15:55.651582	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
9228c986-2cf4-4a1f-80c4-5393ff1fb917	faculty8@srmist.edu.in	$2b$12$jtd2/2yGaFsIcvkW/AL27eLw21lowrQBofrOYPYe67PkKqhYth.eq	FACULTY	9988776608	t	2026-06-13 07:15:55.922635	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
5a500067-a553-42c9-97c0-4de9152c5cdd	faculty9@srmist.edu.in	$2b$12$C18i4I3IwUCTEGsJYMD5yeNdioFXbziNIYUpHXKYWZ6cBYpSat8Cm	FACULTY	9988776609	t	2026-06-13 07:15:56.189445	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
988a63f6-2f13-46e9-b343-3cfaeac106e4	faculty10@srmist.edu.in	$2b$12$.nJKbxg69IJCzIoKNRdpwOwlBL/2Qyvj9G2u8WE6iGaaTh4X.nT/y	FACULTY	9988776610	t	2026-06-13 07:15:56.457839	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
e023565f-6cac-4f76-b9ad-1b7f60106688	faculty11@srmist.edu.in	$2b$12$RF7LxuI1PFXk8Vtbvxd4zOeru/Zoybd5LDrrcsVbisnYifFPWhQVm	FACULTY	9988776611	t	2026-06-13 07:15:56.726429	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
f2726a9a-b263-4834-af6a-c804fc8f6e37	faculty12@srmist.edu.in	$2b$12$uaZ0HCno7Ea/i/./H8rZb.F9.r28xT7qYAoOIFlshacgxMF/nDEdi	FACULTY	9988776612	t	2026-06-13 07:15:57.004489	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
69ebc9f2-0fc9-40a6-95a5-c85607cbc3c5	faculty13@srmist.edu.in	$2b$12$sbOp3odYJkqIjlQF1fxq5usrHWDjjb8ycIYTQ16M8sD5eklJ0oM/.	FACULTY	9988776613	t	2026-06-13 07:15:57.270439	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
d84d85e4-7ad8-400a-afed-69f0b7b9c46f	faculty14@srmist.edu.in	$2b$12$w6I3H4st3JrR0/JvJc50secJHRox6pDWKMnC8jQEwEiguRrRebuWG	FACULTY	9988776614	t	2026-06-13 07:15:57.553717	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
d40b98a4-bd3b-4720-a40b-c988fa18c65d	faculty15@srmist.edu.in	$2b$12$Nq8o4x4/lPdg4M3a2tyYKOLtwAmDk8X3A3JXqjOKyjsMqqn46GHki	FACULTY	9988776615	t	2026-06-13 07:15:57.865007	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
41ef9f4f-14af-4027-99e8-7cfdddb7459b	faculty16@srmist.edu.in	$2b$12$1Do3YzYqzrzTc7ehhUO0IOxM0AQBThadpqQ8GOTil296U8yGAEiTC	FACULTY	9988776616	t	2026-06-13 07:15:58.137887	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
9554fc5c-a083-471c-b1dd-6b852df92a35	faculty17@srmist.edu.in	$2b$12$7E1WS81F0sy/PK9auyiNu.HDmpdoxoP2OeRAqOFcA7k3dY9gQ7jiS	FACULTY	9988776617	t	2026-06-13 07:15:58.403855	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
134c8195-028f-4392-8bcb-64fe1bafde9b	faculty18@srmist.edu.in	$2b$12$ZHnY7JQ2pL6UGbrHnXy4HO5pNTgiCHutD5zxHIRmnb4XotwNRC6ky	FACULTY	9988776618	t	2026-06-13 07:15:58.670816	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
18e53602-bdd3-4b5e-94ed-56a0553b95fd	faculty19@srmist.edu.in	$2b$12$uU8PSXAp7BGu4mea5w.RC.iXQAwmgjEDyvw9QSfhi72QkSFOPUk7e	FACULTY	9988776619	t	2026-06-13 07:15:58.945928	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
91f2a192-96af-4566-bd2c-6f400306258a	faculty20@srmist.edu.in	$2b$12$5nkj8y/1xPwMqBJt5LqFMOH8aq3sLz/MtfrCKexeEARNzP4LWrFBu	FACULTY	9988776620	t	2026-06-13 07:15:59.237016	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
71097a7e-4fe4-4c06-a8e8-2fee180ce321	24srm001@srmist.edu.in	$2b$12$mUNHaNr2GdmmYSuuJwlZXuNPmVb4g0pDGIMs/1W20uIWZfpOIuVRe	STUDENT	9000000001	t	2026-06-13 07:15:59.570377	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
9bd73420-f791-4907-a31c-a3c8ed9ba78b	24srm002@srmist.edu.in	$2b$12$eIG/rwRvX2JUnb2QeiOmWe.PVPPypcVWW.KE8OLbIq2QqHc0Sq7GS	STUDENT	9000000002	t	2026-06-13 07:15:59.897242	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
032183ec-32e7-4f55-925f-8dca6b7c0eaa	24srm003@srmist.edu.in	$2b$12$y4JRGHkur0ohPOgZSdwr.uAZXDlHkXg2dKWnrps4IsmT.yP6Qdr2C	STUDENT	9000000003	t	2026-06-13 07:16:00.193888	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
65a77d8a-4f58-47fe-b438-1a2f6d2659bb	24srm004@srmist.edu.in	$2b$12$S5qqEqWwo8b7k34s/bkF..Eyta6zNC2P/cbmPrbnTkpYkoS2CA3b.	STUDENT	9000000004	t	2026-06-13 07:16:00.488854	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
1b765c11-628e-4ed6-b3cc-5952f3d082c5	24srm005@srmist.edu.in	$2b$12$CDwI/kr51mD7YdjzZF.SfOAQPWxBxfhVEU9ZGPF/vETepDOZsHjZC	STUDENT	9000000005	t	2026-06-13 07:16:00.768727	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
a9fc73f6-8f81-4703-8be9-4428c3eb0b0d	24srm006@srmist.edu.in	$2b$12$maeGZO1j5gi046zx2cw2w.e7IeVeY3BJTQF04KwC4feVEG7dMfeYG	STUDENT	9000000006	t	2026-06-13 07:16:01.062716	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
29c0ef73-d9a9-46f7-8c9e-e405468bf876	24srm007@srmist.edu.in	$2b$12$/.prwYkgqOKYOSv7K2M/9OHg8qX26ZRFp9v4/TNPkGB.yb.hdiszC	STUDENT	9000000007	t	2026-06-13 07:16:01.346127	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
471b7ac0-c956-4983-b4b8-35552cde4b05	24srm008@srmist.edu.in	$2b$12$xZ0rBOsxDdSyOhpmYf7VxeelXscEAKLAuY7pRSKAiTGPoXcMoumxe	STUDENT	9000000008	t	2026-06-13 07:16:01.613429	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
3b98d25b-879f-47e1-ac23-4f55a215e300	24srm009@srmist.edu.in	$2b$12$DHbQDxewVi3kNUY7d0rQtOeCjeSiLPk/x9kwEE8YgATXJJ1WnHFke	STUDENT	9000000009	t	2026-06-13 07:16:01.887623	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
bbf052d2-4ffe-4a22-bf8f-15264873d31f	24srm010@srmist.edu.in	$2b$12$BWHh8WT8UxoRD0SgvT6SrewY1shfo0QCR/rMA1kK2KNusX5VcSsU6	STUDENT	9000000010	t	2026-06-13 07:16:02.183943	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
052031dc-d094-44b6-8d5c-7be69a8441f8	24srm011@srmist.edu.in	$2b$12$iO3nM7br5lhDL.4hjETbZe56AI9iRirtHjo01ZPC6tDRu5mUqBjXO	STUDENT	9000000011	t	2026-06-13 07:16:02.456718	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
752ed4ec-d969-495e-9392-cd3076fe02db	24srm012@srmist.edu.in	$2b$12$yzclJicS2hWBEKlbfDoL8.3HKAdUVgzKEzhGxbF6CCDCSdNddAIFW	STUDENT	9000000012	t	2026-06-13 07:16:02.759924	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
26b45355-2756-4dbc-9b87-f2e00b6b4f27	24srm013@srmist.edu.in	$2b$12$UwVKSdYaUBjGEoVApoi2RulPtK2GaGquRUClZHMZJ9g4ORBhNgZvW	STUDENT	9000000013	t	2026-06-13 07:16:03.087006	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
a35c48ad-f3a6-4f79-ae8c-48318994ac73	24srm014@srmist.edu.in	$2b$12$NekYk3K.3gyaTt8DGazJxOOP6Ni2b7T2IDEZzM1OOQQ4gpOCOpVim	STUDENT	9000000014	t	2026-06-13 07:16:03.385862	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
c38ce2e7-204d-46d4-87d9-391968495636	24srm015@srmist.edu.in	$2b$12$2LLtyLt/qbCLswNSLluugOKxScDAndmGNIbSEylTQCrkF5CtnR3QG	STUDENT	9000000015	t	2026-06-13 07:16:03.709645	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
0b9b893a-8846-4b10-94d3-eded74e3111c	24srm016@srmist.edu.in	$2b$12$tBG7Y4CeAOrL.O4uU6b.CeanE.tn50ml8hoM7HjblWEBfsEat8I2i	STUDENT	9000000016	t	2026-06-13 07:16:04.033518	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
d47ee77b-8937-418b-a4d0-68e296101d15	24srm017@srmist.edu.in	$2b$12$f3UYD.VuFKIdcTuqStb0/ebWSFMwP3MOmuTneiNLgRcJ7pe5URmQ2	STUDENT	9000000017	t	2026-06-13 07:16:04.371486	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
aefcf6e7-15b0-4a65-82f3-d5fe2505fe2d	24srm018@srmist.edu.in	$2b$12$/Njx1./tgFtmUWqoSxcatOTTxMx4Cv3Qcb1F6bFbxEpAHLqbXOBYq	STUDENT	9000000018	t	2026-06-13 07:16:04.69766	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
ddcf953c-e06c-44d4-a6dd-de2086ed7324	24srm019@srmist.edu.in	$2b$12$WIX.SQeSzXz9Bi32J0uqZe6gnZRjsaC0aiF6FkSIZWT02.OgI0LjG	STUDENT	9000000019	t	2026-06-13 07:16:05.015134	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
fd1fe2a0-f4b6-49a0-b16e-1e8577eecdef	24srm020@srmist.edu.in	$2b$12$i7iGGj90tpUoxapi0kiEPeNZwFVjoI5GBzBXaIVUaB7FGiRWuo0Me	STUDENT	9000000020	t	2026-06-13 07:16:05.302846	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
754d88fa-7837-4d53-8a28-22ede76818c0	24srm021@srmist.edu.in	$2b$12$ViZRvPbOqiPE.X8d6hFRAOQ/2gChZtN33OQTXBp2aI45ADgveSP7u	STUDENT	9000000021	t	2026-06-13 07:16:05.588157	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
ea0d9d30-7593-4557-993f-c56481673cc2	24srm022@srmist.edu.in	$2b$12$U1IKuptQs42MWO/BIQVpG..zfPuAy4gkv6K7aY0A2qbARULg8c.5W	STUDENT	9000000022	t	2026-06-13 07:16:05.900603	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
4852b9e5-bd5b-410e-95cd-3bdc6c7d4a13	24srm023@srmist.edu.in	$2b$12$P.WDwO7YvckDYFV1KFEVE.SEMqwaMv/hA3my68jHkG1YIZWjoFT82	STUDENT	9000000023	t	2026-06-13 07:16:06.194059	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
79e2ff21-342e-4e8c-9af3-4abab2802af8	24srm024@srmist.edu.in	$2b$12$BjMnIfjHtn33WhQHRVqw/eGaFm/ZD1IErk0hc/eUZYyrhyRmlHaTe	STUDENT	9000000024	t	2026-06-13 07:16:06.460247	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
98131218-9748-41a6-becd-636869979615	24srm025@srmist.edu.in	$2b$12$aF.06Sg7fCKA42hZG3VWFOcojS4HsY3YGZSZ.iqrIwBFAGFUA7OHG	STUDENT	9000000025	t	2026-06-13 07:16:06.755704	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
563fa467-f8fa-47a6-94fb-9f69be5a8dba	24srm026@srmist.edu.in	$2b$12$KV4.5bM6e1cTmGdk9HH3Q.xmw/6r3eAzFabTqk1QH3xS.YLkaXbDG	STUDENT	9000000026	t	2026-06-13 07:16:07.02913	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
974dfd1f-340b-4f53-b01d-79eccf913af2	24srm027@srmist.edu.in	$2b$12$kTiLaCLJdugInoQoIU3W1umHsbmH9JqGpYcJWfGYRgPSaljCgPhju	STUDENT	9000000027	t	2026-06-13 07:16:07.320363	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
dd10af4b-4c5e-4844-9306-b0d651a29bdd	24srm028@srmist.edu.in	$2b$12$eIRuacpFPzLN2gie.I3meeOJ2NRxEr.VLf0onB4U8NYRLdNdvTequ	STUDENT	9000000028	t	2026-06-13 07:16:07.615913	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
b64425d9-92ba-44c6-9203-fc6347a988b2	24srm029@srmist.edu.in	$2b$12$3lL8xVR6udABaEASsDeuAuQuSM8ZM6J3UoWq2Rc697yUZGRbZ6wFW	STUDENT	9000000029	t	2026-06-13 07:16:07.911442	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
7e212f08-02fd-4121-b2e9-4925ffa92f66	24srm030@srmist.edu.in	$2b$12$qnyBiB5RezR27wQgEg5v/OtnCXPpZHoa7Lc.h8l2Ij4MgmE8dFpZu	STUDENT	9000000030	t	2026-06-13 07:16:08.203056	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
2355a51c-2e2b-44b6-a21f-dfc7f08a15be	24srm031@srmist.edu.in	$2b$12$43AVl9CwAULt76yaJZH8iu5RD4.3pF2FtEqxtqxVbIPBXnQiwOlfm	STUDENT	9000000031	t	2026-06-13 07:16:08.489821	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
57f565ff-96e1-406f-8be0-9844719a5c18	24srm032@srmist.edu.in	$2b$12$oN0BTvKLwTCb0D9bzJICkO86O1cQMHCcCCxYC..w/3CiLN8glmXVK	STUDENT	9000000032	t	2026-06-13 07:16:08.8042	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
0129b199-7759-4c48-8b8b-d0a63540ee1e	24srm033@srmist.edu.in	$2b$12$D8uyA2CWCcgWqI0ir6Apo.8a3PyrdYnWbLLPVSladWsQx4hzXhKCa	STUDENT	9000000033	t	2026-06-13 07:16:09.102537	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
f90c0e63-1696-4d4b-b3ed-163399fc2514	24srm034@srmist.edu.in	$2b$12$GvLEwsXJexsrcoQh72Mq/upLLfo6y3fptHy4Ozh0ktoX5R/Q3I9Ru	STUDENT	9000000034	t	2026-06-13 07:16:09.408899	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
7826db9f-52d0-4887-9aca-7035e1686218	24srm035@srmist.edu.in	$2b$12$jjCrnnHm8pWLoYLftxqvN.BHX77U1ezW14KeKawvQjHppgaO.VF3K	STUDENT	9000000035	t	2026-06-13 07:16:09.740372	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
880f3119-8169-4ffc-9da7-d66d651006ec	24srm036@srmist.edu.in	$2b$12$X0jnpBziQqOMDlu7CpF6h.26g39L5zesOC8yVS8uAFp8D.6MasQDi	STUDENT	9000000036	t	2026-06-13 07:16:10.043232	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
3d9b3bac-e192-4c9d-9795-87ba23b76aa3	24srm037@srmist.edu.in	$2b$12$A9F/.87in.OemEK1QKy5P.hC2SkoTmF8VFV3zGM2sBxKCvq/88c4u	STUDENT	9000000037	t	2026-06-13 07:16:10.340829	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
ff8ed635-5188-4d0e-8c12-042cbfc16fe5	24srm038@srmist.edu.in	$2b$12$kgXMOrwTuD0P3FQO3fXi7OljBx5ncTJm6n7NNi4D2rCy8BaW.3KAm	STUDENT	9000000038	t	2026-06-13 07:16:10.680275	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
33f78969-5d33-488e-9fa7-52c0d41c96b2	24srm039@srmist.edu.in	$2b$12$7gmbI2a.e9XJysjrhDTZ7e82y8uI.72pwm1IIBLNhjxEVMOCC30Cu	STUDENT	9000000039	t	2026-06-13 07:16:10.987521	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
ca60d543-c996-4f17-b0b1-a6d1349df074	24srm040@srmist.edu.in	$2b$12$ZEFoFjJvS2mc9NeZFanxZ.qJc.h1KqdzaoY9RSlxpBEsJJKoFLyA6	STUDENT	9000000040	t	2026-06-13 07:16:11.255049	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
b13b09b1-eba6-4a05-a0e3-f5173ce1cb64	24srm041@srmist.edu.in	$2b$12$Sr0x9b/EcAeRnUgUnMl8a.H9wNRjoBYH4Kb7CpkACkjIMxNhqc18m	STUDENT	9000000041	t	2026-06-13 07:16:11.524296	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
3ba1088f-da95-4c97-94c5-f25355824132	24srm042@srmist.edu.in	$2b$12$IF5W8DVr.MaaI2o7KDvJhuIzWicJvG9jQWiUUEDxCd91qLUCsdpZC	STUDENT	9000000042	t	2026-06-13 07:16:11.787377	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
735eb6ea-6b33-4bb4-8d25-0b593c22225d	24srm043@srmist.edu.in	$2b$12$bZcHNrgMP/lBEnXu46h3r.t2neOCa72yiAApKkhzSoCytYn5gul3e	STUDENT	9000000043	t	2026-06-13 07:16:12.068995	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
42cd237d-75e9-458a-8596-a16471970d13	24srm044@srmist.edu.in	$2b$12$Q9vzha.LoM6mVfxTrRot2ep3ajiUmaf2BYTCcaCYQ3EhZsUe6Sg/m	STUDENT	9000000044	t	2026-06-13 07:16:12.396892	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
b031fd8d-40e7-4faf-b857-025fd59be574	24srm045@srmist.edu.in	$2b$12$3SS2RCdXkdeuQTK3B2AjfuO8n2Dv6TuHcYmpaGq0eWfXJ25XyJBTC	STUDENT	9000000045	t	2026-06-13 07:16:12.669752	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
03c8308c-51cc-412c-b092-bda99e3851bb	24srm046@srmist.edu.in	$2b$12$J66urWyiOGtYn1XV5zMNhu.DqAXPhT6N801floTdjx49NKFOTOo4.	STUDENT	9000000046	t	2026-06-13 07:16:12.947558	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
70ab0c9e-e622-4fcb-ba74-2c71d715d1b4	24srm047@srmist.edu.in	$2b$12$VsjFlT3hy7yGQKlosz7WpOZk8ElBJE9Yd/ALlT0G4AriAyfP5viN2	STUDENT	9000000047	t	2026-06-13 07:16:13.221313	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
e2855780-d2a5-43b9-92b7-519db5d4c4c9	24srm048@srmist.edu.in	$2b$12$grGaX54DKJslUaky1SkxHuLtU6lLjYjP6qTPTVJhW4EFv6Phmr7qm	STUDENT	9000000048	t	2026-06-13 07:16:13.48688	4df602f6-6142-477d-9245-8ae40c49cff2	120a02b3-2ce1-4dc2-ab15-0dcddfb18269
3377cfe9-6ab8-419a-8923-93df45e0abfc	24srm049@srmist.edu.in	$2b$12$lkgpdP.YyvGXFsVfXE1izuxS4cHBsXioWH7REJuEwZWx7WAdcLKDS	STUDENT	9000000049	t	2026-06-13 07:16:13.77798	4df602f6-6142-477d-9245-8ae40c49cff2	bff398ef-9c99-4658-be03-0eabfdf6f9c4
6fc48a4a-324f-49fa-997a-4481085e5b95	24srm050@srmist.edu.in	$2b$12$yZa0z4tmEMLhSBGhXTXVhuBQbNLudw2fuAl9oRGtzwbERnOjveh/6	STUDENT	9000000050	t	2026-06-13 07:16:14.074158	4df602f6-6142-477d-9245-8ae40c49cff2	72958370-78e8-4805-bbff-c8db9847d6e1
4eabecf6-16ce-45ef-a153-72db48bcfc14	admin@rajalakshmi.edu.in	$2b$12$uJmDAtT1IuGryxfGtuUcZejmn7ORgrdEXNcszjKnzo2XwA5gy0mkm	ADMIN	9876543290	t	2026-06-13 07:16:14.375207	80316235-f21b-4f82-a851-487072b121f5	\N
ec7dc995-3327-49be-8b82-b8b2e2ea690d	faculty1@rajalakshmi.edu.in	$2b$12$M8WmZg7PeXNa0tsF8Sq0M.89aJ/9FbXKSc6raxMR3HZOgS.r84sg.	FACULTY	9988776601	t	2026-06-13 07:16:14.656684	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
50fbeae0-5407-4d20-9418-e97ef10cec81	faculty2@rajalakshmi.edu.in	$2b$12$rhPyWFdkikZfnyi0KrC9P.i4jLGZfEHpMII9G/zv7tT9Yn3NkPXAC	FACULTY	9988776602	t	2026-06-13 07:16:15.226228	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
8fbdc1bd-0de5-4587-ac95-c3de6b6fd80d	faculty3@rajalakshmi.edu.in	$2b$12$F34f3QdUptd8k0PoSH.teezC7kSST95rRmTXyQ9rswWgOT/tLtxCe	FACULTY	9988776603	t	2026-06-13 07:16:15.532574	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
b12f0510-f50d-4e56-8b1b-e5c3c83f88a3	faculty4@rajalakshmi.edu.in	$2b$12$ZsEjsYLou8OuHh6EhDH7dOy/uFblSlVkcT7.PvTcqPnigU3aa7/G6	FACULTY	9988776604	t	2026-06-13 07:16:15.804816	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
65902115-1979-4b00-8325-1073f17bfd7e	faculty5@rajalakshmi.edu.in	$2b$12$/V/NhQejnOaEPd4I4Z1wC.s.Ig1IbpaFs5.A/SBt3Vw1yTVJmw/Pq	FACULTY	9988776605	t	2026-06-13 07:16:16.080272	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
120974f9-2732-46b1-ad5b-6b35269e2b3b	faculty6@rajalakshmi.edu.in	$2b$12$eYYhXxF3m40Cj7cb5G0ZeuC3XrjV8eae0WLEEectWDJg6O1yoLTiO	FACULTY	9988776606	t	2026-06-13 07:16:16.344188	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
900725e4-fb16-465c-80e2-9eb84d214130	faculty7@rajalakshmi.edu.in	$2b$12$DkODy9NLjHDascaNNXzJ3Ozx9LMPAzJ4OPY/bMsmWnKUTYYyQNLgy	FACULTY	9988776607	t	2026-06-13 07:16:16.612732	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
35a72d9d-4d14-4f25-ad79-afce7869fa1f	faculty8@rajalakshmi.edu.in	$2b$12$gAOS65VwzRch0SYbdS4COuX4otZrJpT3kQ39Djf1CglnuqXOUjEAe	FACULTY	9988776608	t	2026-06-13 07:16:16.906412	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
d7affde7-452a-482f-ba18-56c283f5589b	faculty9@rajalakshmi.edu.in	$2b$12$20P5TQhHqItEKB1j8xK0FeyOgwf9vFOe3e2PZvIpSe/JYMxIU8pPK	FACULTY	9988776609	t	2026-06-13 07:16:17.182329	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
5c619fef-ca56-46c5-824f-83dc4a1aa6c8	faculty10@rajalakshmi.edu.in	$2b$12$.lZg3vFC3nitbiGehMtspeiHYzkpiEiTD9r4GsojipFGvEjw6BJby	FACULTY	9988776610	t	2026-06-13 07:16:17.457927	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
ed56f9c9-bc01-4edd-a9bc-cd27d007146c	faculty11@rajalakshmi.edu.in	$2b$12$TKNNRYLzWV9gQ8p5hy/vm.HzGGV2BlPYm34m76b3NYaNgycH8mtRi	FACULTY	9988776611	t	2026-06-13 07:16:17.71913	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
e0435499-11d8-4732-bd82-0e5e6b6c0aa9	faculty12@rajalakshmi.edu.in	$2b$12$30P5BF9OPruPgtFZHgKWuu4xbG0ww4KgM5bRa3I/xkN1t/rA3xnwC	FACULTY	9988776612	t	2026-06-13 07:16:17.996487	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
9c4f8ec6-54d9-40b7-918d-ef1d8e060fc5	faculty13@rajalakshmi.edu.in	$2b$12$evr9G04apkAopDGDvz60y.9WCtJnb6.mRKjJ2Kcx3NcSghwP20CiW	FACULTY	9988776613	t	2026-06-13 07:16:18.298666	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
9df2690f-9857-4326-a204-c998133627d4	faculty14@rajalakshmi.edu.in	$2b$12$HD4NCnu88qMqxJxInXGe1eh5trzLFzjR.UVkmQZ3sQmXc6.YUHh9.	FACULTY	9988776614	t	2026-06-13 07:16:18.568771	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
921268e1-465d-42ac-99a0-c043a4e1bee8	faculty15@rajalakshmi.edu.in	$2b$12$FbJGma92ic9QBGvB.Ixdq.Z/F1HLROJASemkptb7cYXtc4MWlBttO	FACULTY	9988776615	t	2026-06-13 07:16:18.958253	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
2b0965be-4ba8-436c-b2bc-52c6128ca86e	faculty16@rajalakshmi.edu.in	$2b$12$nN2wfXDPF43EROdwx6MFRuVk4mrZlHZM/l5tjfKbqVhjzo3eohK4u	FACULTY	9988776616	t	2026-06-13 07:16:19.67956	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
95dbbab9-cefd-4614-a59d-c5e97a884eaa	faculty17@rajalakshmi.edu.in	$2b$12$1VLWJj7ioB8GbB7bMuvgM.lru6k6JOZfuaRHzXV5GbZz2bP.rg76O	FACULTY	9988776617	t	2026-06-13 07:16:20.198765	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
d611f17b-a0aa-4f64-a40e-a14537f89bf9	faculty18@rajalakshmi.edu.in	$2b$12$9EKRKhqPkryNHEnz889dgOjhnRSrsh.Ofcpdjp72wdxtFEFxxtuJO	FACULTY	9988776618	t	2026-06-13 07:16:20.506667	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
9878941d-4272-477c-a1e5-3989816877d2	faculty19@rajalakshmi.edu.in	$2b$12$kAtyGQTQLPbtKjQBdtYrAufbLMObvQhwlghyej1ukq2zbtuonaZ12	FACULTY	9988776619	t	2026-06-13 07:16:20.823984	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
ccf1aa68-7b7b-4209-95a2-b5bbd8995d88	faculty20@rajalakshmi.edu.in	$2b$12$1eGg97.m3LvrVM7cZgIGgOagxl5z/6Ds4VuY5Ee0yVODvOOOfvsiW	FACULTY	9988776620	t	2026-06-13 07:16:21.128946	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
b567386e-7668-4080-8357-7becc6ea714a	24rec001@rajalakshmi.edu.in	$2b$12$bx4x8p9sZwVTxNtfMg2IK.rhftjaq142zronVoCmlAYszkafTvrie	STUDENT	9000000001	t	2026-06-13 07:16:21.417644	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
e732d210-e31a-49c0-a366-8bc1146643ed	24rec002@rajalakshmi.edu.in	$2b$12$sCb.eL.mYPiWExF6svQavuIe5cK7OB9UT.TMl8Dy5PAE6nJk4Z4Wy	STUDENT	9000000002	t	2026-06-13 07:16:21.691995	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
11cd6318-c8e6-4f9f-b847-670bc105205f	24rec003@rajalakshmi.edu.in	$2b$12$.D6YxCe6ycjPmmgxhgHIVOsJ/Uihrs0ow.vx3z9iYJv5Lc7Mthc6e	STUDENT	9000000003	t	2026-06-13 07:16:21.951891	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
b9f2c161-be1c-4b31-a491-2fd1f9d0c260	24rec004@rajalakshmi.edu.in	$2b$12$8wDilpx9Ht.kuU/gImXj4eGRdWTP8wbblNrZepXeWd6kjnnG9Gc.O	STUDENT	9000000004	t	2026-06-13 07:16:22.221638	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
d422b091-6a17-4322-8866-5cd9b7268e15	24rec005@rajalakshmi.edu.in	$2b$12$0ebjIL3VYWpHajE1JcrPY.qc5qRSNliM3wNapO7kZL09awGSBYjoG	STUDENT	9000000005	t	2026-06-13 07:16:22.518079	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
106abc1f-a757-4d83-8c53-7e2264e6db9c	24rec006@rajalakshmi.edu.in	$2b$12$dO6nWLSNi0g3FdY5EP6G3up1HGPkgtdVeYKVyrH8VkqFj479rlVI.	STUDENT	9000000006	t	2026-06-13 07:16:22.791489	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
07b813ec-a4d8-47b3-9afc-2c7ed6e291d4	24rec007@rajalakshmi.edu.in	$2b$12$IHKlDhYGdYuwNgH9OkzBRO0AuslV1uXArG5nrvURacMyXKjEmwja2	STUDENT	9000000007	t	2026-06-13 07:16:23.068121	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
0f492f2b-2b6a-4544-8d56-adccd1061cff	24rec008@rajalakshmi.edu.in	$2b$12$feZ6SSdq6heEt/CB3n3TweWHiaP38gpXN/xUWvcO7jvK9uq.R7GDq	STUDENT	9000000008	t	2026-06-13 07:16:23.356967	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
9085e0c0-9861-4947-8c47-4978498f8dea	24rec009@rajalakshmi.edu.in	$2b$12$/NBx4uxJ50RYvmmmjSAnzOc4.BL8jZ2XpcOc2s02Si1OfWCaWHuHe	STUDENT	9000000009	t	2026-06-13 07:16:23.625968	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
678c8dd1-cf7b-405f-a453-f16b3da2ff4b	24rec010@rajalakshmi.edu.in	$2b$12$8drrXQ9mxivOquOlmPPd9ue/jVPH0Vxs7ZOG8Yv4XAYI9ftfNY71.	STUDENT	9000000010	t	2026-06-13 07:16:23.914498	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
ab2bdd3a-ab1a-426b-b05d-f1d13b938b53	24rec011@rajalakshmi.edu.in	$2b$12$LTGqR6wihY3oZUy.1s0ZdeOeR1UPD2jzNNBou6GsoBr2xjjKG6Gvm	STUDENT	9000000011	t	2026-06-13 07:16:24.190289	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
30ad386a-ca28-41b1-b15f-f6a178381787	24rec012@rajalakshmi.edu.in	$2b$12$bTIWpugu32XmR7xiax4gwO9NY9Cb1HR35gvYYcWqLG8AFJkbxzkz6	STUDENT	9000000012	t	2026-06-13 07:16:24.446525	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
ebf298d2-8cb9-496d-bf94-e5c4b3ef4988	24rec013@rajalakshmi.edu.in	$2b$12$HnSUNRBshuN2eErn4Vmzx.4VnKYNuupPlOOCPh2lk4GUu6LH/6S6u	STUDENT	9000000013	t	2026-06-13 07:16:24.74289	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
c08def5e-c543-426d-a478-e9adbd232498	24rec014@rajalakshmi.edu.in	$2b$12$.SIYdvfEg1jU3iCK1Ib2kuue3DzLL7rT7O5Ai6W6g5xcST.1ZQJku	STUDENT	9000000014	t	2026-06-13 07:16:25.037106	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
1795a03f-8247-4a31-9481-ef3a9c2d2047	24rec015@rajalakshmi.edu.in	$2b$12$IbRSMfDEXMOdsriActVRdORMohamRW5gnV4hgrdrT4cEiyuYK8aL.	STUDENT	9000000015	t	2026-06-13 07:16:25.306166	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
9f65654c-0bc2-4751-acb2-e68ed0dc9143	24rec016@rajalakshmi.edu.in	$2b$12$XeziQ75QEUBZl4p2bSxHuedCEALn1rZmSX79Gvdku2CMUrp8h7xlO	STUDENT	9000000016	t	2026-06-13 07:16:25.587523	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
2c74d0a9-4f73-4681-8eeb-dec290748d68	24rec017@rajalakshmi.edu.in	$2b$12$UVA/Svt.5lwnIyrQtXXufex/t36dmM1w7Ovm8SBF8TUImRhjS2nQS	STUDENT	9000000017	t	2026-06-13 07:16:25.862511	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
595a2aff-909e-443a-874d-e5305049232b	24rec018@rajalakshmi.edu.in	$2b$12$kj0xBALxGbRIciw42mnPn.6sk9w3pmYPmXugBa/VuTtWM6h9n94x6	STUDENT	9000000018	t	2026-06-13 07:16:26.124454	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
067cba02-8ac2-4847-af07-bb6ef1dc8caa	24rec019@rajalakshmi.edu.in	$2b$12$JQoCP8yOvWwi0Gwm9Jh0wOOY3jO5cViqAlwVs9ApDYCCZGdQX6Nf6	STUDENT	9000000019	t	2026-06-13 07:16:26.411079	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
3da7596d-996a-4250-9c69-4411faaeb2f6	24rec020@rajalakshmi.edu.in	$2b$12$0NXUHcvr7DrX5LyAF/XwP.6BuJxIONqDF.dkkxsYvl6WbgXAcnEye	STUDENT	9000000020	t	2026-06-13 07:16:26.675643	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
b3da3ba1-1382-4cc5-8438-c096ee6f3b12	24rec021@rajalakshmi.edu.in	$2b$12$4C2.NQHaJ7xtRxlH7V72V.5wgPEMMHSv546/AMlFtco728mPtmAcO	STUDENT	9000000021	t	2026-06-13 07:16:26.940355	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
6eeda03f-cc36-4893-bacc-02aca7abc6ea	24rec022@rajalakshmi.edu.in	$2b$12$SP.E.zUp8j37YdMFFJ8VK.pBuKWQr/INzm5jkP1HjEEfvhQmYgih2	STUDENT	9000000022	t	2026-06-13 07:16:27.208489	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
c7bda684-43d9-4eeb-81cf-26cfe6068054	24rec023@rajalakshmi.edu.in	$2b$12$iswM3VkDRUNTZ3bseWDcS.YAJEGYkF5BWQwCtW5XKHYMr7rB23IRm	STUDENT	9000000023	t	2026-06-13 07:16:27.485729	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
21cde788-e038-4dba-8788-deda16bab7bf	24rec024@rajalakshmi.edu.in	$2b$12$9C8nx8J98EO1EQJfB0OR9uwFr1N/bWpRjP9rFgCMj50z7.8eU18dq	STUDENT	9000000024	t	2026-06-13 07:16:27.769052	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
84bf366c-f148-4158-9be8-9d1bb14bfe68	24rec025@rajalakshmi.edu.in	$2b$12$Zb2Le4QuLOGNIsLHJea.LOjdzvbeBemrbllLjYNTklfkbQjJyO3m2	STUDENT	9000000025	t	2026-06-13 07:16:28.040138	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
8d75a1cd-7a9c-4d5f-b44c-e194a168fae6	24rec026@rajalakshmi.edu.in	$2b$12$dTVI2kwyiHSJX5l7ED1RIuL8e.ov.HnESAFGWFdHrI8EPk6K.xTu2	STUDENT	9000000026	t	2026-06-13 07:16:28.308425	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
085de86f-b71c-4f88-80f5-92ff74236d27	24rec027@rajalakshmi.edu.in	$2b$12$WRDReNH9S6d4Sf6Vlt0mw.LiHib.sc4xLKqssC38HRZ3cP0j9ON1W	STUDENT	9000000027	t	2026-06-13 07:16:28.573524	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
0ad4056e-5a86-4249-8deb-cd1c00f758e8	24rec028@rajalakshmi.edu.in	$2b$12$25Vbxe4qUaE83z1CsoRBneXif7CvQEfjlqfIxDojf8nt14cu1cvvu	STUDENT	9000000028	t	2026-06-13 07:16:28.872037	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
34107d12-93d0-4de7-8359-1e6ab87022e3	24rec029@rajalakshmi.edu.in	$2b$12$eGNMIWHCeHJ7XfOlcDZ7pe4zYR9Xs3F1kg9EWvf7QQZ9Run4U1k6K	STUDENT	9000000029	t	2026-06-13 07:16:29.156041	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
bcb945c6-946e-4423-869b-e7e2d6b34ae5	24rec030@rajalakshmi.edu.in	$2b$12$aWNjzn/Ew989t7MFoFVTzuJP99ETMySvRVqFORucxFi2zcCVQ1X/K	STUDENT	9000000030	t	2026-06-13 07:16:29.443085	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
288e82f3-514c-46cc-80d2-38c45559b875	24rec031@rajalakshmi.edu.in	$2b$12$PfFOuM2CD9Hdq0k1DAmjF.ve.A4qPwAJOAfxA4j5J3/6X81nTTqwe	STUDENT	9000000031	t	2026-06-13 07:16:29.844404	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
e2dcf024-a033-40bb-a9c4-cd398238043e	24rec032@rajalakshmi.edu.in	$2b$12$mI8s8UigybaUgjmttQsD2uL1QS3QHtMNd5UpyB7d0xbpxRzXXIQU6	STUDENT	9000000032	t	2026-06-13 07:16:30.14668	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
7ec9c354-52d3-41ad-9ba8-d1a8a9697340	24rec033@rajalakshmi.edu.in	$2b$12$sb6yMeDmELifj7cCMmy0/./6gcCOHjmLQrZpx0N/FICoapwdaaacK	STUDENT	9000000033	t	2026-06-13 07:16:30.423169	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
0d7bff47-d8b5-4822-bf38-62a63475b5e4	24rec034@rajalakshmi.edu.in	$2b$12$2AsN2Ry3QVUKzHSXzJFfd.d5VjyBycea52Y1Q/NMJdCYJwMSaP/o.	STUDENT	9000000034	t	2026-06-13 07:16:30.7478	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
82ee3e81-c4f1-41a7-99e1-a5d28a464145	24rec035@rajalakshmi.edu.in	$2b$12$e5s2AJzM.tBy2aJkL0nxqeiLJI6YGeg.qS5RfLIStNrQW.k6vCTaq	STUDENT	9000000035	t	2026-06-13 07:16:31.03405	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
3646d0e8-2551-41b7-8150-877bb57a85a3	24rec036@rajalakshmi.edu.in	$2b$12$dU/rlseyqzwKgKS.ZYOT2e5991lQ0Q6Us2BPlnot4T.k0s81yNYRO	STUDENT	9000000036	t	2026-06-13 07:16:31.313	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
6c69362e-5aee-41ae-9592-12ffabb1770c	24rec037@rajalakshmi.edu.in	$2b$12$0ZP76MtzvZJpctoSQy76CeNixOEvVs9fs5lKCWDo3JEwr0XNMd6mG	STUDENT	9000000037	t	2026-06-13 07:16:31.569072	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
004ab06f-bfb6-4724-aaf7-9f897ad947a8	24rec038@rajalakshmi.edu.in	$2b$12$R6Jmg/fK/q2uCOi9nz3EWOm9XQHAoy7spL/ihSMQDCRbayF3qE.Cy	STUDENT	9000000038	t	2026-06-13 07:16:31.878599	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
c858b44d-328f-478b-a99b-1182f7a8ce4b	24rec039@rajalakshmi.edu.in	$2b$12$Wu8ZZj1kIkQP0HZgAqXpm.hsW83513El6Jp5tFDg/wxHhuq/gXJXG	STUDENT	9000000039	t	2026-06-13 07:16:32.17294	80316235-f21b-4f82-a851-487072b121f5	2ce3c25a-620d-49cb-89f8-ca0a049be905
139623e1-3d21-42ab-be76-62dad05f5e35	24rec040@rajalakshmi.edu.in	$2b$12$ONVmUUM/U2qIk7m2fkxIdu8YZZp7YSeXfUUsp9KuDXEJp/bkkp4IK	STUDENT	9000000040	t	2026-06-13 07:16:32.489847	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
1f9dafa9-12c5-45ae-9c30-0acd268d8b83	24rec041@rajalakshmi.edu.in	$2b$12$OrURahS7RWN3XrxdxKPCuOJBIAR7PF2LlqlA/nyGKPiiBx/YyF8K2	STUDENT	9000000041	t	2026-06-13 07:16:32.762331	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
868eb765-11d6-4dff-bea4-4de990b73cdb	24rec042@rajalakshmi.edu.in	$2b$12$FoM4JXc93bdyFTxfUAnKEOwgrbsfzqzcqnOPZgTc4DOG9lKsE37fy	STUDENT	9000000042	t	2026-06-13 07:16:33.04328	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
168205c2-489b-4e62-befb-9212b6ff304e	24rec043@rajalakshmi.edu.in	$2b$12$tTVWxnJijP2LRrx4r8yyNeeEuzpOLojScqCb55QSMhrO4/GXWdkUS	STUDENT	9000000043	t	2026-06-13 07:16:33.345648	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
450e916e-edc9-4419-852d-8f652571f074	24rec044@rajalakshmi.edu.in	$2b$12$t8vOxq.i29wdNvEcnZNERON6IxjX9WRAj9knW7ERXrXYMU2V8Ib1.	STUDENT	9000000044	t	2026-06-13 07:16:33.617931	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
75bd7049-9392-4fd1-936c-a3242e8cc2a5	24rec045@rajalakshmi.edu.in	$2b$12$jm6cJIF8yAyaLmp9YY/sc.jXJyTQ7WiMHxizHNg3RSNsgrSq45nDa	STUDENT	9000000045	t	2026-06-13 07:16:33.952871	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
cab1c05b-8ef9-4064-adfa-4e65f4513db0	24rec046@rajalakshmi.edu.in	$2b$12$6SJj3/TyaRfIgILvmq5wperGHn2Q6jWtwpV3Pe5rthLfl8j2ZJeje	STUDENT	9000000046	t	2026-06-13 07:16:34.222439	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
5ea3735b-975f-4897-a977-01a1618690f0	24rec047@rajalakshmi.edu.in	$2b$12$aDFE6.UhsQPYr7NeYPvQPOO71wZemoXFXtjFR6uf3EIDQGgOzTBiS	STUDENT	9000000047	t	2026-06-13 07:16:34.490172	80316235-f21b-4f82-a851-487072b121f5	9e2beb53-7e3e-46ea-a0ca-9cacecb80ab2
eebed014-451a-46f2-b6c9-c8432e8f7750	24rec048@rajalakshmi.edu.in	$2b$12$7Qr47IoPbfWklXmuXYnIw.8lxbo4AdcbJukP9phLKUMynRflIa0KK	STUDENT	9000000048	t	2026-06-13 07:16:34.763118	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
8f775f04-a051-4e7b-ae06-a27cbe30a865	24rec049@rajalakshmi.edu.in	$2b$12$Nj2AeqxnmVYKz6cvk.sIje38Ra5OCDP7dj47yJj7Fg0USdvOrMa.2	STUDENT	9000000049	t	2026-06-13 07:16:35.03749	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
b7e523ca-140a-4446-8090-e85dc22df548	24rec050@rajalakshmi.edu.in	$2b$12$RGjuE7ZWSZbmsrnzWRfDtOraB4Tooqbrp1jvTMuxXHmvrBluKoNg6	STUDENT	9000000050	t	2026-06-13 07:16:35.335393	80316235-f21b-4f82-a851-487072b121f5	cac7c0c3-f3d4-4a5a-8ea2-b3397e938212
921575da-e8d1-445e-884d-19eda7bb4d27	admin@psgtech.edu	$2b$12$ZF.al2GA6GaY03gyB3HmheRfkiib5/B6SYhdTjY8LdsqjFMlQFQfC	ADMIN	9876543293	t	2026-06-13 07:16:35.618542	f3b59378-7b08-40bd-a9fe-91a059905162	\N
6525ef81-09b9-4000-a046-b888ee9d7fc7	faculty1@psgtech.edu	$2b$12$KjTmtssyU/KuCi/9aIx4b.DXyIJGlbQ50qGztldwuZlhpM8SRBVDW	FACULTY	9988776601	t	2026-06-13 07:16:35.957645	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
370c3ddc-333e-4b74-9146-54e9e5bfe73b	faculty2@psgtech.edu	$2b$12$Q.tF4O487fbR3/t/lDSb0eo2lXPVUqwjg4dKSo/quIHbB0WcChY.S	FACULTY	9988776602	t	2026-06-13 07:16:36.256986	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
7a7e2e74-0530-4a6a-90ef-f6e94ff1af19	faculty3@psgtech.edu	$2b$12$7zhUiyTDBL24po.KGoFM8OC.VP0pTx/ZaHxTGRjCTQ4zxnOk7S7La	FACULTY	9988776603	t	2026-06-13 07:16:36.536785	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
c9b67b03-9261-4d5f-b4fc-00d2776cca06	faculty4@psgtech.edu	$2b$12$InIlx.n0q3vVYZkApyfkSuGXZNO8JbSCdTUnlBTlaWAc4C5jPlNtW	FACULTY	9988776604	t	2026-06-13 07:16:36.821414	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
6d9ac216-04f6-4db5-b1fe-6b0ff5f534d5	faculty5@psgtech.edu	$2b$12$uYoLiCRX2S4fn36WPWNxbuVp.UsTpVPa6Yqd58aM53AYr00svxEtG	FACULTY	9988776605	t	2026-06-13 07:16:37.120109	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
0fdd91c6-095c-4057-a1f5-d92a3d448fbb	faculty6@psgtech.edu	$2b$12$mqSymWbMkV91zvO1DFo5quTAoiiWTH76J.2PqaPUmbuY.xKAj6ds6	FACULTY	9988776606	t	2026-06-13 07:16:37.395068	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
aed84f32-4983-42e9-88d6-2c60f87e1c53	faculty7@psgtech.edu	$2b$12$vNXbO9oHKd01.T7jJpFdaultowYtLRUMF/GUV.npcyKExu1AwXZ.q	FACULTY	9988776607	t	2026-06-13 07:16:37.701307	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
625c3045-78ff-4043-94e2-f85acc022ceb	faculty8@psgtech.edu	$2b$12$PGDmfgj4z8imDFk5hbHhd.ykInmqrSJSKveyJk1DZKv9L3jVT346G	FACULTY	9988776608	t	2026-06-13 07:16:38.022979	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
16406945-3878-4378-95db-59e25607f1e0	faculty9@psgtech.edu	$2b$12$PJ/hB5sMmYp2Rq3o04PRZOsEXsgNymR85JVC0vbxHfBzngbOxm/bK	FACULTY	9988776609	t	2026-06-13 07:16:38.301233	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
d073343b-0487-44d0-b973-4aac14301ae7	faculty10@psgtech.edu	$2b$12$Ql/mLuFmfT2Y1dUY4DO/yuLaGZlZTSodOuJOenwtRRvRL3QyF3Svy	FACULTY	9988776610	t	2026-06-13 07:16:38.575937	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
c43884db-2d9f-41f8-9fa1-7bcde08ea780	faculty11@psgtech.edu	$2b$12$W61IAL/RGMcHfbsv752Ey.IPKWn5belgR35hrh7ZJ.MgPwfuTfNIG	FACULTY	9988776611	t	2026-06-13 07:16:38.856136	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
51d56913-4592-4a74-80b8-953e3780f04c	faculty12@psgtech.edu	$2b$12$n.mGjPEOe5rwzU/aTH5W3uOK4Z1N6E6WoDjLKgcJf9py1ggyehGUe	FACULTY	9988776612	t	2026-06-13 07:16:39.166981	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
4dff792e-56c7-44c2-a85c-9b2d69737f8d	faculty13@psgtech.edu	$2b$12$3k6ZlZIWZOFdwKClqQcWve3W1QVjuQQtDkASb8eyQV/XnxOKL3tDy	FACULTY	9988776613	t	2026-06-13 07:16:39.430858	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
b3b33b6c-dfdf-45ed-89ac-56f64ed7c3f3	faculty14@psgtech.edu	$2b$12$gJkZn.7K/CJsu1u.NrZXFufRrHVSQzqwhn4TVBD/xt3U3ZbDbuvQu	FACULTY	9988776614	t	2026-06-13 07:16:39.704702	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
7888be9a-22c2-4f69-9492-90eff8bcaff4	faculty15@psgtech.edu	$2b$12$yJ5Q.7kN3/tYGDro426vve1zPN6cmUQqRIBNX4e9In0AOfMU5f2jG	FACULTY	9988776615	t	2026-06-13 07:16:39.984672	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
f4a762a1-a756-49bf-987d-2786db7902fc	faculty16@psgtech.edu	$2b$12$aHHFuFSfXO6ywbVUj9YPRezQQiy7zSHaKdlfia2rYgGzQfS7.oPN.	FACULTY	9988776616	t	2026-06-13 07:16:40.243874	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
9b7d471b-337e-4486-ac75-8badcd1f0cc5	faculty17@psgtech.edu	$2b$12$9Fehf0.kC5Yr9sHgvoyyF.4lGJ/QObwp.0yKP4n9CYpYR0Tijghh2	FACULTY	9988776617	t	2026-06-13 07:16:40.533865	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
6acd19f7-3141-4487-8072-0c4313048238	faculty18@psgtech.edu	$2b$12$Haz5/yIA/1ApahMdaJEfr.prU2QoaV1C5bZYroShvRm.mvpup5xKq	FACULTY	9988776618	t	2026-06-13 07:16:40.809051	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
71985b08-5476-45c2-ac6c-ac3eb3302935	faculty19@psgtech.edu	$2b$12$.diOWMdnd39sv0iP08mwduQmm8aMGdeLaWk6pXByWKDbgPPCSN3mu	FACULTY	9988776619	t	2026-06-13 07:16:41.129047	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
a71d9900-cdf2-4d5d-8870-2540ae2349a9	faculty20@psgtech.edu	$2b$12$sS1zAuT3paxn6//Y/itkFefrC8WoKRRb0cYWddmPkEFq4rY6bNUSG	FACULTY	9988776620	t	2026-06-13 07:16:41.405067	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
a706b206-c285-43b2-9020-281fa72a307d	24psg001@psgtech.edu	$2b$12$W.zjmj/EsMzhJxhszom5SeUWf9l6VZhgbuhBUMpGwYzrx.1IvNSV6	STUDENT	9000000001	t	2026-06-13 07:16:41.671233	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
13b1ca6c-5107-4b10-86fb-4dbc861c5785	24psg002@psgtech.edu	$2b$12$WLTkCfPZyc4NDaJNn0gxHOjrnJOti89Zz.juyEJ73HIcsxU0ppP5S	STUDENT	9000000002	t	2026-06-13 07:16:41.960197	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
097e8c0f-af53-4d82-8e71-388d7536afe8	24psg003@psgtech.edu	$2b$12$GgBXPA6agsyKeUZcIU65xODOIjBY2wzKnhj24aTlwqyC.1cy3Ayym	STUDENT	9000000003	t	2026-06-13 07:16:42.232686	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
dd3f82ab-7640-4605-82d3-df3d0ad4c714	24psg004@psgtech.edu	$2b$12$8OSC3yw4QjIK1pLD7qO1Suvubax8ou...ehzoh5XE.3turzrb8ve6	STUDENT	9000000004	t	2026-06-13 07:16:42.503916	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
61dd9e14-280d-4c0d-b22f-cc5dbf43b87b	24psg005@psgtech.edu	$2b$12$8NjBLGqwePshFF3OxiQcP.wfa79ovHS1F9sVjNgP6wLdNz9Jn1YEi	STUDENT	9000000005	t	2026-06-13 07:16:42.915653	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
832adce5-584a-45e3-9a7a-52e467a514f0	24psg006@psgtech.edu	$2b$12$JoA4dr/aKCYBKD1uWcsEQemaT6fDTF4DwJWajyt.zGrOwwVmlP/NW	STUDENT	9000000006	t	2026-06-13 07:16:43.194452	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
b0330a03-a6cc-43ff-bab4-c8463cbad0e3	24psg007@psgtech.edu	$2b$12$SaHWyzOKZSk9ZBr7z2qyNeMXh2xbxvgAK0QbwWVWlWlPdiR0l1tYW	STUDENT	9000000007	t	2026-06-13 07:16:43.485455	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
356a81d0-73d6-490a-bdcb-1f6084730e34	24psg008@psgtech.edu	$2b$12$/MSij8fEcaxtWA/8g5aWN.igGrF4y0b2Uq6EJ5XbW/thE2c7JnNli	STUDENT	9000000008	t	2026-06-13 07:16:43.753413	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
5ab82f86-cd4c-4edd-97a5-592371bc9b97	24psg009@psgtech.edu	$2b$12$2zeTqLWRUEWZfHDWDiwdROS.DMKiJ1XcKONRlIdrCCzMtJCHuCZta	STUDENT	9000000009	t	2026-06-13 07:16:44.02565	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
8579f9f3-a709-4ece-bdbe-0d65d881f897	24psg010@psgtech.edu	$2b$12$Rg1LrTOwO4eyxPMiVEl2MeLRjOnUs8JnDlsEHVxwiqXPfkyHPNg5S	STUDENT	9000000010	t	2026-06-13 07:16:44.317454	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
0fb96ea7-7403-4a68-b03c-745fa59ed9b5	24psg011@psgtech.edu	$2b$12$ILHizNutgbTcV3HhVXMbl.m7bn5pPGOWXc2KzlfAI4jVtU6RMmETi	STUDENT	9000000011	t	2026-06-13 07:16:44.609155	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
33b7f954-4596-4474-8e28-ed666030b2cb	24psg012@psgtech.edu	$2b$12$hoFNIX4kLMqFBMp6B2oPN.T8qaOs4EVGg1PrKDWxip8MQ1sSPwhGW	STUDENT	9000000012	t	2026-06-13 07:16:44.873351	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
27f90f3f-d7a6-4b54-97b6-4d971824ba3c	24psg013@psgtech.edu	$2b$12$3DDzlDbu0SxxAwL/qFO1beaYLXjSlG9V4G0MlaIotId68qzhGfhzG	STUDENT	9000000013	t	2026-06-13 07:16:45.144337	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
bb0c3a95-75d8-44a8-93d0-6dc9cf95614c	24psg014@psgtech.edu	$2b$12$qd1a3doNr43jAv1i5CmEgeF73dTG2ka7FcUqu955tzs3ULgzzfnqa	STUDENT	9000000014	t	2026-06-13 07:16:45.441733	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
888a26e6-a176-44de-8384-20338aaff1a6	24psg015@psgtech.edu	$2b$12$u3apQlQ4hmJZOuOdPe5Z.uZVy/s/WTrL4OnBBb5bpnzqMHh21saSK	STUDENT	9000000015	t	2026-06-13 07:16:45.708655	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
ce020559-5424-4def-9030-b468de88d52c	24psg016@psgtech.edu	$2b$12$Df.YRSs9mx7.HDE2nTUXXuM0lVsXoqdxakjU.VXA.FLMYFZpcsMXq	STUDENT	9000000016	t	2026-06-13 07:16:45.998386	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
39d0cbaa-b30c-42f1-ba91-de53ceefa648	24psg017@psgtech.edu	$2b$12$GkJ.kNc/aDLZRDAO8zJaieFp.HiBEgHS9yCJZqO3YA9WsW66KmjqK	STUDENT	9000000017	t	2026-06-13 07:16:46.306978	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
6a6a5644-9203-4158-9fce-e62089be689b	24psg018@psgtech.edu	$2b$12$dv1Y3.fDeYzMp8rN9sphHul/hM9MmNxOeAiB.1te2RmLOz3fIYz9y	STUDENT	9000000018	t	2026-06-13 07:16:46.602205	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
813f0654-b2bc-43c3-9142-381635359dcb	24psg019@psgtech.edu	$2b$12$gjInhYGG2a493LObNLnite9AUvl1RAswrDZiLbZcls5vv0KWXjo9G	STUDENT	9000000019	t	2026-06-13 07:16:46.885316	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
0dee2922-64a8-4a03-ba08-08398c69b50c	24psg020@psgtech.edu	$2b$12$allje5bw1mE6CkqCqaCqu.gS2gimfu3JM7FJPX0PLmoIGn5eecMCa	STUDENT	9000000020	t	2026-06-13 07:16:47.254502	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
aad404d0-e59f-4f29-9ba0-3ce7be7e5784	24psg021@psgtech.edu	$2b$12$FsChpkoAjaAEgDgrfd0M0e/Yps30EUzquWVlddwIccdSQ7iAVEsua	STUDENT	9000000021	t	2026-06-13 07:16:47.560713	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
f2c4cf97-1da3-4a14-bb7e-1ff4fa74ad83	24psg022@psgtech.edu	$2b$12$Mye/yeuqOKAoCqQ6QbAiWuLoN3M0V8EgZjnpeVgaFeR75jBBJOCwG	STUDENT	9000000022	t	2026-06-13 07:16:47.87478	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
63865441-e7b0-4594-b977-8c0910452ff9	24psg023@psgtech.edu	$2b$12$yShybcgry6WiVVr.C3jFWu.UpMpPiOcTNPoUXoVfCD8t8W.DH/hFS	STUDENT	9000000023	t	2026-06-13 07:16:48.202008	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
54d6fab5-65ad-4612-8d3d-cb40fc3cda82	24psg024@psgtech.edu	$2b$12$0Ubga7zBeWPjR3hD6XuT6eDf62OKriv5N1nrXZSs/2mmfHthvbJli	STUDENT	9000000024	t	2026-06-13 07:16:48.499865	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
91302cc6-b769-473b-9901-2dd4b09857cc	24psg025@psgtech.edu	$2b$12$Fev4VNZN6bVgzD6jLk3MWOeXP3gMvxHG8aqE3EYRBPuT4n5r5BsUm	STUDENT	9000000025	t	2026-06-13 07:16:48.793959	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
05628c6b-33b3-404b-ad9c-6c3e82bfb854	24psg026@psgtech.edu	$2b$12$8rhu1JJ/HYNyVokIGQiwy.gUMdHEOHXl6VJhAlE8H5ZWGxppEswnS	STUDENT	9000000026	t	2026-06-13 07:16:49.09267	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
a06da390-0509-4779-a446-0c5330b1a6af	24psg027@psgtech.edu	$2b$12$9WRWDeSvD/Vmlm6tpsVTFej8Gxbnz5dLf2LdW6cpiqE.ycMHMEZNW	STUDENT	9000000027	t	2026-06-13 07:16:49.393079	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
4f35eaa6-1991-4f4b-91a8-02a42ad77902	24psg028@psgtech.edu	$2b$12$SrE3XSS66OxGCKt3W/TI5OEX0n8/enuHsdFbpKBWDLNDi4W6hWUBi	STUDENT	9000000028	t	2026-06-13 07:16:49.693469	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
dda432fd-a6cc-41ef-bedc-d2b4eb30dddf	24psg029@psgtech.edu	$2b$12$aQPc7p2Ljy4fy6k7kiXsOeKTkUuoVEpydBBIcIqTah1YFBjFyFiWa	STUDENT	9000000029	t	2026-06-13 07:16:49.982735	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
7cf72462-b57e-4437-9c07-c342a9aaee59	24psg030@psgtech.edu	$2b$12$nwRuxHEDlCbHohqld4E2aOLN9lwtnxIdkcHyJwB3dUTIlWARFsf2G	STUDENT	9000000030	t	2026-06-13 07:16:50.29712	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
53d33802-006f-4384-8357-ad2b07747a95	24psg031@psgtech.edu	$2b$12$D9u4XDnUloaIkw1AYevF1OjGmIG5O0MchxunogOAmVzKJVO5oE5lC	STUDENT	9000000031	t	2026-06-13 07:16:50.580606	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
dc8a5ae0-407a-4657-9311-48d6a9c32cda	24psg032@psgtech.edu	$2b$12$VA0lg6azw1ZFs1elBgY2WOvzgxir/K6bNPHrAgYFDkqj.6MU4se36	STUDENT	9000000032	t	2026-06-13 07:16:50.945362	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
5bf7b8ae-f292-4ce4-b842-be366a30e10b	24psg033@psgtech.edu	$2b$12$UTYucYghRN08icTuO66cSOMJT9/QvBURpV5n5k3XVjKF3VOXlEfgK	STUDENT	9000000033	t	2026-06-13 07:16:51.276437	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
4861a414-f3a9-4d12-bca7-24b120580853	24psg034@psgtech.edu	$2b$12$ePnFvy2iGmZIlacpFOvHcu3SFMnAB7FmTz7UmAwyfGmm9g/BDRVge	STUDENT	9000000034	t	2026-06-13 07:16:51.570702	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
d38817b4-473d-48e6-84e4-14011255aa51	24psg035@psgtech.edu	$2b$12$zaoLVs0S/GEhcZeR0zDzheH6qdELhX5YyDJ5s6UCrEUNmtDB8OKPK	STUDENT	9000000035	t	2026-06-13 07:16:51.873758	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
64bd08da-6d70-43b8-b327-1b929f1c040b	24psg036@psgtech.edu	$2b$12$CMUkDDMV8nsoGUPBU1tX7.A/46Gk0gZj8m5LE25o9h3T.OnzaHpP6	STUDENT	9000000036	t	2026-06-13 07:16:52.156714	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
84e6e999-062b-44f5-bab6-8cf501435c95	24psg037@psgtech.edu	$2b$12$FM6J.GFrl3OJf935PalKBupdDQub0KBPljMzDr6rT1vUHvnaDCRoS	STUDENT	9000000037	t	2026-06-13 07:16:52.4323	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
d8f91407-2f00-48d0-8688-2a696c43dc09	24psg038@psgtech.edu	$2b$12$MBze97OKB3sI.ETHDlVDPuILKxyVD2uDRfJgqCbBJCj.I1oxjyDQW	STUDENT	9000000038	t	2026-06-13 07:16:52.738141	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
42e51291-cfc2-476c-beaf-aaabcf36d1d2	24psg039@psgtech.edu	$2b$12$V8ZjkjzZntrtbwQBIE3NIOhRsPmY.eq1TwYbX9eCLrJpEjbOpIHNe	STUDENT	9000000039	t	2026-06-13 07:16:53.042675	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
6a141bae-2bb3-4c93-8286-f6b0edf5a67a	24psg040@psgtech.edu	$2b$12$nWAJcz/ZmoyXnFCDN.groOfrJD2ZTnZxE6cqbVrehZh8aTmQba.j2	STUDENT	9000000040	t	2026-06-13 07:16:53.346463	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
88ffe32c-c6d1-4614-9156-ad0b59707e68	24psg041@psgtech.edu	$2b$12$ZNJ3ycpsZFwcjH.i0XaeZum4VtiY9tqZccnmldtwb3SFJAKBJ2BX6	STUDENT	9000000041	t	2026-06-13 07:16:53.646285	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
0e049a51-c589-442f-9613-46412f616824	24psg042@psgtech.edu	$2b$12$m.XGz7AL1MAjdtbcgx7zJuf.2nEY1zjvzLEFTr7D1KrpbifMEgvFK	STUDENT	9000000042	t	2026-06-13 07:16:53.975763	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
5fe9e1d9-4c5b-47f7-ae09-1f8aa81973b1	24psg043@psgtech.edu	$2b$12$86PAeLfnkoU.GMc26IffquOJleM1v3fvtVEUUOT7ZlQm56iaZc6Sy	STUDENT	9000000043	t	2026-06-13 07:16:54.281201	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
5d22bc54-7d3f-4e86-bbf9-bdf7f0bf97bb	24psg044@psgtech.edu	$2b$12$r7vXZmPmFXbqD3H2X0d0lOXmOyS/3mxXvEfBC0vOPJQxYHYCY/Rk6	STUDENT	9000000044	t	2026-06-13 07:16:54.580632	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
2ab66a75-b1b2-4189-a415-67db5f20ba5b	24psg045@psgtech.edu	$2b$12$uE8HUWqHwYkJZvlZ4KKYl.jpxC6eBl/ve84m44KSONT3blDRUeXu6	STUDENT	9000000045	t	2026-06-13 07:16:54.869926	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
b87b1f07-67b7-4462-ae93-0be47fe3ead2	24psg046@psgtech.edu	$2b$12$v96HHOM0zl5cEdc99JnJI.t1TANyrN.c3lBfTV5sMYRyW072a10o.	STUDENT	9000000046	t	2026-06-13 07:16:55.159414	f3b59378-7b08-40bd-a9fe-91a059905162	30a61c7e-3eb1-4efc-8448-cfeb46c4a9c8
e315016a-f6e9-4838-8b29-a441c14fa7eb	24psg047@psgtech.edu	$2b$12$JSSchyV56aAfUu5BczjQ0.Ben4NF4CDJjXDGDJjsQpk70aU.JSWuu	STUDENT	9000000047	t	2026-06-13 07:16:55.453755	f3b59378-7b08-40bd-a9fe-91a059905162	465f3c25-3d78-470c-8a36-522aa9ec11cf
32699670-1f97-4955-b471-b303934ef223	24psg048@psgtech.edu	$2b$12$n59Vma93VMFX6asQ/3JtdesWYkS5BrLNBfepjMga8x75M/bmBE3xS	STUDENT	9000000048	t	2026-06-13 07:16:55.734239	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
e18c2438-d8a3-44c2-b035-aa2cca1f75d7	24psg049@psgtech.edu	$2b$12$a1Qs3eEW77NbZ5hZsGT1muKvNxxqTmycSAyiN4QAkXbonay4gDqfq	STUDENT	9000000049	t	2026-06-13 07:16:56.013973	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
08c5f162-d73b-49f7-b265-680735cb98b5	24psg050@psgtech.edu	$2b$12$/r7PP6AdBUJ/ylHoILuVOunFlRQJCRj/0uz/pEXb/n4GGlx.QQFmS	STUDENT	9000000050	t	2026-06-13 07:16:56.284853	f3b59378-7b08-40bd-a9fe-91a059905162	7a673248-c5c5-4e2c-b415-87a23736d1c7
1955615f-2c5c-426c-aef3-c96653d0c8ec	admin@ssn.edu.in	$2b$12$Y7u.r8uS2rVMAWq7XT8KfuW94wrLhiONgym6lXk.9cOKMXvur3vAS	ADMIN	9876543232	t	2026-06-13 07:16:56.59385	eed783f7-1785-48a2-bdb3-93f2fde91448	\N
95cbb2d5-fb1d-4697-8881-264243d44927	faculty1@ssn.edu.in	$2b$12$99MbYZfNuhzdvOdveD5a/eyOh.jqGkVen4HBq/hPNo5Jt31OEhFLu	FACULTY	9988776601	t	2026-06-13 07:16:56.883268	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
a8f899d7-9a3f-4c82-bceb-cefea8da4d23	faculty2@ssn.edu.in	$2b$12$mKwdu40rcCQq3WgnduG0cuM95W6mQ9es2bStJ.2wdawtpDmuwXcuG	FACULTY	9988776602	t	2026-06-13 07:16:57.16803	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
fd9c14e2-6b61-46c9-85a6-c55f533a6cb8	faculty3@ssn.edu.in	$2b$12$z273WOm8pZkKjvfQbeSC1eXxz.CHzvQfU2tfmUM3NLjqqZQ18plZ2	FACULTY	9988776603	t	2026-06-13 07:16:57.463288	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
5209baa7-28bd-4d33-bc02-b3f3dd59f71f	faculty4@ssn.edu.in	$2b$12$/P4GAbZG7HzWRuXoWIIZQ.05YnX32MxYkTCLaEuAwgr/lzsO3wf0a	FACULTY	9988776604	t	2026-06-13 07:16:57.781441	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
0b0cee44-6401-4f79-96d1-1f51e8cc132f	faculty5@ssn.edu.in	$2b$12$24T7ntHsjNaUNAhRghflCe2tBkap6e7TRFAjP5uKFu1tU4cGweSH6	FACULTY	9988776605	t	2026-06-13 07:16:58.239266	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
46c69628-005b-4d3e-933e-6563db97a16e	faculty6@ssn.edu.in	$2b$12$p5pLowtAH1SKonlaKkJlk.P/sFH3Uw1mYsJkempL6v4Ey2Pcl7tYW	FACULTY	9988776606	t	2026-06-13 07:16:58.760712	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
02f9621f-f810-404d-9ecf-3d62549e9be2	faculty7@ssn.edu.in	$2b$12$ETvgkv8PFdtuk5AKp9dzbeY4CH.m8NM25s.NfHFsDbDiMit45gu0e	FACULTY	9988776607	t	2026-06-13 07:16:59.252609	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
b32bc62b-1df3-4c7c-8663-8556df825a93	faculty8@ssn.edu.in	$2b$12$hFthf/wZ8aQbv27w2JWjz.FxgruVy1Ljw8zC8OeeH4xolNJa1m7oi	FACULTY	9988776608	t	2026-06-13 07:16:59.791489	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
28f913a1-1721-4040-b75a-a4454ef3268b	faculty9@ssn.edu.in	$2b$12$Ywu99B93wQSFCxS2jfv8.OTWEaESY27cmaABEYreSm2Kx7UULWp.6	FACULTY	9988776609	t	2026-06-13 07:17:00.171015	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
b63d9346-43e6-47a0-b7e7-dc6e5a062528	faculty10@ssn.edu.in	$2b$12$bER5iH0dRpWY8EPFVWSGH.kfFSDJRKdxfIRrAXXP97tO3Ti5oSHeO	FACULTY	9988776610	t	2026-06-13 07:17:00.440821	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
cdfd03ec-b86f-4fdc-9545-589a1dd38e6a	faculty11@ssn.edu.in	$2b$12$fganMAKykUX6a.vLWT4AWupiz69551MZn198Z2BIIChuDFgTdTwqu	FACULTY	9988776611	t	2026-06-13 07:17:00.779972	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
9c3c6feb-6cd3-4278-9ef8-48cdc6252d6e	faculty12@ssn.edu.in	$2b$12$rwfz0WpzmxHa/Qis9PMGPeWkzTvawsmYG3t7bblNyidhgrYkupoEm	FACULTY	9988776612	t	2026-06-13 07:17:01.078856	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
ee7443d1-2af4-4e8a-a2c4-077770a804fc	faculty13@ssn.edu.in	$2b$12$IeKBa27w91Bb4ysw6CvwR.U7T7tQ4SR4quYUL0obC6x2pTEJZ7i72	FACULTY	9988776613	t	2026-06-13 07:17:01.373308	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
c9b1ad24-0f39-4373-abd1-4accf0285e88	faculty14@ssn.edu.in	$2b$12$z5WAMIYHDUiIss59lOMG1O/hZP53jN/czpg9Vi0QpPuVuPoOR48I.	FACULTY	9988776614	t	2026-06-13 07:17:01.679083	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
30674af4-b99d-4224-95a3-224ef4f3b908	faculty15@ssn.edu.in	$2b$12$TKrcO8.jeSwdPHaOsSViaO4x3wxr0FxT3TsZh135rc2baTyoHcyUG	FACULTY	9988776615	t	2026-06-13 07:17:01.970259	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
ec4c432f-1a2d-471d-8eec-de1109cea984	faculty16@ssn.edu.in	$2b$12$Gsw1j7wMD0vdfqCeD9CC2uWVNOe2VpotXTIQWuGa2lLqdajc6RCsi	FACULTY	9988776616	t	2026-06-13 07:17:02.274191	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
edb8b7cf-06b6-4b46-b294-da57c2a04c47	faculty17@ssn.edu.in	$2b$12$qKfsoOiL.STXHRs2QgYMDOULUq/hQa7Q64CVGR9ZHE18c8S5sEmm6	FACULTY	9988776617	t	2026-06-13 07:17:02.569363	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
a4e5c26f-cec7-40d2-af91-e85f78fe786e	faculty18@ssn.edu.in	$2b$12$.w0eFirizXccZYd/emxXW.DaBU2dcX/9F98/Faa10C/357QnCaef.	FACULTY	9988776618	t	2026-06-13 07:17:02.865907	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
b2e0b191-8940-4c11-8c45-73bc8982b77e	faculty19@ssn.edu.in	$2b$12$a245rfxknkA41S2rV4cwxOjERhCVO15Hl.PPUdOS1lmPv7WfA9Q6W	FACULTY	9988776619	t	2026-06-13 07:17:03.165405	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
7464c4ab-5300-4e1a-8387-99cfb66f8cb6	faculty20@ssn.edu.in	$2b$12$eCOlV6pxdwHz0tvOO3JaIu6PF7pHciUgOvtQeY.KM/zDZSzs2n4F2	FACULTY	9988776620	t	2026-06-13 07:17:03.457633	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
2529945b-60e5-4816-9e66-3a3b2e719289	24ssn001@ssn.edu.in	$2b$12$mQfC2B2wMGfrxfXWldtslOrl6Y3d4AYqNYgVqSXPLEjC4Su7.ft4u	STUDENT	9000000001	t	2026-06-13 07:17:03.746232	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
f41bc048-17d5-4a2f-900e-7112f3dd963f	24ssn002@ssn.edu.in	$2b$12$RBX.y1t4rKdnHW55RWps7O8Jq4WoOMEn2.5yc2m.x/zp2hCm7xvM6	STUDENT	9000000002	t	2026-06-13 07:17:04.019693	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
06553638-d000-4f68-adad-9b4d323cd194	24ssn003@ssn.edu.in	$2b$12$Qze9pfTNWeEeXf20AWxsY./jzy5hsYE4OlyWjpePNUGOOZnreh7ye	STUDENT	9000000003	t	2026-06-13 07:17:04.309291	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
ecc232b4-8e89-48bb-b91b-9238dbf0a814	24ssn004@ssn.edu.in	$2b$12$vu4Q9s0T76dPRlTAw5RwMepcERlbmTj1OxJjqexe0Bj2Qsb7cKr0O	STUDENT	9000000004	t	2026-06-13 07:17:04.595558	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
e6272156-ea99-4531-bce7-b1f278421328	24ssn005@ssn.edu.in	$2b$12$xhmHog3dt8b27JRV5emu5.driBx274txXlPkTrOliQscPCLKDlGde	STUDENT	9000000005	t	2026-06-13 07:17:04.881725	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
35645d6f-bdc1-49f9-b369-4d24d790b045	24ssn006@ssn.edu.in	$2b$12$/2UjsxrnfVQCJwLTgsJQnuBIq2JKzc3dzziiy.f/kaEQ9NERclWde	STUDENT	9000000006	t	2026-06-13 07:17:05.174962	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
149068f7-7e3a-445a-8f41-c493e0021cba	24ssn007@ssn.edu.in	$2b$12$1rwCfXuwV8DG/36J3cMHRuxdQP5vbnzu3grzwy/6392a9kyD6LWBe	STUDENT	9000000007	t	2026-06-13 07:17:05.50404	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
9d6db31c-418e-41b8-81f1-a3867e9e27f1	24ssn008@ssn.edu.in	$2b$12$XsgqAxocIJF/lRSAoVExOO2rn33mCaHIT88EuKmF2erbUprUDa0f6	STUDENT	9000000008	t	2026-06-13 07:17:05.792587	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
7aa4adc5-208e-4bd9-8b32-53260d6b9651	24ssn009@ssn.edu.in	$2b$12$LLeZIjOm8hvyIvUkgOCcNOibFrrMJ7WpcXbhbfX37qSCzSUUW0TdC	STUDENT	9000000009	t	2026-06-13 07:17:06.094519	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
3e739f2a-f218-409e-8f6b-04fb98a3ff6a	24ssn010@ssn.edu.in	$2b$12$F/4MDGyc39EUz5u3JL7A3u3l.bzslmfqAZnL2A7.uQSrlzYkAeJTu	STUDENT	9000000010	t	2026-06-13 07:17:06.445781	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
a0f50e7b-ff31-4aba-8204-ffba7ee537bd	24ssn011@ssn.edu.in	$2b$12$db7pQvT9JdGqK7IQKPd/TuLIBRjY29mnChdm0EA/Mrrt8SecUF5B2	STUDENT	9000000011	t	2026-06-13 07:17:06.745257	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
6a327570-e5f3-4a3b-9519-f93a0bcae508	24ssn012@ssn.edu.in	$2b$12$fYJoMbJUlnFSdPVq8wIuduzgVLZ1TShku6FJmA.Um/v6/SmAjH9N2	STUDENT	9000000012	t	2026-06-13 07:17:07.087399	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
b72f1fca-7143-4e64-8729-9db35c1debc6	24ssn013@ssn.edu.in	$2b$12$f4.R/em48Yic17Og1ujP6eny/DmhCTVH0oTvDFX1pAWt5/.5O7l/6	STUDENT	9000000013	t	2026-06-13 07:17:07.389491	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
2692f4e1-27f2-436a-a13c-e209338eb65e	24ssn014@ssn.edu.in	$2b$12$8rVjG1vT92qdedKgqbJ/tOlK5Mo/gceA5hqTwPTwua./16gR.tsm2	STUDENT	9000000014	t	2026-06-13 07:17:07.686088	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
75c430fa-4a23-4094-97fb-2b02a1f238a8	24ssn015@ssn.edu.in	$2b$12$/iLnSaQZlQJ37Fh.WKp/GOQznfLDD0Ygo.b1zyeozfUVzPVY37RNe	STUDENT	9000000015	t	2026-06-13 07:17:07.986026	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
8ec0b9b8-1964-45d7-b8a5-b38e07d5424a	24ssn016@ssn.edu.in	$2b$12$ckxPosidEuqwJt4007UkteOKF.bdldQ7xmXx2vYkEVBkMmFR/6HL.	STUDENT	9000000016	t	2026-06-13 07:17:08.285587	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
92874652-f3e3-450a-be39-2c92970fcb98	24ssn017@ssn.edu.in	$2b$12$5Z6nnjzSqUWwxG9fu.tSqOqD4fNF5k6HJg3AKrsBYLonbDz.6mhfi	STUDENT	9000000017	t	2026-06-13 07:17:08.598287	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
e310d997-30e7-41ef-98ec-9a5357ae4a11	24ssn018@ssn.edu.in	$2b$12$QlXACeIZjDrGTsorOxOUFOUgWs8gHeg2rcFNkvVYiciUxTm44eo7a	STUDENT	9000000018	t	2026-06-13 07:17:09.149597	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
c84f1041-7061-4538-a548-abb978b06f1a	24ssn019@ssn.edu.in	$2b$12$DDycT88nL.hUUAOp0lOUK.85veIKBa4wlBGt5qRgjc0sUmwqMJagi	STUDENT	9000000019	t	2026-06-13 07:17:09.448255	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
14b0e47f-f090-4bd4-b187-a9c39f061f1f	24ssn020@ssn.edu.in	$2b$12$GJNagqTzDba411qiHfwWReMKhUCYyC69QznUuUPqxoE2eycGSCCHK	STUDENT	9000000020	t	2026-06-13 07:17:09.733494	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
61673962-df2d-413b-81d1-e6a0ef3c05f4	24ssn021@ssn.edu.in	$2b$12$4eJlTfv3auX4cAuJURh3AuMbIQg0dhiHSMqMJ53xTszEVRyrWTc6S	STUDENT	9000000021	t	2026-06-13 07:17:10.022941	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
5987b2b3-99a2-49a4-a599-954784931aaf	24ssn022@ssn.edu.in	$2b$12$QI1DAMgUnT61ThwAN8QHbu.aK8mVM6V/WgXnhIYrmcJKa5n0eyNHe	STUDENT	9000000022	t	2026-06-13 07:17:10.301603	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
5b65ab34-7122-41ed-810c-d6f1b5bda905	24ssn023@ssn.edu.in	$2b$12$ZSH8IEJYMvDQ03jGR7iJPO5zD6pOkKFe4.QrHIw8zbqy4eDbVFf2a	STUDENT	9000000023	t	2026-06-13 07:17:10.578026	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
995fd8ae-7c21-4472-a138-94dff118a625	24ssn024@ssn.edu.in	$2b$12$XSLSOsJtCICIKQmJV2b/rOP2sHWJS/RjR5muU49aJUvKxyAXhkPp.	STUDENT	9000000024	t	2026-06-13 07:17:10.875146	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
fd382a69-dd9a-4ab8-99d8-52981cb3a8be	24ssn025@ssn.edu.in	$2b$12$qQ9/qLk7sol2vM4jRhmFhuq9r2QHEZ.pR0zFIb49oax8Yoj7L5C0u	STUDENT	9000000025	t	2026-06-13 07:17:11.162697	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
663eab20-27e6-45b5-85a3-bca85724ca83	24ssn026@ssn.edu.in	$2b$12$DM/Y1dHtW1SM0QiZ7P1L1uBsVfCMEl8ugOHobF2T55Lm5hbGX6/9a	STUDENT	9000000026	t	2026-06-13 07:17:11.433782	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
f90c652d-2157-4c53-aae4-1faf62ce1d37	24ssn027@ssn.edu.in	$2b$12$IrghKVeVADpNfpBj805qcuY5dFGVfHluf6WAkT5IaY8RGFDj/7.ci	STUDENT	9000000027	t	2026-06-13 07:17:11.70084	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
116dfc18-08a9-4e8b-855e-c9997c9ca214	24ssn028@ssn.edu.in	$2b$12$78Ra1xT.xzfiOe0F4I2nEurgjf3tsSIJoBEUaCi52OApuO6k/EBy2	STUDENT	9000000028	t	2026-06-13 07:17:12.036981	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
8460a887-1405-4bf4-9640-9e97dded7ba6	24ssn029@ssn.edu.in	$2b$12$0ks3PYhbRJDG1vSHRzpLQOK9/1abdWY0QYpc2aU3H6Ep/S3pujwZm	STUDENT	9000000029	t	2026-06-13 07:17:12.35082	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
928c6b8f-748b-4149-ad64-0c0f4d1c77eb	24ssn030@ssn.edu.in	$2b$12$idXJR.y0pBrxU8l9Jvytt.YyH4Bf3P1KMiEGit8AoF6Sx2Q5G.KYC	STUDENT	9000000030	t	2026-06-13 07:17:12.673089	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
c890166c-60e0-4e22-a7e4-48f68e7c0563	24ssn031@ssn.edu.in	$2b$12$2NTMy2fUivXk3H8hJ95ZLuxpcYmrONR1AqMaurKcQ40dtKzwcLyuy	STUDENT	9000000031	t	2026-06-13 07:17:12.980967	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
c2609d0e-8bbb-491c-b020-d5623a3be330	24ssn032@ssn.edu.in	$2b$12$TFVNz88ZyJUbjHdKGqw6P.EN6dHq3AS9IkLqKnelHtkyFOdmeB3D6	STUDENT	9000000032	t	2026-06-13 07:17:13.298073	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
bbac4295-78e0-488b-b2b4-1e32767a70d8	24ssn033@ssn.edu.in	$2b$12$kAqggV2XbqrJ3QMCBtgosuDycD2XFhAGIhGFT80/cv3pJz.UksUsS	STUDENT	9000000033	t	2026-06-13 07:17:13.605702	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
a929661f-f7ed-4680-b42c-6059c56131a2	24ssn034@ssn.edu.in	$2b$12$/HDnQGm1p4nEfthcZ/EHc.JrtspMmMv9Pwmfy2mvFuBaIRr2weyhS	STUDENT	9000000034	t	2026-06-13 07:17:13.915553	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
d24a6124-e918-437d-9533-140eae12d152	24ssn035@ssn.edu.in	$2b$12$QliFUS8Sbl3LG64/qLfzr.nV/0m9hZufFoHxWjTOwEivjUnqTFJfO	STUDENT	9000000035	t	2026-06-13 07:17:14.217878	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
f0757d96-8896-484d-a7dd-0f9560265f5b	24ssn036@ssn.edu.in	$2b$12$TO2c3tKTe5MXwDKPdF56YuEuc7QZDJSMMqVoJPiRMyQLQA7O/zMSa	STUDENT	9000000036	t	2026-06-13 07:17:14.525936	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
f6606c0f-6feb-46ce-bebd-c442cd7b1b5f	24ssn037@ssn.edu.in	$2b$12$zM40N78HyHkxo4WkGfhk1.mjaz3wbqN5IOs9Rw1kaSTNQlL0UZCwC	STUDENT	9000000037	t	2026-06-13 07:17:14.829673	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
37cfc757-62f5-40cf-ac1a-281f1665c676	24ssn038@ssn.edu.in	$2b$12$WMtMQGoguSZGj5fvjpefq.RrqesFnM1QeCqNaIh0d0UckHf8bHcya	STUDENT	9000000038	t	2026-06-13 07:17:15.122355	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
5855785c-0339-45d1-b756-b22b33572c0a	24ssn039@ssn.edu.in	$2b$12$EA4BCq7EPyx4NSy/cemIiO7B9xHLvjrV.jh8JowC3zpPyK7g5YL2W	STUDENT	9000000039	t	2026-06-13 07:17:15.424794	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
601210ab-c0b7-469a-9f59-3af956a80d11	24ssn040@ssn.edu.in	$2b$12$CtPAj5/iWDTtahmxWMscBOIiBYAo7225fcAygL3JxZf7/qwCXpI7a	STUDENT	9000000040	t	2026-06-13 07:17:15.729275	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
f222637d-576b-484f-be3a-fe240becf9f8	24ssn041@ssn.edu.in	$2b$12$8V1Jv6aPEpslkE/ePi8K3OaMgkL/Xa130nZ9m9N9WlbdMNRiIYrFa	STUDENT	9000000041	t	2026-06-13 07:17:16.158438	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
899c9576-50a6-4593-9ade-96ddf984fa6f	24ssn042@ssn.edu.in	$2b$12$6IItvw7NzNBBkz/qu.CiUuiBrutRhHrkMpOialwkVdtCeLh7Uon8C	STUDENT	9000000042	t	2026-06-13 07:17:16.500898	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
2754de4c-8e31-473a-ad21-b9ad5d5bd832	24ssn043@ssn.edu.in	$2b$12$UCbQhNZD9xbNFoow24xgxOUgrZQ0IqDRwGzJgmJEEbPPb2DoMvXJy	STUDENT	9000000043	t	2026-06-13 07:17:16.823491	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
3020a5bd-efef-46d3-87d7-0fa8ba467f25	24ssn044@ssn.edu.in	$2b$12$8XIa/tzYOslYbrjpgcwh7ujFxkQ9fsHl9Vorb8jrDsmaif2LsrAzu	STUDENT	9000000044	t	2026-06-13 07:17:17.157728	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
4eff22cf-d2a4-472d-b010-8baf28bf657d	24ssn045@ssn.edu.in	$2b$12$e0ZzUhQKrlrCWQkXzfgJGet5/Ook8AwvH/WNDl/k6gMd7FSDuzrpy	STUDENT	9000000045	t	2026-06-13 07:17:17.474769	eed783f7-1785-48a2-bdb3-93f2fde91448	a6ed0ecc-9e72-4e0a-8a9f-5065324dd5b8
f8b67a9e-2cbf-453b-8868-19e379eed4ec	24ssn046@ssn.edu.in	$2b$12$cmK7H6X6v.ONaqM5RurOZOLYpFf6BqXHgLtK7nMSe4T.aiG56BHRG	STUDENT	9000000046	t	2026-06-13 07:17:17.95043	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
1e0f154d-1fc7-425b-bb46-b1fb91fc69c5	24ssn047@ssn.edu.in	$2b$12$U0czH3gjPwK2mlfS1KX.BeT/h1PuEVtNR54ikBMG8GP8dqoKkhul.	STUDENT	9000000047	t	2026-06-13 07:17:18.655984	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
99410e75-3803-48c9-9728-de536adc804b	24ssn048@ssn.edu.in	$2b$12$pPn5D3gj34T9Ef/zwK2v7OdD1YF7skI.1qNNC2JGV7h1AvOCBH/de	STUDENT	9000000048	t	2026-06-13 07:17:18.970778	eed783f7-1785-48a2-bdb3-93f2fde91448	2fbaa1b6-6b07-43a4-8ee0-7bb4a332f524
22a78617-9376-4cb8-a4bb-d102ddacd98a	24ssn049@ssn.edu.in	$2b$12$mX6ZHahnIhkeWq.FE4J7JefJbNNjX3VrizXLuJGSvAV1z5/edmGsm	STUDENT	9000000049	t	2026-06-13 07:17:19.279712	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
d96681c1-44f1-46d4-b69a-539039abf323	24ssn050@ssn.edu.in	$2b$12$9MAWk9i5Oy6tonJ2VelIHewGGDwmJVKU7RWoVdcLxsKHXDgpIBleK	STUDENT	9000000050	t	2026-06-13 07:17:19.78301	eed783f7-1785-48a2-bdb3-93f2fde91448	86d13a7e-9125-4d91-828c-9cca4d31bace
f94c324d-6511-449e-b231-982482cc6e9a	admin@vit.ac.in	$2b$12$qSjhyUYRGvNJk5N8coYV.eYEx8KqTYJZH17Ij5mQf2/Zg7QwYWivW	ADMIN	9876543238	t	2026-06-13 07:17:20.581597	142022a4-9b55-4ddb-b862-01d4abf2d67d	\N
278c10a1-ab7a-421e-9d64-632253d2ca86	faculty1@vit.ac.in	$2b$12$L0TbRAUB7PXRLiVfVJqDzePC.p.gzBf4mgcBUfyjUNWu5dRloJPbq	FACULTY	9988776601	t	2026-06-13 07:17:20.87995	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
00a68344-4ae0-4cfd-ad6b-81811a8b7f18	faculty2@vit.ac.in	$2b$12$Oe9UfVM8Q4Ln1fMV4uVOy.IbSUnvOtyLxiz5lfNEPVdYcZEWN7wQu	FACULTY	9988776602	t	2026-06-13 07:17:21.386695	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
a42e71f9-1e90-4cc2-81c4-1c1184ffccf4	faculty3@vit.ac.in	$2b$12$0kZZDQGx61fIDJSxj/Ld0uYZD8DKxAN6fjx5WETBv8QgqY1OBIIdq	FACULTY	9988776603	t	2026-06-13 07:17:21.68193	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
66ba7e11-14ee-43d9-acf7-5c640a62be27	faculty4@vit.ac.in	$2b$12$O58WPWktXkEkl8VSMEuT6uLsMVnJWUgeBQUnqakfcCH7wRjHLy0OK	FACULTY	9988776604	t	2026-06-13 07:17:21.981765	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
5ccc0f45-a8dc-4aa4-bad5-95810b921e03	faculty5@vit.ac.in	$2b$12$.H4Cbw1RB7RHeuKg.1khBO0x7LVG82JjFXVPWQA4mQeUQxZDTOyUO	FACULTY	9988776605	t	2026-06-13 07:17:22.310364	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
8c74d6c7-2a8f-4723-8134-d269b411b286	faculty6@vit.ac.in	$2b$12$a8YCPbiEUVBGFlAgl02L7eZwqkpR8qIp5kF4NPoPCoH00W3qMkcbW	FACULTY	9988776606	t	2026-06-13 07:17:22.640125	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
8d1cdcf9-c0b5-47c9-8c37-98b45373d025	faculty7@vit.ac.in	$2b$12$GBNg4bzTInLRa7ldFrocI.POqdqaQY/kK5sziU1/G1WaJrMbmT39u	FACULTY	9988776607	t	2026-06-13 07:17:22.979859	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
3c8de4ab-6b56-4431-8a42-a8c9127a7400	faculty8@vit.ac.in	$2b$12$2V3B5di5MY38CXQJSgA.gONIKggfpv.XKsy7efUndBnwaJhefC5r6	FACULTY	9988776608	t	2026-06-13 07:17:23.328281	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
a1b0b349-e690-4a53-87d5-9da8b9241569	faculty9@vit.ac.in	$2b$12$a1vmKlH99uMUXm0wzeeChOTl.sP/5ajDye7/ADmGvh6TS.9SVZszK	FACULTY	9988776609	t	2026-06-13 07:17:23.647161	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
571ecbe1-44a2-482f-b01b-94135f6217e4	faculty10@vit.ac.in	$2b$12$9vEs0dIiFnuEIiJ7LUxjkOyQajca4uuB0FR7mN6Q..B.YDv6B6LIW	FACULTY	9988776610	t	2026-06-13 07:17:23.961091	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
6eb8e6b8-da8d-4e40-88b0-00a2c6d2cccc	faculty11@vit.ac.in	$2b$12$PwoW0fG3zfH1BoAJLgXa9.1zEbV4R3HfuOPc3acNt4mnk.HBOwR2a	FACULTY	9988776611	t	2026-06-13 07:17:24.28345	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
97c3a8e7-839f-4a76-990b-5672f43d9f3c	faculty12@vit.ac.in	$2b$12$kEJnLqJzgyXYTZ4xkB9JO.qE9ATLQRyT2yaidGEbAuvlLWs67IX52	FACULTY	9988776612	t	2026-06-13 07:17:24.562904	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
10a27953-6269-478e-9053-97cf076ca514	faculty13@vit.ac.in	$2b$12$THMmbdFm3C6FRnJd1hWLxecEWoPqKlD515rkDmC5/UCLu9jHS4Lj.	FACULTY	9988776613	t	2026-06-13 07:17:24.877849	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
51a535de-f0bf-413a-bbf0-8962625b610b	faculty14@vit.ac.in	$2b$12$rAD.bE9X/dT5nPauDEhAGutppns5//iJeeUU481koaQKkxdArYKVm	FACULTY	9988776614	t	2026-06-13 07:17:25.194666	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
ba86f77a-4fed-41a1-b209-32969425869c	faculty15@vit.ac.in	$2b$12$uDCefmr1J3RinVQq0ZJnrONUu5tQY8nsI/.gEQ5Rz9z3BEZOkba2O	FACULTY	9988776615	t	2026-06-13 07:17:25.494922	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
7c1e139a-c932-481f-be55-cab2c6f9f3aa	faculty16@vit.ac.in	$2b$12$QQFO5kFi9uS2qd76HagodulDzeLpQd516HTmB7foHqEqtNFtldwq2	FACULTY	9988776616	t	2026-06-13 07:17:25.800325	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
850b8578-7348-48d0-adb6-1cd6ea4e0747	faculty17@vit.ac.in	$2b$12$oi8qpomw8Ep2iWxhVLlLLe7RqDnEbkkk1fqq1NW9Y2pfJ2a5Jk3TO	FACULTY	9988776617	t	2026-06-13 07:17:26.085456	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
95e8a58c-c7bb-4670-9c1a-98548c58c79b	faculty18@vit.ac.in	$2b$12$er9s/RqOa9Pmlw30lu58TuKILd7n9gwfrIiyVqcrV5upNVyOgjuay	FACULTY	9988776618	t	2026-06-13 07:17:26.376931	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
ef32be91-a1b1-4db7-8a1e-3786f444d760	faculty19@vit.ac.in	$2b$12$RkJF8FUTmWL0KePuEm0LVOn8z39iZbm1mlCdd177Ar4GepvzgXX/2	FACULTY	9988776619	t	2026-06-13 07:17:26.672306	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
14001f46-164a-43ce-b31c-69edfce2ead3	faculty20@vit.ac.in	$2b$12$hOV2l8P8oZPbpeE.THwtYODk33huAvxYz08XU6nZJCsxIi/moAv42	FACULTY	9988776620	t	2026-06-13 07:17:26.953272	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
39a7fe44-33ea-4d2f-b35d-b7497f67298e	24vit001@vit.ac.in	$2b$12$H6zmCEKjzoK2fGjCynNQSOQKkZcEJeiN6aEFrIZPqnPttz1m4N5Im	STUDENT	9000000001	t	2026-06-13 07:17:27.222447	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
0cdd724e-26ac-4576-a2e7-19ba68c2b4f4	24vit002@vit.ac.in	$2b$12$i.Dr0iqyGhuW7ePuEEIkwehN3Kql62NBelIxVrOGbthO4mP0r9Rb2	STUDENT	9000000002	t	2026-06-13 07:17:27.508123	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
2f4b86fc-c12e-4272-bca2-29b8e2e296f9	24vit003@vit.ac.in	$2b$12$BVM0h7tYQGL24g0nLGTxmuSayPcl1ICRAyC9yHTRw399TBGTloVrO	STUDENT	9000000003	t	2026-06-13 07:17:27.817041	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
2d24a7b4-cd80-4e5d-9c83-c9cce59a696d	24vit004@vit.ac.in	$2b$12$Zrm0y5FjQVHPm7Su7JWi4e/SbbzCDCSKgrJXCc0yOnfAOB3BL9Fra	STUDENT	9000000004	t	2026-06-13 07:17:28.159372	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
e93cc718-f45a-4af4-8147-4c4d9448fcfb	24vit005@vit.ac.in	$2b$12$.6JTaBk.adxFoys8YcAMte.vUUMsKvB4JeI0OzTKfJAlTdGWrs5GK	STUDENT	9000000005	t	2026-06-13 07:17:28.580125	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
7770dfaa-b9dd-4dfc-a7f7-7bc8910e6dcf	24vit006@vit.ac.in	$2b$12$CtEp.DNAgqZxXvPYISmYmeTDxuPswxbm4Ax1feHmtqR69G3lkt3Hq	STUDENT	9000000006	t	2026-06-13 07:17:28.875287	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
d01f4c88-909e-4462-8463-acd67faba4ba	24vit007@vit.ac.in	$2b$12$f2jJqlrmUoYVaEo7kWxz5OveHfSav5CzIHKkc86Q4ug38.ZQq6Bf6	STUDENT	9000000007	t	2026-06-13 07:17:29.178165	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
2da7984e-22b8-44f4-89b1-de02630f631a	24vit008@vit.ac.in	$2b$12$l43oyw5hsIl9ul1rZ3yNKuu2Ip2uDwe7iZHhUfHTa/5rejLz5Hyji	STUDENT	9000000008	t	2026-06-13 07:17:29.476888	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
07c23644-2fa6-4f9f-9216-15f016be0af8	24vit009@vit.ac.in	$2b$12$TulhUw021NaIRx/tRWPFIOOp0CMx8HBTuRnDfglNxub66V7nuBwJW	STUDENT	9000000009	t	2026-06-13 07:17:29.76992	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
dbd29a50-37f5-442c-9e6b-b4096302c8be	24vit010@vit.ac.in	$2b$12$F0/cK11CVsdyCeSuNA3A0ewQi6i528LZGY5GbacoiM5rtGvASLRdu	STUDENT	9000000010	t	2026-06-13 07:17:30.060781	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
c2856db6-3f99-423f-a053-8629eb47ecf3	24vit011@vit.ac.in	$2b$12$WTN12PPEAVpThVuBzQqeJ.v9UvMgvh.270v4.sKnEd0LsF6EeD5Ki	STUDENT	9000000011	t	2026-06-13 07:17:30.362281	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
91e445fe-306f-46bd-8a63-9ea158e0ef9c	24vit012@vit.ac.in	$2b$12$3.jGk2YktR/xnfOgPQhXe.fr5ES4cgffqRBoeoH63.2HPLyReJeZm	STUDENT	9000000012	t	2026-06-13 07:17:30.674336	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
28bb6d85-16e6-4e29-bb87-6f6d2263a576	24vit013@vit.ac.in	$2b$12$zfqpoIRRwcdjIset2PCdhOBeZRrCd5WJZa8GeDBXG5QvtxdvRgWCC	STUDENT	9000000013	t	2026-06-13 07:17:30.968177	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
cb3cd778-a185-4007-94ab-0be1a593dda3	24vit014@vit.ac.in	$2b$12$XYfrMS9qSpYVKxwT6h3STepelZ8Up0H.d5b8RNRoPITSyy3O7qd5O	STUDENT	9000000014	t	2026-06-13 07:17:31.251527	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
6bdbb26e-2adc-49dd-9651-f4cf7ca4495d	24vit015@vit.ac.in	$2b$12$ivVhktEqqsACs.dfo2RWPeoHNL83.rdk8r.Xiwnf66JvMao5/e932	STUDENT	9000000015	t	2026-06-13 07:17:31.539138	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
7cb91386-5134-436b-a99d-427c0defed94	24vit016@vit.ac.in	$2b$12$rTPeu6ewCjB9xXCNMNFQsOEtqBvSgLRjQ/rSiqbg91LEYvll3lTcO	STUDENT	9000000016	t	2026-06-13 07:17:31.833795	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
113afb99-e0de-41d8-a581-851912f74aef	24vit017@vit.ac.in	$2b$12$bw7SikaH69Pul/SlUSbpJOTWfq3otw586TNtVu4QTCXBEU1CQh2cu	STUDENT	9000000017	t	2026-06-13 07:17:32.120931	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
e4d06e66-206b-4312-88c6-39e0607d53e7	24vit018@vit.ac.in	$2b$12$UG0JA4FfIYz6O3mmlsmZReMFdyKZvrozcDwen56vLR3Qt1fofXQBe	STUDENT	9000000018	t	2026-06-13 07:17:32.404672	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
e1fe31b5-418a-408f-8a2b-ab81efac9372	24vit019@vit.ac.in	$2b$12$zdA3UnpKH3WDw0lPjRIu5.1NKc0EITr7oh.rkz1d3sDYNiBFwZLmC	STUDENT	9000000019	t	2026-06-13 07:17:32.695992	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
0e88345c-4614-4391-a4cb-087b5b4a8766	24vit020@vit.ac.in	$2b$12$sCiX7pCeSl5IEQwM/2E8QOo9lksxw6Snw/GUPN2WEXkunbbtAHP.q	STUDENT	9000000020	t	2026-06-13 07:17:32.99363	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
a5486d8d-8105-4d3a-ad6f-9aa50b76b293	24vit021@vit.ac.in	$2b$12$RLWe/0SZcBMX9eYM6jX0r.O7e4b75enVz2GBokFDthI4177LU.IEe	STUDENT	9000000021	t	2026-06-13 07:17:33.29429	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
f99d4f32-4017-4203-99c1-e8d43379ccd2	24vit022@vit.ac.in	$2b$12$XggQ7ov6e4zTenvpuzRbNuO4IG9lJFTn3rbxszUF3RsIdemGxgXRW	STUDENT	9000000022	t	2026-06-13 07:17:33.569409	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
8a2c6956-d29c-48b0-8b64-9360a623e05d	24vit023@vit.ac.in	$2b$12$ftkaZ4wwX4Ghbh0NE9GQa.nY4kavDV8snS4oNbGmvA.CufWFvaxm2	STUDENT	9000000023	t	2026-06-13 07:17:33.866001	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
a6134de7-ad87-4c75-ac98-2cc44fd84442	24vit024@vit.ac.in	$2b$12$fJoei3Kc18DfddFidV1XLeCd7Zl4jvncnNqYgtppyMGlf2c8b0wjq	STUDENT	9000000024	t	2026-06-13 07:17:34.151444	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
7786f3e2-2430-41ce-baaa-ab23089e20b7	24vit025@vit.ac.in	$2b$12$hnoVxFm9mm1/ASvkIITVAeC.uiNAX3zw9cAUwzDIgc6ZWzByfExbq	STUDENT	9000000025	t	2026-06-13 07:17:34.559394	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
4021a80f-0121-4c56-80d2-e679adf83347	24vit026@vit.ac.in	$2b$12$.K9p2LmY72livAulz8Y99u9pHYYmGIRvYykeTFn0ML0IAE95L6ON6	STUDENT	9000000026	t	2026-06-13 07:17:35.07475	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
95d4aad0-4edb-4ff2-b4a3-1bb6ba2c765e	24vit027@vit.ac.in	$2b$12$IyN.XXkeKzDPv8LhN6u7uO0d2CvmG4sojHqMVX7uSrlBTDvebtt/q	STUDENT	9000000027	t	2026-06-13 07:17:35.335818	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
965ee92e-90bc-4429-bf52-723051e39e91	24vit028@vit.ac.in	$2b$12$Hy7T2a4P9i0gL502Ae76fehx9fqJKQ4CmNL.NHDMwYr8YYbaZIIX2	STUDENT	9000000028	t	2026-06-13 07:17:35.613213	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
873bc9db-0852-4f87-a6d6-17fc261cba7b	24vit029@vit.ac.in	$2b$12$jdrk.iKLOk6mmhecPms3xuRGM/ocLlhOSZ6hWMUg.1B0oNhhdYXXq	STUDENT	9000000029	t	2026-06-13 07:17:35.909376	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
1b380eb0-9a08-4a9d-95a3-d4201d12016e	24vit030@vit.ac.in	$2b$12$BKY9cKa5ctD1incSO/wPUuLvvnyvSvrQ5eT1pPahjt5ksgBUbks0q	STUDENT	9000000030	t	2026-06-13 07:17:36.190956	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
08a1032a-5bd8-4082-80bf-06949cdaa47b	24vit031@vit.ac.in	$2b$12$JzGh4fNa/z8rkaAQWsRj4OsPn8Aj0Y0znB174MFXCpFZx1psA.qzi	STUDENT	9000000031	t	2026-06-13 07:17:36.471335	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
c2ab3355-c251-4745-ad4e-71783709d874	24vit032@vit.ac.in	$2b$12$E/h5z2JFfsI7E8Tlu5hMyeSozwXQNho28qHiqlL83NcluH.F2pVFC	STUDENT	9000000032	t	2026-06-13 07:17:36.764667	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
3931aa5c-90c5-4a9d-ae31-24e235ce6e33	24vit033@vit.ac.in	$2b$12$yuBmFRS9TY8jVDUlLFe2qeAIY7ZCF9AGXr/zFQ.nMk4ftiTQWhWhq	STUDENT	9000000033	t	2026-06-13 07:17:37.03873	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
348031ee-3a52-41c7-86c5-4bd27ebbc7bf	24vit034@vit.ac.in	$2b$12$LrYtiS1vzK9RWqj.4rLsdekeRBAmX1oFxN6FxmyCR4b9Ul6bHzXOW	STUDENT	9000000034	t	2026-06-13 07:17:37.314501	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
68093b8b-e3e7-49f0-b84a-705514e27a7c	24vit035@vit.ac.in	$2b$12$/la.Ss7wPZAgQ5/wCwmLKO0Ryl1v7wyChnvikM.ULrCavL2Sb5GDa	STUDENT	9000000035	t	2026-06-13 07:17:37.599064	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
33aab51c-6650-4241-8327-c71a78994769	24vit036@vit.ac.in	$2b$12$T56snS4tqO4upTiNk/2VMOnQ/p/Z7blIL8/Ln6wYwYfeocCDXW7r2	STUDENT	9000000036	t	2026-06-13 07:17:37.902686	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
05af0740-f3d0-4284-9880-a175f0bce1d8	24vit037@vit.ac.in	$2b$12$0QOkC9O9LbXQQVddG.dkZe8vybfSchRQ5U/iMT3VxhXycYyByljni	STUDENT	9000000037	t	2026-06-13 07:17:38.215033	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
3e27c29b-9130-4710-baf5-1a98c9ae775b	24vit038@vit.ac.in	$2b$12$lbzkUmsPbSBBhlU4V1RvG.FbRhR9rAKRi.NEIb/YCwzyr54HTN6fy	STUDENT	9000000038	t	2026-06-13 07:17:38.477635	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
787af013-9ea0-4572-8e12-5ff74f339487	24vit039@vit.ac.in	$2b$12$3JtmPJYwXoGGOHxKpg1Usekg7hZC5JWrOsmUQiug4cwqWYGxcK5Si	STUDENT	9000000039	t	2026-06-13 07:17:38.747525	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
b3db9bb5-5594-43d5-a175-4e79be62860f	24vit040@vit.ac.in	$2b$12$tpm6/JrM1lDxgGuHhgDzmu6zCJlLQQRTrcBQPxCNuaP95dwhyVH8C	STUDENT	9000000040	t	2026-06-13 07:17:39.029245	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
b3497f27-efe8-4b99-a05d-4f8fa8b5d2a9	24vit041@vit.ac.in	$2b$12$fHRccV3Ipb7B2e/RiIspYOQJ2/f6jmRXaoHlz5jLDrJ4dL7AA2qbO	STUDENT	9000000041	t	2026-06-13 07:17:39.301451	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
53965429-d334-43fa-afa5-71704950db47	24vit042@vit.ac.in	$2b$12$1wMk1geirHWCBDd9KZZZIO1egRsmDmpD/Jl6P7ZPtxGYokUkL2N6y	STUDENT	9000000042	t	2026-06-13 07:17:39.568873	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
bdfcc577-9d60-4e75-8312-de417981bf3f	24vit043@vit.ac.in	$2b$12$04HaQ24eBugB/lGJlxIlOubSfRN3WIHqWZb2MbaKFv1CSjbt3IOSq	STUDENT	9000000043	t	2026-06-13 07:17:39.868486	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
b61cd563-dd64-4185-bf3b-8d20d78eefe7	24vit044@vit.ac.in	$2b$12$gZQCp1e4OO9PLpD7eXFC5.sE5xKKtfqhdA9DND9Hu0v4a.TtjIeue	STUDENT	9000000044	t	2026-06-13 07:17:40.141451	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
07d0719b-156c-4818-8dee-517c14ae04ca	24vit045@vit.ac.in	$2b$12$MldEzDUJds/zBxipFw24V.U4nj.lL73uwJEOspkX78dVnw/ngb1kS	STUDENT	9000000045	t	2026-06-13 07:17:40.45129	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
dad75074-d244-4bc7-9ab8-11c21b167f08	24vit046@vit.ac.in	$2b$12$oRx8jzxfh4EXsLxU5cA1w./482juKs6uRB3fgOcVmNpg3vi4mUydK	STUDENT	9000000046	t	2026-06-13 07:17:40.735381	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
6122e3be-ab95-41a7-aa1a-65fdf5b99b1e	24vit047@vit.ac.in	$2b$12$qoPaWX3PqGdvUaIeGwpfiO7VT7cdRsAXRvVCINb3A.eOA0qtk04vO	STUDENT	9000000047	t	2026-06-13 07:17:41.087282	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
40862d86-31ce-4b29-8853-f84f2db9b825	24vit048@vit.ac.in	$2b$12$Ov7nWt/b8NuD2rBotZIrL.do96Cz54eWkia8T5LIAW2yMe83rJrBK	STUDENT	9000000048	t	2026-06-13 07:17:41.379556	142022a4-9b55-4ddb-b862-01d4abf2d67d	c7ae4601-26af-4a7b-b93a-74a6c994dc09
5c1f3fd3-ef7d-4237-8493-55a68637c0bd	24vit049@vit.ac.in	$2b$12$yPpGJOp/hFmeW5OW05pILuqgbSjZDAC9AydWnhNHkBb/SuT9UODHu	STUDENT	9000000049	t	2026-06-13 07:17:41.720086	142022a4-9b55-4ddb-b862-01d4abf2d67d	70cc658f-2433-455a-a096-c6a6e8549fb2
567d2fe8-84c4-48c2-85e2-00d2abda15c4	24vit050@vit.ac.in	$2b$12$nMY2esZtxl/kXVs8pz2bdeXATOPR3AdVykkFAGQRJ/lekvI1Ykl3S	STUDENT	9000000050	t	2026-06-13 07:17:42.007131	142022a4-9b55-4ddb-b862-01d4abf2d67d	ea6eef8e-8870-41e6-af5c-9d0dd4eea549
f49dfc85-bf6b-44c7-84ed-b28c49d2f8dc	admin@annauniv.edu	$2b$12$cOKZcdpI5TRdDdxj1RvHTuOXwCyzlPbTXkz4ZAjgfMugliouphhH2	ADMIN	9876543229	t	2026-06-13 07:17:42.293028	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	\N
35e82c69-35c2-42df-a58f-4ed2c0beeb4c	faculty1@annauniv.edu	$2b$12$ali8n826ox2HziT4DqlmmuH.Ft4z/j/.bt1QAjmuNWNvgPtkt9S7W	FACULTY	9988776601	t	2026-06-13 07:17:42.603668	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
b5086141-15d2-4c9a-ad36-1f6d72c644d1	faculty2@annauniv.edu	$2b$12$ThIh22WMoS78fGGsQvyNiegDxie1TfxQH90/DyEtceZtq.2.2HLpi	FACULTY	9988776602	t	2026-06-13 07:17:42.881439	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
113ab573-7e12-4f5d-92e1-4e1fba18d20b	faculty3@annauniv.edu	$2b$12$8VDRu.1O8HGhUkJZKdOxhOmKOvLNuPB8Lr2vu1yFrH2NjSRjrm5sy	FACULTY	9988776603	t	2026-06-13 07:17:43.172837	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
680bc756-a4a7-457d-95d1-f151b6995665	faculty4@annauniv.edu	$2b$12$49NgzKTpBToroUkVsJs.I.NFX0zLpjrmZALbAV3bbWSBgFypfv.CK	FACULTY	9988776604	t	2026-06-13 07:17:43.441293	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
82cc0f31-e120-4f70-9293-5e391b6fdc28	faculty5@annauniv.edu	$2b$12$.8RvxTPUaEDIO20vK6l11ugWl8Ubk3Fz55x2OnzwaUzYzhuAfik4C	FACULTY	9988776605	t	2026-06-13 07:17:43.714477	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
4b2d4b61-9b32-455c-bc24-a136d23c2f56	faculty6@annauniv.edu	$2b$12$EoB4OD0nYNoXgw037XCu0.WnqOkZPxtIQg62HjIFKXW398l/g/zKu	FACULTY	9988776606	t	2026-06-13 07:17:43.989165	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
daaf53c1-1782-49db-a583-e8f7342a2fcb	faculty7@annauniv.edu	$2b$12$ftzsiDr6jlJ3HLNVT9YTS.CNrU2mY2X/gufawYrPIyxccVus8nxHu	FACULTY	9988776607	t	2026-06-13 07:17:44.261621	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
5c3785e8-f022-454b-8d2e-5eaba53c847b	faculty8@annauniv.edu	$2b$12$1IVwWH936EogW33XGSVDw.kReNM9Dheyv0vFeZxxK33gxJhjglzJK	FACULTY	9988776608	t	2026-06-13 07:17:44.534059	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
5625a2f4-8e90-471f-9e6c-834cedf04a99	faculty9@annauniv.edu	$2b$12$369gLi4LhDlBxNG6mXK8le8vrUufVcbsV8m6usTZp5gA68ObvyRZS	FACULTY	9988776609	t	2026-06-13 07:17:44.799222	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
7dbf2d73-6957-46a5-8649-c69fbcc5a838	faculty10@annauniv.edu	$2b$12$2a8KdE9E714y2hKdMSf/DO9duN4XHPwUMOIFKAYJA5SFAOhmz5oK2	FACULTY	9988776610	t	2026-06-13 07:17:45.07242	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
cb7e245f-e0d5-4317-b47b-0ea2e49424c3	faculty11@annauniv.edu	$2b$12$eQsF3/4JHyvkTkB/FcsL1e70myVPu4LuKWZM7Dvo5dC3hyD4.ygR6	FACULTY	9988776611	t	2026-06-13 07:17:45.357839	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
1113251d-ab4b-4441-9510-ed161b4df79e	faculty12@annauniv.edu	$2b$12$4Pe69dKvrVyRxNqAs347ze9C4bm70hctE/M3OJSGGDUj67Aa1mMAu	FACULTY	9988776612	t	2026-06-13 07:17:45.637455	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
b561f271-d763-41ce-aadf-441e3eb47510	faculty13@annauniv.edu	$2b$12$3kSJ6JElhc5mBHHc9T5wwu6cHov/CIqB4mo52TtBxveU.P.hQgW4m	FACULTY	9988776613	t	2026-06-13 07:17:45.910419	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
65efe612-317f-484c-9889-1afd3cf176d9	faculty14@annauniv.edu	$2b$12$HFJbBDrdeKycjRSOhcpuR.mv1v/nNuQY4E1rd2UtwfztUZiytoIV.	FACULTY	9988776614	t	2026-06-13 07:17:46.183136	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
60ed70b3-233f-4f5c-aee2-c04fdefd1bc1	faculty15@annauniv.edu	$2b$12$aTFzI/1w9mTPds60QB/eweh7/WazvSz.Xr/X13bCKjxeRm68.a9i2	FACULTY	9988776615	t	2026-06-13 07:17:46.469078	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
baafec5b-7de3-41bd-b15e-c1b46166f78c	faculty16@annauniv.edu	$2b$12$KRhs2kc4EV/klVzezO6klO5ByoHIe/WYnuGhexE24.ksF7G.N0F.6	FACULTY	9988776616	t	2026-06-13 07:17:46.740605	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
a1785aa0-808d-46fd-85b9-e433f50bea38	faculty17@annauniv.edu	$2b$12$ftQZ/4u9Vw8HjsEjgmtA8uUr3ltDu5OUokCD./ndjS6E4DdZQAzZy	FACULTY	9988776617	t	2026-06-13 07:17:47.006928	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
b6bd6759-bb30-45ef-95d7-4bccb3918ba1	faculty18@annauniv.edu	$2b$12$De8ExHuUaSs3wln56ruhiO5j.SLwA391Y2u9LBc/AbbmQjANhsfA6	FACULTY	9988776618	t	2026-06-13 07:17:47.302002	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
969ea4f6-3ea6-4a2f-94a2-2013269c4f03	faculty19@annauniv.edu	$2b$12$3SpECFrqmzobSJW1Hlw3terzCM9cL3NPRum3Y0eZBqNZchZeCOoRO	FACULTY	9988776619	t	2026-06-13 07:17:47.585305	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
fa306c1d-1af4-4f96-ba59-61ce4f4b5dda	faculty20@annauniv.edu	$2b$12$ly1Skt.hjl05lPPpIl96euoWIJZMy99LRP/qKlZ2OELPZZJjcBbbS	FACULTY	9988776620	t	2026-06-13 07:17:47.852806	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
a0ac4e29-7283-4453-a561-801660c62232	24au001@annauniv.edu	$2b$12$tQzgTB6pi2UVnDGhg3sCy.ivMphbSnqweJeaIF0HmxVaDszYTffsm	STUDENT	9000000001	t	2026-06-13 07:17:48.12577	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
ba1bb061-ad0b-491f-8c0f-ad2a5e42b125	24au002@annauniv.edu	$2b$12$9CCUMb0MOOesOoZahMkZAeXzwKmtoNwWoN/qS5jP/YU1usxS9BHAG	STUDENT	9000000002	t	2026-06-13 07:17:48.415413	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
6e8542af-4521-4103-966a-515bc93b146c	24au003@annauniv.edu	$2b$12$F28.IKcwtVEUpFYMEWvYlOC7STh6vJzyWrZqq8DW10wZ.oqaK5ylK	STUDENT	9000000003	t	2026-06-13 07:17:48.698331	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
b00136e4-3b90-4b33-9413-096707450cb1	24au004@annauniv.edu	$2b$12$C5Xcr3fVNn/8fqG8zK2s6eU6cs2r3QayHovdZaR0bvSKF8u3lMk8q	STUDENT	9000000004	t	2026-06-13 07:17:48.985881	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
ca887d00-ccf2-4a21-8277-2eff295fbad9	24au005@annauniv.edu	$2b$12$lVEkq6Xz4HjzTAykaU1huOxx2CzusjTIk27yaFB56OQaVwZ8oVZiW	STUDENT	9000000005	t	2026-06-13 07:17:49.259119	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
079c6ac3-23ee-4b34-ab46-38f726bd8b5f	24au006@annauniv.edu	$2b$12$Jq9skNR1KCb4kF/ffMhmo.wFRcmjU5DxudqXebuN5xq6xDZdhPujO	STUDENT	9000000006	t	2026-06-13 07:17:49.554871	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
f56aa239-a002-487a-a3c2-896e976f05d5	24au007@annauniv.edu	$2b$12$EZK3sI5TGY3LMKi9Fl1aQu4COWZWGjkx27vXDG5vR2fSEuGRZGd.e	STUDENT	9000000007	t	2026-06-13 07:17:49.848075	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
0d00b7d4-1b71-4306-b066-27d6257ab842	24au008@annauniv.edu	$2b$12$cUkLgCmkhnu6JOL28.0XYuMA.gikL.PZ6IaHTydyxLwl./.PYwlTu	STUDENT	9000000008	t	2026-06-13 07:17:50.112467	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
6951a74b-183f-43f6-af2b-3c370dc6bd6a	24au009@annauniv.edu	$2b$12$mg7HJCJ2A1vjC4JVuG2zyulHcZ.lak7Xj5FHAMCFxLzYZ8akcTzwi	STUDENT	9000000009	t	2026-06-13 07:17:50.390412	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
49258256-ea55-42cf-9ffa-e3dc02f6a66f	24au010@annauniv.edu	$2b$12$TMhsUetO8a09oE7g5Y7cEe/f31NAhjooFVaj7nPFMf2A6l93iu296	STUDENT	9000000010	t	2026-06-13 07:17:50.661942	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
5b5703b9-bec9-4c42-8c93-1ec5fb40aee6	24au011@annauniv.edu	$2b$12$1EG9o4aLyMoV0BWF/YVGSeIPph4kqV/05IRS18QmuDWPKk2js2UPa	STUDENT	9000000011	t	2026-06-13 07:17:50.947039	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
7304b00c-0580-4d0b-a289-35a44fb4e7ee	24au012@annauniv.edu	$2b$12$INRQ.Kf9VPcf7zFrksj9e.Ab4GCinOTvdyLVEqBUFXlC0rdAu8UKu	STUDENT	9000000012	t	2026-06-13 07:17:51.235196	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
149a761b-f289-4684-a181-87389ecdffe5	24au013@annauniv.edu	$2b$12$/2EwfS7Jeach4iKWSGSkQOADPn2WCOqvCnc3bDM476gU5Z08QyaAK	STUDENT	9000000013	t	2026-06-13 07:17:51.497119	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
19c391fe-a0ba-4161-9353-8db872a4c73e	24au014@annauniv.edu	$2b$12$nIIR8HFj4znGajZ/ro9X9O.J2nTwsUw//f/lyKCdX7VhE2yNlS1G6	STUDENT	9000000014	t	2026-06-13 07:17:51.769482	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
83b4c898-a8c4-4eaa-935c-739894c66666	24au015@annauniv.edu	$2b$12$bLDYBzH6rIEf97lZ.8TNzuktje31kRpSC5tbkrd3GGZQ3U0TFVnem	STUDENT	9000000015	t	2026-06-13 07:17:52.040969	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
bff9341d-42a1-4524-9c26-326a8160f013	24au016@annauniv.edu	$2b$12$.1OWUZBtGu3TlKTUuC0HH.B4LQukmuKQEQnm6RpPHyEFo6JAuEFMi	STUDENT	9000000016	t	2026-06-13 07:17:52.35936	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
00671688-79bd-4649-8a79-704c7702ce73	24au017@annauniv.edu	$2b$12$Vu/f4Tk.UJp0XhnMyv1Sku58YQ3CI51isuIaUA4lRckFGubmqoxZW	STUDENT	9000000017	t	2026-06-13 07:17:52.642666	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
11b75cd9-ad5b-4cb1-b50f-6a70ce1d3755	24au018@annauniv.edu	$2b$12$0Zpw2jtPs7xrT5ZCp8AS9.2rb57bE/oF0kZH5GjYNhn.CF4Z/Aj/O	STUDENT	9000000018	t	2026-06-13 07:17:52.92681	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
0fa9c178-02e0-4430-a823-1232e4c78eff	24au019@annauniv.edu	$2b$12$Vbgxf7aalgQwZ5onqaUWZ.m3PIMmwM8ZZl3pNq0VfSH8ykbs2vhTu	STUDENT	9000000019	t	2026-06-13 07:17:53.188704	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
39757592-d46c-4b6c-90d2-0c2949cc8110	24au020@annauniv.edu	$2b$12$whRRwBwrgMabrtPtpXEIqunJLk5hCQMXhbqHhrU8V1Cei7.Prv5wy	STUDENT	9000000020	t	2026-06-13 07:17:53.472448	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
bbba9241-bffc-4bae-ab8e-1b3536655f89	24au021@annauniv.edu	$2b$12$kVR3dl84eFhzFL/.m/JzVeeKf73x3Vx/oWr8Utr7psTkOHYrMqaVS	STUDENT	9000000021	t	2026-06-13 07:17:53.744585	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
d8561a9a-5238-4c04-be36-cbce96b53f88	24au022@annauniv.edu	$2b$12$el.BZnYIK0XKp8u0xSCIreSZIVrmrYOWKaXUruFpsZak2YavdOs6S	STUDENT	9000000022	t	2026-06-13 07:17:54.018741	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
90282e8d-0c29-40d6-bcaa-2e82c202b8d8	24au023@annauniv.edu	$2b$12$yTqEr6ul4nqths3GvdVeI.ljGVkRaxpPC1OZwF1.SNPMXM/7nIimm	STUDENT	9000000023	t	2026-06-13 07:17:54.298401	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
38188ec7-afff-4815-9ce3-c69c36e2e025	24au024@annauniv.edu	$2b$12$vOI243OhRXcq56eBAzBfwO1vWbVdTvLg37SPL8Ow/.b8hTUfvGBSu	STUDENT	9000000024	t	2026-06-13 07:17:54.592998	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
f22048e2-9f50-4146-9809-8d12eb1d253f	24au025@annauniv.edu	$2b$12$F7wv/3hSnpAfWVTY1aoASey6aKgP0NeZsQjVkuGUWJhBCWEKrGH8u	STUDENT	9000000025	t	2026-06-13 07:17:54.893557	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
a156bdfa-759b-4d71-a35e-697158d7130d	24au026@annauniv.edu	$2b$12$K6Togek5bQ0wBrqMcXoimuHE5aaviSwWwJQQKvLhNtjdsf0HAyb2e	STUDENT	9000000026	t	2026-06-13 07:17:55.243444	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
3ae24e76-b88b-459d-966b-31bb3fc4ba7f	24au027@annauniv.edu	$2b$12$YHbiyNkrHJRMxz34X5thPOT12lpX2f/Ye0bWmURItBTFudSGI6/SK	STUDENT	9000000027	t	2026-06-13 07:17:55.771193	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
4c37371b-2462-4f56-b426-d24c1bfe17b0	24au028@annauniv.edu	$2b$12$uFgFp2Zpi70CkO5Pw3h1Hu6nRD/sJ0Ib8cbfsmm5UwTViM0Xn2oRW	STUDENT	9000000028	t	2026-06-13 07:17:56.052268	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
06ae3e3f-dbc2-4c86-9e1d-30e0ac4d6c1c	24au029@annauniv.edu	$2b$12$qIv9Adf.y1BqzE2gxxGQb.w7akWnj6ZBkOo7jG0icviLOlwaVHohu	STUDENT	9000000029	t	2026-06-13 07:17:56.359796	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
efe203b6-4f27-4ce7-941a-470268c6e0d7	24au030@annauniv.edu	$2b$12$DJu9cXaiHsm3yis5XzDl5O2mneCCHUXy5xUNs3B/Z9rLFUUtnHQTi	STUDENT	9000000030	t	2026-06-13 07:17:56.677208	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
3addcfba-ebb1-415c-badf-729742ac501d	24au031@annauniv.edu	$2b$12$hrIydGwTxk0ryxhk65jzzOQh5U/Bn6zqwCcHBbaiYe0VQO.vZsLVa	STUDENT	9000000031	t	2026-06-13 07:17:56.95408	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
ac8d2d6d-432f-4b40-8a28-53484793592f	24au032@annauniv.edu	$2b$12$eUJ0oMEjpACrMzy.ZMpI9ug6Q5/vm/LhC26eZpaGYuq7md.b7lZW2	STUDENT	9000000032	t	2026-06-13 07:17:57.229899	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
10a53da3-1323-4785-bba1-9be7dfe8afd4	24au033@annauniv.edu	$2b$12$US8xXS8ixBPItvA7689kD.mbWfYCNVl2kAdS2VAM.82FrcpCxhPGi	STUDENT	9000000033	t	2026-06-13 07:17:57.502502	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
dde414b7-d96e-41d5-bf23-492d24e42156	24au034@annauniv.edu	$2b$12$6Y7/fhflGe5gzY3HXKw.oONEr/sBXB1A4F6TC8ej41XWH12X0XyLa	STUDENT	9000000034	t	2026-06-13 07:17:57.758512	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
eb4dec80-5e08-4cf0-a513-b24db3e4e244	24au035@annauniv.edu	$2b$12$Jccbd4sV9jZHBf0XqMLIFOKX6JnSMbFBZhYpI17aWb4oZUxSxZIDe	STUDENT	9000000035	t	2026-06-13 07:17:58.037153	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
ccd888a7-fd83-47e0-83db-1def6621d72e	24au036@annauniv.edu	$2b$12$3mlAysMsvoiSLNBTi4mnzOmgkk.USsS17TiqAzJxeCfziCS7HSt.y	STUDENT	9000000036	t	2026-06-13 07:17:58.304041	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
8d34541e-37a2-416a-a35c-ee84ad788971	24au037@annauniv.edu	$2b$12$vsaAwpj1byL2HaHbJ5JxIu31hSLv.41X029l3w.0h/aaYOmuWegHa	STUDENT	9000000037	t	2026-06-13 07:17:58.576221	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
2cfc724e-91db-44b2-b551-adfd0a9914ee	24au038@annauniv.edu	$2b$12$yATQTNAcFr0BIdDVdsczXODWvdoFUn0OJ7ktN/ASXw8QDoFrNgxju	STUDENT	9000000038	t	2026-06-13 07:17:58.887197	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
8f3486b4-e23d-4346-a5fe-663f3c7a07d4	24au039@annauniv.edu	$2b$12$b2Bc/WpDJhVQ3npK3NlGUOHq/vr7z1aLg/n5v1/IACrjJIltUYR/W	STUDENT	9000000039	t	2026-06-13 07:17:59.191645	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
ff54ba39-977d-4fb3-a3c5-bc8c56f28301	24au040@annauniv.edu	$2b$12$W4pfA.WKAyPOcYRBrbIVqOhw8VDsGH.Nfl.2SiLTii7ZVCXjvBuLi	STUDENT	9000000040	t	2026-06-13 07:17:59.479604	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
1ef62c63-82f5-4f8c-957e-e1ce7527af9e	24au041@annauniv.edu	$2b$12$Q/kgvPTPUTKW0ekytLPGmuSwToPrOUICiAOCqnnBLGFk2RKJPFDg6	STUDENT	9000000041	t	2026-06-13 07:17:59.82144	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
289449ea-ab9f-4a78-ba56-039ec7be37dc	24au042@annauniv.edu	$2b$12$xKE70Zv466kFOEOUDLtSa.dihmc9XW5.Q/Z4.d/j/Q9MmeAm5HI5q	STUDENT	9000000042	t	2026-06-13 07:18:00.101395	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
372f8e16-a83d-48a2-9dd1-87ae774d63db	24au043@annauniv.edu	$2b$12$5sRDy4oIFychgaVe0lLOgOBgN/QDdTTWGxXlE7GvMVPDlQJPxs/Ku	STUDENT	9000000043	t	2026-06-13 07:18:00.390643	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
362ed4de-5766-4291-861c-c134ae4120c2	24au044@annauniv.edu	$2b$12$4nj.jxJVAH.WinrMp3fGxu5hj8XJ0n7wNIB2AFuBDLLMG9Bq2Vep.	STUDENT	9000000044	t	2026-06-13 07:18:00.659247	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
cb5e1795-4638-4472-acf3-4fdeeafed4ca	24au045@annauniv.edu	$2b$12$jee965TEpt52lf0aBtsAmuVdzvpKjhOIBzdmljkKsZMXJR/ehlgwu	STUDENT	9000000045	t	2026-06-13 07:18:00.932607	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
c5b94181-d17d-4145-8243-f8b0306043b5	24au046@annauniv.edu	$2b$12$w1zPv1Wpo38Bl0Hs38POput6TsP27rRQ3LEeq8zljJZmNWTC9NFa6	STUDENT	9000000046	t	2026-06-13 07:18:01.20433	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	13d08e92-605e-4739-a74b-9da33dc59ce6
aa259707-d9a6-4efb-8c63-c5dd0dc313f5	24au047@annauniv.edu	$2b$12$6m3aGZv1yM24W.5dhW.T1uC6Mij62ZJGj87inlgjGPgS7KyJbz/C6	STUDENT	9000000047	t	2026-06-13 07:18:01.484192	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	0b2efd4d-fd66-494c-a123-f5758c8ab00c
ae2a0b09-735b-4d98-811d-2c518f546d1f	24au048@annauniv.edu	$2b$12$Hdwsne4KufRzaW.ZKf8Ho.vqqihnOjT7C2IopHReREmW/Omf8g3fG	STUDENT	9000000048	t	2026-06-13 07:18:01.768424	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
0383f8ff-1b35-4a7a-9371-18acedacab41	24au049@annauniv.edu	$2b$12$5Lza1TfqyYWVLeseEkZRwuGMbjAt7DUdjDNkWEgT3e3WbzmeFqlxa	STUDENT	9000000049	t	2026-06-13 07:18:02.058749	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
d21f33bb-8005-40cd-bbf4-866c264464d7	24au050@annauniv.edu	$2b$12$YkpJhx6rp9s8igXATZcaP.EOBXO7Z87YKzs1IQHPB8nnYTuHqk1KW	STUDENT	9000000050	t	2026-06-13 07:18:02.33532	9db6c998-603a-4f6f-a6e7-44e4cf00d8be	941f8b93-1c5f-46f2-a4b0-4df5537f6983
0d8c745a-b01d-42ba-bfd6-1520489d1958	admin@mitindia.edu	$2b$12$20H8hL6nDmd0k6lG9BkE6.5Ii3JNat7DzuEKC7jFE3loZZZG7Wal6	ADMIN	9876543229	t	2026-06-13 07:18:02.617685	7c8c170e-b150-4932-b395-4d0a8916ecc1	\N
189ca404-634a-4337-8ffd-4986d4e4016f	faculty1@mitindia.edu	$2b$12$5WJ6MkQKZjDyBxFLbHQo6OOzkOBvGpBhTVhTJl2wTsVo1OYJVQ8Fy	FACULTY	9988776601	t	2026-06-13 07:18:02.916837	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
65797348-3299-4c52-8b31-d7c1885e5ede	faculty2@mitindia.edu	$2b$12$hZJwixyPSewGgWnv8wkPte7jhX94P0rzuybx7aiojJd8/shOPn/Xm	FACULTY	9988776602	t	2026-06-13 07:18:03.204454	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
9af45fac-8c98-4251-ad11-9da7cd7130ec	faculty3@mitindia.edu	$2b$12$thtX9Hd6Uh1ac02RDJ/2LuwGFLwhgsC/yymBklTrxuGFaT4G7ljni	FACULTY	9988776603	t	2026-06-13 07:18:03.47744	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
609872c4-928a-4211-90dd-7296502d6d64	faculty4@mitindia.edu	$2b$12$V.m2uNX6ncVA1.k5OdJ6OOTfRqcLe4Oru.4ky3BjvPWclvYAoNATq	FACULTY	9988776604	t	2026-06-13 07:18:03.762011	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
54e30e6c-8e71-4bda-9728-4a5719ec3704	faculty5@mitindia.edu	$2b$12$o3YcPLwd7xNf6axTTHSn.uBDGgJGv2vbK8.e3V.zO/H4Gq2Z9TGUm	FACULTY	9988776605	t	2026-06-13 07:18:04.074202	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
ef7c206c-ef82-4442-8d4c-06a47561f7f6	faculty6@mitindia.edu	$2b$12$8aYqC3sT.xHZzuqo5G8lZu/FjT5jZA/n/rfo9A4aPhytYFOeQIvpS	FACULTY	9988776606	t	2026-06-13 07:18:04.371135	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
817fd8bb-3649-4cad-a138-bbc33b9f8168	faculty7@mitindia.edu	$2b$12$sI44/rGWGcuZCDjwbzCYTemGi.USpbC5nzmuRouWeQttVQZ3scJKW	FACULTY	9988776607	t	2026-06-13 07:18:04.644484	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
4a3abbc7-11f2-4f18-ace9-044de8d042a3	faculty8@mitindia.edu	$2b$12$SYzyzbWlc2EwAkLAb19kUu4D6aYFcmPWczeFAoMW4x5JJ/iDZVAJS	FACULTY	9988776608	t	2026-06-13 07:18:04.948724	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
8f5010b1-dc20-4d9a-89f5-682f7823a731	faculty9@mitindia.edu	$2b$12$zr6U4LUszF3/aptolxp73.o6HdlCqR3DkuiM9M.eAnU9Kak75.2Ye	FACULTY	9988776609	t	2026-06-13 07:18:05.241507	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
1cdd0888-1e0b-45c2-90c9-ad8a2baa1829	faculty10@mitindia.edu	$2b$12$c7uw5Eg.1dcJUhG/5q5SV.bYFF9w.11n71aeJtYZFTZmHxK8fDVQa	FACULTY	9988776610	t	2026-06-13 07:18:05.532292	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
d06043c3-5d0b-4b1f-a80f-1a1e410496b8	faculty11@mitindia.edu	$2b$12$Si.8qZFojg/EHdGFxyuDg.2DIywSziT4wHkRPFW3WB8GvtUGc3o1m	FACULTY	9988776611	t	2026-06-13 07:18:05.803581	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
a73b36f0-ae0b-46e0-a291-c5783aaf90af	faculty12@mitindia.edu	$2b$12$RdPcCK5oyt01U65BJPlkBu9BtDJl/TP/KVmYMH8m4lFxlzl6bVmoq	FACULTY	9988776612	t	2026-06-13 07:18:06.076067	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
640ca562-cdac-4881-bc03-de9ab22d9dc1	faculty13@mitindia.edu	$2b$12$PpssIj/YfXjb0r1Z/gumBu5dmWfoK8lc9S/g/g8GrvhB.K1816ulu	FACULTY	9988776613	t	2026-06-13 07:18:06.343705	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
d789c4fe-260e-4abb-9b36-3cf3edc932fc	faculty14@mitindia.edu	$2b$12$amiNBU8VIFRpPk8FRtSALejHKrxKMMMvoeZgBp0YN5ush3EbOySKS	FACULTY	9988776614	t	2026-06-13 07:18:06.605484	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
bb70a838-bdfd-4449-8d93-a01ece7c9813	faculty15@mitindia.edu	$2b$12$tEMBtTdJnPRJVCKtGam2auGF1GBaHWooGAX3f6jrFh7v7Citasg1K	FACULTY	9988776615	t	2026-06-13 07:18:06.875853	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
546c147d-2213-429a-9040-4ff4e81332ff	faculty16@mitindia.edu	$2b$12$uYtzR8v8dWXFveamqieI5.7TOwN7FDJR2E6s4bDJJoAXtw9moWr1y	FACULTY	9988776616	t	2026-06-13 07:18:07.182819	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
cda5b176-3be1-4e28-8224-cd6221a81cab	faculty17@mitindia.edu	$2b$12$d1wTSbA9kWkXj0YAvyGsUO11oP9SmnKQO0MFR4j.YWo7vtVG/Kwpy	FACULTY	9988776617	t	2026-06-13 07:18:07.449716	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
5cc63dd2-de9d-4f75-806b-e64642cf8455	faculty18@mitindia.edu	$2b$12$cLafnT5tCDpGq3noQyuTkOeO0RMYDxjmA1Odm8q9blp9gDKf/Hwpe	FACULTY	9988776618	t	2026-06-13 07:18:07.742272	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
b6957d55-4b7e-4408-8683-e4a5a978168f	faculty19@mitindia.edu	$2b$12$A6lKBAJO2157T4dxoWdJFeKA0QjwWPZS0MgNpZPnvr69QGExpH/lK	FACULTY	9988776619	t	2026-06-13 07:18:08.06199	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
c31ce07e-64a4-4244-84c9-92f288057137	faculty20@mitindia.edu	$2b$12$rNjIRjM5Zgy3JWqTNlQQIui/jVIsO/Pmj6lCukx0ZWW0yIqW60FTW	FACULTY	9988776620	t	2026-06-13 07:18:08.33921	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
29461ff9-4f88-4766-8bfe-04b80c917112	24mit001@mitindia.edu	$2b$12$GCQ./AlJSrwqBU6ABj9N5.fIGD7ujc/E72AzVHbIgwrJFgeQ/XGhi	STUDENT	9000000001	t	2026-06-13 07:18:08.618889	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
5b98c4d5-a7a1-48aa-b115-29df7fc70bf2	24mit002@mitindia.edu	$2b$12$Lvwr04DVp9xUPYdiJzm/kumqcSJIZD2.LMeA9aV.A6lAJC64tdZv6	STUDENT	9000000002	t	2026-06-13 07:18:08.892529	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
31d8fc8c-209b-4a24-a7b5-7068e19f9b38	24mit003@mitindia.edu	$2b$12$JpP9H7BrPgpTvvHk6Ds6S.20rjjFdfQeqZQxTIZ.I9l69U7SUyQOC	STUDENT	9000000003	t	2026-06-13 07:18:09.189472	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
294d3a80-c06d-405b-b2a3-cdfe642ee043	24mit004@mitindia.edu	$2b$12$Iet11dpXHIWomoScHcpgzOzCRwR3M.KQBnWXdaAHrCkgz4cloYwOK	STUDENT	9000000004	t	2026-06-13 07:18:09.452432	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
9623f730-ce29-4f27-8248-fe7040baa8ee	24mit005@mitindia.edu	$2b$12$FmCegtUJ911Q43puFaBK7e2IzIgDmQUd06L0LCMPFc7tx8bDTncMe	STUDENT	9000000005	t	2026-06-13 07:18:09.729018	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
277bcb2a-98fb-4501-90e4-4fdff3e2462a	24mit006@mitindia.edu	$2b$12$2ANbZxF3y8uszSGDpUf7TOYTX4Qfj1yFKPEMhKUBAQBHRphWZrIzG	STUDENT	9000000006	t	2026-06-13 07:18:10.007778	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
525089a5-7a07-462e-be95-4fb1d9a4591d	24mit007@mitindia.edu	$2b$12$FCDJDo50JjWqnzHuAfcjk..0zIiqqpz9Wk7T6TCnm2DmIv75cr5/6	STUDENT	9000000007	t	2026-06-13 07:18:10.278522	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
e4b0e4b9-b72f-4bd1-b904-7d6dd9e17f1f	24mit008@mitindia.edu	$2b$12$pxU53BxmL3b.KKz41nxT8OmGKYMVtsY6UJxHqK3j58faovIC9Disa	STUDENT	9000000008	t	2026-06-13 07:18:10.561221	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
ccfbbc6d-d4ee-471d-9c92-f34b9b4c3c6b	24mit009@mitindia.edu	$2b$12$FKhV5IlFWIYc0272Cw/wlOgyJDSr0caCZTOVyQrf016Zbftcic9ua	STUDENT	9000000009	t	2026-06-13 07:18:10.832668	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
70d2acf9-8844-4a85-aab1-9cbab2ae2a6c	24mit010@mitindia.edu	$2b$12$24Z2tbnkkzxX3l/6xdS0oencRqs068WwQDKkvog6EIWIiwqSxUBea	STUDENT	9000000010	t	2026-06-13 07:18:11.104247	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
b2d9b4fa-e4a2-462e-98e2-9213a2701113	24mit011@mitindia.edu	$2b$12$12fWvt4rWLmhxGdJe5uyL.ODFQYhygHtVA764AJYG6oqyQYe8KSVa	STUDENT	9000000011	t	2026-06-13 07:18:11.40106	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
34ed842a-34bd-4fd5-98d2-ba036f21262c	24mit012@mitindia.edu	$2b$12$pGqxrJoHjDDbHyKyd71Fu.AE7HVsEwath73UaeC2ORZqaa8NBha46	STUDENT	9000000012	t	2026-06-13 07:18:11.729253	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
4cb69805-b2b9-4726-9a07-9abb1ebcc1b9	24mit013@mitindia.edu	$2b$12$6wRm6pNpoQ.22uTeBTvtK.TaVJ1WbIvuv6y36N3nmUAvyB4PRgCMC	STUDENT	9000000013	t	2026-06-13 07:18:12.017103	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
eaa09757-a063-42ea-ba76-fef7ddfc7288	24mit014@mitindia.edu	$2b$12$CsYm15hNNWxFqzXTK341y.uIfd8eNKaf/YPYy4yeRs1p8mY9uoply	STUDENT	9000000014	t	2026-06-13 07:18:12.302751	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
50261cf4-65e2-4540-a7bb-02800f00c91c	24mit015@mitindia.edu	$2b$12$IJaa2TewHC3CjwF5wxQBGuX7mCwfi2aYP2Tsy1xvN1wEhqlJDw.um	STUDENT	9000000015	t	2026-06-13 07:18:12.812934	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
98aca28e-725b-4774-bd4d-076aef645917	24mit016@mitindia.edu	$2b$12$DBgJ7d5TttggP5a4Db8dBe0vHPwxW5zIZhCczuEBOBTqZfMiXrDVy	STUDENT	9000000016	t	2026-06-13 07:18:13.394803	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
4d881d4b-2574-4078-9132-7f226bf19370	24mit017@mitindia.edu	$2b$12$RNg.ax1XApgTpDSPnuBx.uahFeLN47vtYgoUFImAVavnjs71UN71q	STUDENT	9000000017	t	2026-06-13 07:18:13.897688	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
b4cc2036-aeb3-4156-bd2c-5fa078ae2b03	24mit018@mitindia.edu	$2b$12$VEuDRc6pcqduMmtMLBHnReA8NSQGR9vaMnB.rmHj4wfectytFGaXu	STUDENT	9000000018	t	2026-06-13 07:18:14.43201	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
99c68751-cf91-4bdb-b259-e216ec7c8e80	24mit019@mitindia.edu	$2b$12$2q7kc9vhqQ9Ldb01S7Lki.Cn1RVNz5WLLBGjqTFlrqtqO.Ff592x.	STUDENT	9000000019	t	2026-06-13 07:18:14.956314	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
0a640b65-f015-4d9e-88df-d6b7f5c52ae6	24mit020@mitindia.edu	$2b$12$3f9j4aMLNoriO8tnurFWZ.U7HucpDjiZUFD76fZZ9uWD0yeQbajXy	STUDENT	9000000020	t	2026-06-13 07:18:15.585217	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
0412b83f-2370-478d-bd2c-59e131cff05c	24mit021@mitindia.edu	$2b$12$o33upE7qBs773yypIa7An.Y1isUu73kgs6p.tfkCfedFE1YModFtq	STUDENT	9000000021	t	2026-06-13 07:18:16.273307	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
0bcd9909-96a2-45da-8eb2-3659c33a73a7	24mit022@mitindia.edu	$2b$12$pIpVfJpw2Y3CZDYEdJCoqO6U989oRE14jpPl4jVM9GKnGzfIqvXq2	STUDENT	9000000022	t	2026-06-13 07:18:16.946111	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
2a2f57ab-91a2-4170-a52c-6eeff7f7561e	24mit023@mitindia.edu	$2b$12$qOkdlq7zrubvrY6.lWpmeeuLNDZbTPlEu.3cX2OBq/vPTgQ6jNb0O	STUDENT	9000000023	t	2026-06-13 07:18:17.449926	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
b94f432c-1f4c-4c08-84fe-a56646af8d69	24mit024@mitindia.edu	$2b$12$ZtlB7XFqnqUWufBsCZONVe7AHPegt9reZ5PvDoD1fEX4DoT6djZNe	STUDENT	9000000024	t	2026-06-13 07:18:18.092719	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
9558ac05-eb3f-471c-b211-ca9da5e03dd1	24mit025@mitindia.edu	$2b$12$tr5f0t1GdXdvGB6epEHQeOQHBPw7F47PT9E0DmTQDrHQMULX2sD6y	STUDENT	9000000025	t	2026-06-13 07:18:18.71138	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
3a281b6c-4483-48e9-a546-c4d570faeabc	24mit026@mitindia.edu	$2b$12$g69qUSPBAszCCLEd4WVxfO2.bcfWQjoC5tswgma0/h7.VRjJkPCUG	STUDENT	9000000026	t	2026-06-13 07:18:19.342066	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
12e254e4-c3aa-4d16-85bd-cbd5b4a21992	24mit027@mitindia.edu	$2b$12$8PIT6pAtqetWHQHz94YbAOt9vKgtpme5aGPHhmcJ.ggddZhOlpz.O	STUDENT	9000000027	t	2026-06-13 07:18:19.945142	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
f95c6db3-9c8d-43ac-af37-1e9c74c27785	24mit028@mitindia.edu	$2b$12$YqgYyfVyyT0OYld15XqENeVGsBQ2ifLBtzOi1VFSRsg0C/YlWbHZK	STUDENT	9000000028	t	2026-06-13 07:18:20.478844	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
0396aaf7-b9cf-4022-8874-46c9bc2cf0ae	24mit029@mitindia.edu	$2b$12$yf5s9VvSHhOErFciuRd2m.yFEDpYEUQB6nTOJuZK3pFyNFttA00sa	STUDENT	9000000029	t	2026-06-13 07:18:21.022561	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
d4556ca0-2b73-4255-b441-71a44a571a37	24mit030@mitindia.edu	$2b$12$roXawUEIiQYicF73JWE47eXo.YCsOIgXAoBXioGdqQHDX4pNH6NSy	STUDENT	9000000030	t	2026-06-13 07:18:21.549851	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
dc835e73-95ae-402a-a986-dafb928cfdba	24mit031@mitindia.edu	$2b$12$Das9Ra0hZ.FoiAgRUkJd4.kqWih62n6Cxr0Dz4WSIoRUoQe7MYzeC	STUDENT	9000000031	t	2026-06-13 07:18:22.077468	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
76d40782-d4a2-426d-ba9c-fb5360eb7d35	24mit032@mitindia.edu	$2b$12$sMc3f.Dm.gvOTElpn9SEnOQdOQAuGk42d1.OibmWeAuqQIPlZPEw6	STUDENT	9000000032	t	2026-06-13 07:18:22.628981	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
1bcf86a8-e289-4b96-b25b-021935837cb0	24mit033@mitindia.edu	$2b$12$G5AB8A41KhzfwLwChbqAt.mlb5j0Vn4b85rEbjHNS6RggykT5ObVK	STUDENT	9000000033	t	2026-06-13 07:18:23.188454	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
1f0424b6-612b-4046-801b-031c0abf6369	24mit034@mitindia.edu	$2b$12$HFEOWJgCLf8hDgnMw9pQP.xnjPkdJXF9XIBKJZMZbGuaco4Rj7IJS	STUDENT	9000000034	t	2026-06-13 07:18:23.820756	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
f17357c7-aba9-4dd0-82f7-5c814f2739f2	24mit035@mitindia.edu	$2b$12$B59Ds7cGbeax0ef0ShNo8eChagd4cl6RWlTgoqGb.WSqYOC9fNOqe	STUDENT	9000000035	t	2026-06-13 07:18:24.508681	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
c544dcf8-b02b-4e04-b940-cc3a0532906d	24mit036@mitindia.edu	$2b$12$eFNLyecsejJG8MFAMUOdEuKPyYImGtg5o13d7omiUj8i2zHJRxAT.	STUDENT	9000000036	t	2026-06-13 07:18:25.113984	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
5519bb06-83b7-4b0e-84e8-02424d0a70a1	24mit037@mitindia.edu	$2b$12$K9f3FeAuIrywz0spkWaOyuryPCESvrgw52rUuiTjPjOZosluRBI.O	STUDENT	9000000037	t	2026-06-13 07:18:25.621027	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
f4a6b343-f9f0-46bd-a2a7-778ec1705333	24mit038@mitindia.edu	$2b$12$NdvZYRim6pse5wl5fx0s6OSZhOow8fv/m1nmcpZ0YI6pWxwFjur0G	STUDENT	9000000038	t	2026-06-13 07:18:26.209295	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
f959907a-3723-4090-9d38-f76d93c7ebf6	24mit039@mitindia.edu	$2b$12$ISlnFGeFA/EiOExTWdyveOrlPoyPjk/2y516EyjruZ3PPFH9yc0PK	STUDENT	9000000039	t	2026-06-13 07:18:26.81606	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
8876b7d6-670a-4428-aed6-899738f98168	24mit040@mitindia.edu	$2b$12$NLeB3peO4zQ3a9sZq/Kq1uBUyxTNi4WGUUcSxqADgl9dBKhkgABm.	STUDENT	9000000040	t	2026-06-13 07:18:27.367868	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
1a152506-72c9-4e55-a515-459be177e4e5	24mit041@mitindia.edu	$2b$12$5V0NXkp1iSXRXNd..c0wJO.xKBL2GFrr4YA87i3SXvUYpJwcsLCUi	STUDENT	9000000041	t	2026-06-13 07:18:27.906602	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
002cff7f-4a54-4c2a-947e-441797943482	24mit042@mitindia.edu	$2b$12$9dz09lMWSW2Tu2tTy2J9ge1e14PKSTej4vqlFa.U/8OzblNcPQcze	STUDENT	9000000042	t	2026-06-13 07:18:28.539246	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
c508c5dd-da36-4fd8-b7b6-5b61e4ca25d5	24mit043@mitindia.edu	$2b$12$QZbpqJKYDtoNhJKqf1C.1O/6rhmNS4zwv.7KkpE5dArm6kiuYvxt6	STUDENT	9000000043	t	2026-06-13 07:18:29.174147	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
a024e21a-e7c4-4d8b-b16f-98ce33da1d55	24mit044@mitindia.edu	$2b$12$Q6pTh9ZFfjuyfyLxYXNlOO4HkOBt0NrDmxSZDU2qNKRmDoZK6ON6i	STUDENT	9000000044	t	2026-06-13 07:18:29.675	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
67d7f19f-f4d0-4606-b59e-f2af1bef701d	24mit045@mitindia.edu	$2b$12$gIuwrF.UMWecRD2W3s8r/.XrqL4hgEuVyK1ynSvRCqdjjM5T5FBjG	STUDENT	9000000045	t	2026-06-13 07:18:30.264929	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
747e468e-c722-447c-a688-82a85c90caf3	24mit046@mitindia.edu	$2b$12$nTFcOFT/YE156QHDq78MBeXUMWGxU0/HoIaUKw3MjbjTXnQX9m1J.	STUDENT	9000000046	t	2026-06-13 07:18:30.835159	7c8c170e-b150-4932-b395-4d0a8916ecc1	7b80779a-7ace-4dd7-a16e-f2e4fc7dc024
70ca6cfc-3a04-47dc-b679-d87282b4f366	24mit047@mitindia.edu	$2b$12$.iqhp3y.l6aPSErsAtfjOu616zH85fiE3DKmkXyTxuhKoDz0fWHMm	STUDENT	9000000047	t	2026-06-13 07:18:31.395936	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
589d39c3-0d34-40a9-830a-16a320119d3b	24mit048@mitindia.edu	$2b$12$bU6Vb216k5/BlMdEIDrxZOYI5FG1INJxb1pLMK72QQDZMs.x9cU7C	STUDENT	9000000048	t	2026-06-13 07:18:31.912103	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
d43cbdee-9fc0-431e-8624-f303df4c6216	24mit049@mitindia.edu	$2b$12$nKkn8a7lguQivO/33KCTl.yo6T1dbI77Wr.XiWyFXROZteyDF2MCy	STUDENT	9000000049	t	2026-06-13 07:18:32.461392	7c8c170e-b150-4932-b395-4d0a8916ecc1	623199a1-43e1-446a-97ba-986da1f89a12
f1117f1b-38cc-4825-91e7-acacfb3cdf57	24mit050@mitindia.edu	$2b$12$XkeTwc20GmutUw1r6aoPf.I5XNZCH12aty6xlRj.7FGl6l54SOPJS	STUDENT	9000000050	t	2026-06-13 07:18:33.017727	7c8c170e-b150-4932-b395-4d0a8916ecc1	6c90a654-3c45-4796-a5d4-c782847f8772
09dd1c85-2878-4c28-a798-9f44ac9ca241	admin@panimalar.edu.in	$2b$12$lNGkQlMf/AxSPz03RLvxg.0hivdlJLbUEHNXUQABpI2M1kYiVMRdK	ADMIN	9961031454	t	2026-06-13 09:25:42.561959	01271020-47de-4363-b636-90de3b81e1b7	\N
17d9698c-d561-4372-adf2-997a2add9eca	24pm001@panimalar.edu.in	$2b$12$w5HKwj7PAQG7gMDLBBsIF.Wbq4/NsQ1aCInZiQF2.mANXvTA..ouK	STUDENT	7550056010	t	2026-06-13 09:28:48.940744	01271020-47de-4363-b636-90de3b81e1b7	7ddef2d1-50b1-4d9d-b1ea-9cd3b474a755
ba31340a-ba7e-4b28-a631-5fdcdf505e52	a0276@student.test.edu	$2b$12$jTh5pzHWnEqP.mIKJ7zlg.9u7yHxvOUr2DvzyCrwuGhehaVn5ICTq	STUDENT	1234567890	t	2026-06-13 10:01:56.277303	fe4b4e54-a0f2-48a5-b892-c6e7493f51b0	1026a0b1-beaf-4513-b31d-945181bcfa07
aeb5781b-429b-4242-9fdb-38dbc6e87f38	b9ea3@student.test.edu	$2b$12$M0FkM.2sg9m9P2fR90A7E.pRf2cPy4dCDQoc0ASj6N0jEPIwTHkha	STUDENT	1234567890	t	2026-06-13 10:01:56.759163	fe4b4e54-a0f2-48a5-b892-c6e7493f51b0	1026a0b1-beaf-4513-b31d-945181bcfa07
065c86a9-2ee4-4f6b-a59c-b9326fc0fafb	pubbd23@student.test.edu	$2b$12$coAnscD6VRca7aj3O/vmbuREDpMx.e/iFgKNjGMZCymMhdIeYUe9W	STUDENT	1234567890	t	2026-06-13 10:01:57.292035	761aee8c-a780-4c2c-9a1b-5f023d462faf	f9b03b4d-5b7f-4726-8c74-290ee896c008
53c77baa-295a-45a6-a90d-a713a43c1e53	a1604@student.test.edu	$2b$12$pTuFOvjbo.fWOfr2U8o1Ce8wYtmKWVEGmmBGhGexrVz.2/dKv1CHO	STUDENT	1234567890	t	2026-06-13 10:03:31.101287	062db039-8d65-46c6-90c9-d8289161cfc8	0ab92ffa-cf85-43c5-9b36-68d2bf5f5d85
9775fbc0-1f3c-4f9d-95e8-0e48d6752086	b9253@student.test.edu	$2b$12$90BWvhvcFqX3fZmdwZYUf.aMDp0zN8usEfKu0V0RN772lR.ymWNxe	STUDENT	1234567890	t	2026-06-13 10:03:31.411816	062db039-8d65-46c6-90c9-d8289161cfc8	0ab92ffa-cf85-43c5-9b36-68d2bf5f5d85
b59a697f-f67e-4307-bd61-ed36917cfd5b	pub7ec4@student.test.edu	$2b$12$bTxVwZStFv1oIodq6HM2xuRlDhqtjogLeu07o/x20h.n0A.hEqr9m	STUDENT	1234567890	t	2026-06-13 10:03:32.428451	24fc2ee9-6703-4951-8ea9-e3b1182ca44c	03df13aa-b840-4fba-8461-7278d7669f21
76dfde8a-075b-44dc-9ee8-dc8f93c6f6f6	af021@student.test.edu	$2b$12$r.D4P.OS5HiA81yVri1vgu8w3sYmZ1OPdD/OGRJLJ153FbitFASEa	STUDENT	1234567890	t	2026-06-13 10:04:23.591971	dfc1c660-a09f-42dd-9b91-4902c94c9d96	6c7860ff-99ac-4d0c-a209-7e45cdd89686
dad137fa-2d9e-48df-8247-a63ef5e20732	bbdf8@student.test.edu	$2b$12$PHmUWT6aH6Wnfk7QxSRzK.89vZhp1KrauthRTF6z/DGynUNSrdufi	STUDENT	1234567890	t	2026-06-13 10:04:23.901886	dfc1c660-a09f-42dd-9b91-4902c94c9d96	6c7860ff-99ac-4d0c-a209-7e45cdd89686
f593445f-21e9-437a-ac0a-f09341d44cef	puba3b4@student.test.edu	$2b$12$0W2Dwwkzb7LGSbOLhQUnUe..vDA/Isv4Qvvpx34X/fSw.uNdDPurS	STUDENT	1234567890	t	2026-06-13 10:04:24.926721	a927a4ff-be99-4f50-b491-91cc7d6e0149	56f6d369-d0b4-416b-b7a9-f0dc751cf3b5
08589901-0057-4b52-a431-b9090807af86	a8047@student.test.edu	$2b$12$eV3xqQFR9okqVOVW48kErukS5WPiaYnsy/71Z4KtUd7TnkMmIId7W	STUDENT	1234567890	t	2026-06-13 10:05:27.548246	191e8c3f-625f-450a-aa78-e4095f350777	67556692-ca7d-463d-9a43-54df33af1d5b
50a7913b-1309-47c2-98e5-58c3d3e6272b	b9210@student.test.edu	$2b$12$mYE/peoAVnr/FZnTUHuMSe2.aV1i3cCMT8Rhs5jI0PQdMYP3FD7ne	STUDENT	1234567890	t	2026-06-13 10:05:27.846442	191e8c3f-625f-450a-aa78-e4095f350777	67556692-ca7d-463d-9a43-54df33af1d5b
102096c5-f659-446d-8022-f4b620a7589c	pubb7fa@student.test.edu	$2b$12$k8oksrWAMVWew0j0brt06O5Fk0BuSG8.xXL556S25pWJhz7/NxNX.	STUDENT	1234567890	t	2026-06-13 10:05:28.845849	ef7447bc-527d-4ed9-9080-50355693aac6	5dfa0623-6eea-473d-a331-e5a97f969fd0
0cae0790-e00a-43f2-94f5-5b55d33f0909	a3bfc@student.test.edu	$2b$12$Vh6pGtdm1Bc0CKOtEWjQiuWjFhQb.TaMF6VT4/eyjFF36tN5vIvXy	STUDENT	1234567890	t	2026-06-13 11:05:24.291078	255a2637-cb94-438c-b8e8-fd60009f8c27	d71823d2-033e-46da-a1c5-12c20bafa4f4
c7af27ae-59b8-4f1d-9217-c29cb8e0b999	bc982@student.test.edu	$2b$12$JVfp0fEaxPRT6qQP0fSLZe1jdwBtDKfYqy.TI1YSTAYjdd9B0qh.m	STUDENT	1234567890	t	2026-06-13 11:05:24.551193	255a2637-cb94-438c-b8e8-fd60009f8c27	d71823d2-033e-46da-a1c5-12c20bafa4f4
bca185f7-55bc-4219-a7bb-1fefe34a9d1c	puba95b@student.test.edu	$2b$12$lZNcw/kzImAri9qClzyy7uBegdSEJpi4oLwtszuf/3jckXw4nmOg6	STUDENT	1234567890	t	2026-06-13 11:05:25.421312	692766ee-e05c-4e85-9e44-eb4bc294de58	de6a08fb-3018-422d-b384-6e7dff4af315
4a0612fd-1aed-4d8d-b84d-ba2c59267cfb	a00b4@student.test.edu	$2b$12$fwVNMUbBVgMyEkIp.tiIuO5sGfOt9vJloR6xgX3CIC1BlxIEK0Jda	STUDENT	1234567890	t	2026-06-13 11:08:19.270553	23b93d67-f127-4090-8fa3-0be5424bde3f	a5d619a0-b481-4e5b-988d-85589dd6168c
2cbc8a21-0d95-4017-8a78-c5b31a6a3c48	b65ec@student.test.edu	$2b$12$ObBEQypXtknC1Qn/f4/waOku.VxU/zoKbedGAOcRhliKK2PTXYAvu	STUDENT	1234567890	t	2026-06-13 11:08:19.537353	23b93d67-f127-4090-8fa3-0be5424bde3f	a5d619a0-b481-4e5b-988d-85589dd6168c
61368e4f-ffe9-46b3-a22e-d2a5ea9adc09	pub6c12@student.test.edu	$2b$12$7UDlAf484ZHfO6xSLTAFNe1/hQ7WUO4ttJdjWwfz/Tft7wKjkWvFG	STUDENT	1234567890	t	2026-06-13 11:08:20.416195	fa0c6b00-2726-4c92-9a5a-4678a2f01360	ba66490c-4ec3-4181-b0ce-6a3342d0366a
9030cfd4-3968-4eb7-b7f1-aed308bd26e4	a7b89@student.test.edu	$2b$12$2gB8rQL6qVDnNrK/KNLNiO05.JGJpYxKg7xSE0PmU1sbRsLzZXrzq	STUDENT	1234567890	t	2026-06-13 11:09:44.593022	fa944855-fb86-4dc0-b620-985d3879b397	4e955f10-3c93-4f07-b325-0cab11aa0493
ebeb3922-01d7-4d16-98be-d824e77ec2d3	ba486@student.test.edu	$2b$12$LJ0V99k7i2po6skY3Z26K.MSYFnVgpY.wgcpU8o7MC2Eedf.7IpOi	STUDENT	1234567890	t	2026-06-13 11:09:44.852241	fa944855-fb86-4dc0-b620-985d3879b397	4e955f10-3c93-4f07-b325-0cab11aa0493
4cce8634-6f55-4de9-857c-0f245c893979	pub3599@student.test.edu	$2b$12$aBWb3LAlG6xigk9SQep32et/1lAxm.EtRP7BypvfALFmhg9FMOQeO	STUDENT	1234567890	t	2026-06-13 11:09:45.681549	e80c3426-bf6e-4d35-b542-057a5431af4e	027632d1-3166-4cd3-8463-7e03ae68e534
0ab7c80e-e828-40bf-8aa8-3f5a6b65ecae	a715f@student.test.edu	$2b$12$NXyINuQv8B9Jodi0j8iGT.Cq7sC.i6QGRulzonxDJ3dCEZEdGV6i6	STUDENT	1234567890	t	2026-06-13 11:14:20.476598	10bf5956-4b74-4f97-922f-eaf3e08ed61c	7a920d00-8293-4558-9c43-04ca5f295124
5bbb177a-f1e6-4b67-93b9-c3ea6484c205	be94d@student.test.edu	$2b$12$ixWkfPuHBpW2jYzaTWeJNuU241IlgeSbsst3FXuT5jFsdxZTJRKQG	STUDENT	1234567890	t	2026-06-13 11:14:20.749616	10bf5956-4b74-4f97-922f-eaf3e08ed61c	7a920d00-8293-4558-9c43-04ca5f295124
7b6469a6-e2b3-4f20-ae06-68bf7e77f28b	pub42f2@student.test.edu	$2b$12$hfWF1MVT22aQMBgGPD.xiOQhqmiuQjjJMRSznF6x.dhZNfL10EI6m	STUDENT	1234567890	t	2026-06-13 11:14:21.611644	7ebb6692-da05-4029-ae4d-96868a97ef3d	16c76429-22e0-412f-9272-3123c66dbe5a
233ee444-cd4d-4542-8aaa-1e5d55605f81	a36fa@student.test.edu	$2b$12$T5kGQVnBV6EaWXPbCt7lpefeUSfL1QLFdsLWv8Z0xry69S23xpCOu	STUDENT	1234567890	t	2026-06-13 11:18:20.546805	b2e4b0c0-9ba7-4ebb-b244-cc46e1aa565d	42ae23c2-47db-4929-ac14-62b026bd019f
7528838a-9b1c-4429-a50f-d67a22d71afc	bf7b8@student.test.edu	$2b$12$N8PL2aNq3DHF4aGGt9ftx.m28IU3HBijSP7axkocPEeKOY5JaCGcC	STUDENT	1234567890	t	2026-06-13 11:18:20.806911	b2e4b0c0-9ba7-4ebb-b244-cc46e1aa565d	42ae23c2-47db-4929-ac14-62b026bd019f
9f926d82-77f8-411e-8619-876308fede35	pub2093@student.test.edu	$2b$12$vcgOBC6/1SMbTtXneQr27e3gLIMb3cHoUTj4RbsLfAz2/23iwVXsG	STUDENT	1234567890	t	2026-06-13 11:18:21.648453	d9972968-7dda-4e07-8653-cf9975ffef3f	8291d7ed-0e7c-4267-9ba8-4189816219fc
46deae43-ad61-4049-9103-aabae3297c73	abf38@student.test.edu	$2b$12$8gRdCmymfsYIsa9dMwlR7.7iZ.ofBaoOKoPfDm6xRBY8y0NUZgf6K	STUDENT	1234567890	t	2026-06-13 11:20:13.87653	6b718a1a-93f2-4cf9-9b72-5aec60b9ca15	bc5b07bf-96b1-4e0e-b711-0a6d1f7d67bc
b37204bb-46ac-4d75-a3cd-b580382a4823	b8ca2@student.test.edu	$2b$12$dE9Rar1Wg.tkK.2mD0W/8uEDDBq3s8KT7jv3usobK5xN0br.6FiGK	STUDENT	1234567890	t	2026-06-13 11:20:14.148858	6b718a1a-93f2-4cf9-9b72-5aec60b9ca15	bc5b07bf-96b1-4e0e-b711-0a6d1f7d67bc
3caa152d-a7ce-4f86-bf13-2037b4e4879e	pubecf0@student.test.edu	$2b$12$pfVxl.Z5lRTsjPvTYWW/OuUlun1Ymr41jJtM2QhUHLbqvHZUwd9JS	STUDENT	1234567890	t	2026-06-13 11:20:15.07422	e39b03c6-619b-43ba-ad77-3bb86545928a	e0a4d971-42a0-4b6d-9511-714649eaca66
14f17dc7-e135-4e2a-8877-58dca2c968f9	ae1f3@student.test.edu	$2b$12$BRngxpqEKhjqX8iLE2Q8peK/NTd48.aEua8EV31UT6MvdLUY2tH0K	STUDENT	1234567890	t	2026-06-13 11:21:54.771363	3a7ce12a-24bb-4f4d-8c44-243c061e111f	40b8b0f0-8f8a-4504-ab85-3e41d974f5ba
94a97cd6-2591-4bec-9a3f-b573a4c72233	b5fa7@student.test.edu	$2b$12$zwhF28eMj7BRaHf2zb/pc.RAkByQN2OcoRunCUvn7vK2w3C7RbGzm	STUDENT	1234567890	t	2026-06-13 11:21:55.058063	3a7ce12a-24bb-4f4d-8c44-243c061e111f	40b8b0f0-8f8a-4504-ab85-3e41d974f5ba
0abbf1d1-be23-4415-a4cf-8822589fea34	pub3740@student.test.edu	$2b$12$.r9sQr/fWyg1dhg6mGYJe.fyMnX7f2hFhev8uiCnI0o1H2RbuHpQO	STUDENT	1234567890	t	2026-06-13 11:21:56.139974	8f785b96-29ff-49a1-bf73-7ea87eaeee34	8f3a7ba3-4394-4778-b390-5b43f1fa44b1
d1e2d40f-c013-49c3-91d2-c544580aaf62	a1dab@student.test.edu	$2b$12$iZHwJ9Sz0Wp5T7pyUanf4e203Jba35EhfVRWNRGePJYkXGkRtsWL2	STUDENT	1234567890	t	2026-06-13 11:25:23.573973	782eb45b-10fc-4920-910d-6c3f3285d540	d829adc5-19d2-4474-b7ff-22884ee8be1a
260c9b8c-84dd-49a2-a5e1-37439cfb6f0d	b726a@student.test.edu	$2b$12$LEs4N5YB6C.Vg4w4G6ozpeWEPDvmGvHl8./h0pO1K4pYjkno6nfvO	STUDENT	1234567890	t	2026-06-13 11:25:23.863889	782eb45b-10fc-4920-910d-6c3f3285d540	d829adc5-19d2-4474-b7ff-22884ee8be1a
473e90ea-4841-452a-a1c5-8d43c44fa6c5	pubce7c@student.test.edu	$2b$12$CqDDB3GMddt4GJaSUIL4ruNHDOS9JB/4NrW5IHokrPz8YyJJXdTFS	STUDENT	1234567890	t	2026-06-13 11:25:24.823882	36451365-c35b-4873-8af4-0d3c41de8bd1	11080b39-be3e-4c21-bb51-bc83e6b53998
f034d950-7d5c-4ef6-b664-375e2066b458	a5382@student.test.edu	$2b$12$odHPH6ALC9XUWj4.tWyoAOss8mQeUIrLiU1ZIR6J0dzasvFVXgCWy	STUDENT	1234567890	t	2026-06-13 11:27:27.771739	f7776757-407e-40c7-9b79-730356fee2bd	258b1705-9460-4337-871e-74d6a825e475
e7d98ad0-2d43-4969-9b7d-a37632f1feaf	b0dcf@student.test.edu	$2b$12$498nwHka/alwkG5JlQlXI.4OggcVmpOUqzRoxjkJMJSNcJqVprEA6	STUDENT	1234567890	t	2026-06-13 11:27:28.049017	f7776757-407e-40c7-9b79-730356fee2bd	258b1705-9460-4337-871e-74d6a825e475
aa0cc309-8a20-4dc3-bd74-515e82353e9a	pub293b@student.test.edu	$2b$12$5aexmxEktzoYxcFAas7kH.Mch4lIt35wf.rILieZHkNrmklYvAtMq	STUDENT	1234567890	t	2026-06-13 11:27:28.933036	2005b30f-c1b4-47d4-b144-7ac707457da0	d37ae460-4f11-4467-a93f-476f3bc5d9dd
\.


--
-- TOC entry 5088 (class 2606 OID 49767)
-- Name: academic_health_index academic_health_index_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_health_index
    ADD CONSTRAINT academic_health_index_pkey PRIMARY KEY (id);


--
-- TOC entry 5114 (class 2606 OID 50018)
-- Name: accreditation_reports accreditation_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accreditation_reports
    ADD CONSTRAINT accreditation_reports_pkey PRIMARY KEY (id);


--
-- TOC entry 5046 (class 2606 OID 49480)
-- Name: achievement_categories achievement_categories_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievement_categories
    ADD CONSTRAINT achievement_categories_name_key UNIQUE (name);


--
-- TOC entry 5048 (class 2606 OID 49478)
-- Name: achievement_categories achievement_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievement_categories
    ADD CONSTRAINT achievement_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 5068 (class 2606 OID 49576)
-- Name: achievements achievements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_pkey PRIMARY KEY (id);


--
-- TOC entry 5132 (class 2606 OID 50142)
-- Name: alumni_records alumni_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumni_records
    ADD CONSTRAINT alumni_records_pkey PRIMARY KEY (id);


--
-- TOC entry 5078 (class 2606 OID 49659)
-- Name: approval_history approval_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.approval_history
    ADD CONSTRAINT approval_history_pkey PRIMARY KEY (id);


--
-- TOC entry 5102 (class 2606 OID 49914)
-- Name: arrear_records arrear_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arrear_records
    ADD CONSTRAINT arrear_records_pkey PRIMARY KEY (id);


--
-- TOC entry 5076 (class 2606 OID 49641)
-- Name: assignments assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_pkey PRIMARY KEY (id);


--
-- TOC entry 5098 (class 2606 OID 49869)
-- Name: attendance_records attendance_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_records
    ADD CONSTRAINT attendance_records_pkey PRIMARY KEY (id);


--
-- TOC entry 5118 (class 2606 OID 50048)
-- Name: career_profiles career_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.career_profiles
    ADD CONSTRAINT career_profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 5124 (class 2606 OID 50094)
-- Name: career_roadmaps career_roadmaps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.career_roadmaps
    ADD CONSTRAINT career_roadmaps_pkey PRIMARY KEY (id);


--
-- TOC entry 5084 (class 2606 OID 49738)
-- Name: cgpa_records cgpa_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cgpa_records
    ADD CONSTRAINT cgpa_records_pkey PRIMARY KEY (id);


--
-- TOC entry 5144 (class 2606 OID 50237)
-- Name: community_posts community_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_posts
    ADD CONSTRAINT community_posts_pkey PRIMARY KEY (id);


--
-- TOC entry 5064 (class 2606 OID 49562)
-- Name: courses courses_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_code_key UNIQUE (code);


--
-- TOC entry 5066 (class 2606 OID 49560)
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- TOC entry 5104 (class 2606 OID 49935)
-- Name: department_health_index department_health_index_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_health_index
    ADD CONSTRAINT department_health_index_pkey PRIMARY KEY (id);


--
-- TOC entry 5072 (class 2606 OID 49610)
-- Name: department_rankings department_rankings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_rankings
    ADD CONSTRAINT department_rankings_pkey PRIMARY KEY (id);


--
-- TOC entry 5041 (class 2606 OID 49456)
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- TOC entry 5074 (class 2606 OID 49622)
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (student_id, course_id);


--
-- TOC entry 5106 (class 2606 OID 49951)
-- Name: faculty_impact_index faculty_impact_index_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_impact_index
    ADD CONSTRAINT faculty_impact_index_pkey PRIMARY KEY (id);


--
-- TOC entry 5058 (class 2606 OID 49521)
-- Name: faculty_profiles faculty_profiles_employee_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_profiles
    ADD CONSTRAINT faculty_profiles_employee_id_key UNIQUE (employee_id);


--
-- TOC entry 5060 (class 2606 OID 49519)
-- Name: faculty_profiles faculty_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_profiles
    ADD CONSTRAINT faculty_profiles_pkey PRIMARY KEY (user_id);


--
-- TOC entry 5094 (class 2606 OID 49827)
-- Name: gpa_records gpa_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gpa_records
    ADD CONSTRAINT gpa_records_pkey PRIMARY KEY (id);


--
-- TOC entry 5036 (class 2606 OID 49445)
-- Name: institutes institutes_domain_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institutes
    ADD CONSTRAINT institutes_domain_key UNIQUE (domain);


--
-- TOC entry 5038 (class 2606 OID 49443)
-- Name: institutes institutes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institutes
    ADD CONSTRAINT institutes_pkey PRIMARY KEY (id);


--
-- TOC entry 5116 (class 2606 OID 50034)
-- Name: institution_intelligence_score institution_intelligence_score_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institution_intelligence_score
    ADD CONSTRAINT institution_intelligence_score_pkey PRIMARY KEY (id);


--
-- TOC entry 5096 (class 2606 OID 49845)
-- Name: internal_marks internal_marks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_marks
    ADD CONSTRAINT internal_marks_pkey PRIMARY KEY (id);


--
-- TOC entry 5110 (class 2606 OID 49984)
-- Name: internship_gap_analysis internship_gap_analysis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internship_gap_analysis
    ADD CONSTRAINT internship_gap_analysis_pkey PRIMARY KEY (id);


--
-- TOC entry 5142 (class 2606 OID 50220)
-- Name: learning_recommendations learning_recommendations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learning_recommendations
    ADD CONSTRAINT learning_recommendations_pkey PRIMARY KEY (id);


--
-- TOC entry 5062 (class 2606 OID 49540)
-- Name: mentor_assignments mentor_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mentor_assignments
    ADD CONSTRAINT mentor_assignments_pkey PRIMARY KEY (id);


--
-- TOC entry 5090 (class 2606 OID 49784)
-- Name: mentor_feedback mentor_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mentor_feedback
    ADD CONSTRAINT mentor_feedback_pkey PRIMARY KEY (id);


--
-- TOC entry 5070 (class 2606 OID 49599)
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- TOC entry 5108 (class 2606 OID 49967)
-- Name: placement_readiness placement_readiness_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.placement_readiness
    ADD CONSTRAINT placement_readiness_pkey PRIMARY KEY (id);


--
-- TOC entry 5126 (class 2606 OID 50109)
-- Name: portfolio_profiles portfolio_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portfolio_profiles
    ADD CONSTRAINT portfolio_profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 5128 (class 2606 OID 50111)
-- Name: portfolio_profiles portfolio_profiles_public_url_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portfolio_profiles
    ADD CONSTRAINT portfolio_profiles_public_url_slug_key UNIQUE (public_url_slug);


--
-- TOC entry 5134 (class 2606 OID 50161)
-- Name: recruiter_profiles recruiter_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruiter_profiles
    ADD CONSTRAINT recruiter_profiles_pkey PRIMARY KEY (user_id);


--
-- TOC entry 5136 (class 2606 OID 50175)
-- Name: recruiter_search_logs recruiter_search_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruiter_search_logs
    ADD CONSTRAINT recruiter_search_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 5130 (class 2606 OID 50125)
-- Name: resume_profiles resume_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resume_profiles
    ADD CONSTRAINT resume_profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 5086 (class 2606 OID 49754)
-- Name: risk_assessments risk_assessments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.risk_assessments
    ADD CONSTRAINT risk_assessments_pkey PRIMARY KEY (id);


--
-- TOC entry 5100 (class 2606 OID 49892)
-- Name: semester_results semester_results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.semester_results
    ADD CONSTRAINT semester_results_pkey PRIMARY KEY (id);


--
-- TOC entry 5082 (class 2606 OID 49724)
-- Name: semesters semesters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.semesters
    ADD CONSTRAINT semesters_pkey PRIMARY KEY (id);


--
-- TOC entry 5122 (class 2606 OID 50078)
-- Name: skill_gap_analysis skill_gap_analysis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_gap_analysis
    ADD CONSTRAINT skill_gap_analysis_pkey PRIMARY KEY (id);


--
-- TOC entry 5120 (class 2606 OID 50063)
-- Name: skill_profiles skill_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_profiles
    ADD CONSTRAINT skill_profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 5140 (class 2606 OID 50204)
-- Name: student_digital_twins student_digital_twins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_digital_twins
    ADD CONSTRAINT student_digital_twins_pkey PRIMARY KEY (id);


--
-- TOC entry 5050 (class 2606 OID 49491)
-- Name: student_profiles student_profiles_enrollment_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_profiles
    ADD CONSTRAINT student_profiles_enrollment_number_key UNIQUE (enrollment_number);


--
-- TOC entry 5052 (class 2606 OID 49489)
-- Name: student_profiles student_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_profiles
    ADD CONSTRAINT student_profiles_pkey PRIMARY KEY (user_id);


--
-- TOC entry 5054 (class 2606 OID 49495)
-- Name: student_profiles student_profiles_public_profile_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_profiles
    ADD CONSTRAINT student_profiles_public_profile_id_key UNIQUE (public_profile_id);


--
-- TOC entry 5056 (class 2606 OID 49493)
-- Name: student_profiles student_profiles_roll_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_profiles
    ADD CONSTRAINT student_profiles_roll_number_key UNIQUE (roll_number);


--
-- TOC entry 5138 (class 2606 OID 50189)
-- Name: student_success_index student_success_index_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_success_index
    ADD CONSTRAINT student_success_index_pkey PRIMARY KEY (id);


--
-- TOC entry 5112 (class 2606 OID 50002)
-- Name: student_success_predictions student_success_predictions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_success_predictions
    ADD CONSTRAINT student_success_predictions_pkey PRIMARY KEY (id);


--
-- TOC entry 5092 (class 2606 OID 49807)
-- Name: subjects subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- TOC entry 5080 (class 2606 OID 49677)
-- Name: submissions submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- TOC entry 5044 (class 2606 OID 49468)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5039 (class 1259 OID 49446)
-- Name: ix_institutes_institute_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_institutes_institute_id ON public.institutes USING btree (institute_id);


--
-- TOC entry 5042 (class 1259 OID 49469)
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);


--
-- TOC entry 5173 (class 2606 OID 49768)
-- Name: academic_health_index academic_health_index_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.academic_health_index
    ADD CONSTRAINT academic_health_index_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5193 (class 2606 OID 50019)
-- Name: accreditation_reports accreditation_reports_institute_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accreditation_reports
    ADD CONSTRAINT accreditation_reports_institute_id_fkey FOREIGN KEY (institute_id) REFERENCES public.institutes(id);


--
-- TOC entry 5157 (class 2606 OID 49587)
-- Name: achievements achievements_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.achievement_categories(id);


--
-- TOC entry 5158 (class 2606 OID 49582)
-- Name: achievements achievements_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- TOC entry 5159 (class 2606 OID 49577)
-- Name: achievements achievements_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achievements
    ADD CONSTRAINT achievements_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5201 (class 2606 OID 50148)
-- Name: alumni_records alumni_records_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumni_records
    ADD CONSTRAINT alumni_records_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- TOC entry 5202 (class 2606 OID 50143)
-- Name: alumni_records alumni_records_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alumni_records
    ADD CONSTRAINT alumni_records_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5166 (class 2606 OID 49660)
-- Name: approval_history approval_history_achievement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.approval_history
    ADD CONSTRAINT approval_history_achievement_id_fkey FOREIGN KEY (achievement_id) REFERENCES public.achievements(id);


--
-- TOC entry 5167 (class 2606 OID 49665)
-- Name: approval_history approval_history_faculty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.approval_history
    ADD CONSTRAINT approval_history_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.users(id);


--
-- TOC entry 5186 (class 2606 OID 49915)
-- Name: arrear_records arrear_records_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arrear_records
    ADD CONSTRAINT arrear_records_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5187 (class 2606 OID 49920)
-- Name: arrear_records arrear_records_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arrear_records
    ADD CONSTRAINT arrear_records_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subjects(id);


--
-- TOC entry 5164 (class 2606 OID 49642)
-- Name: assignments assignments_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- TOC entry 5165 (class 2606 OID 49647)
-- Name: assignments assignments_faculty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.users(id);


--
-- TOC entry 5182 (class 2606 OID 49870)
-- Name: attendance_records attendance_records_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_records
    ADD CONSTRAINT attendance_records_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5183 (class 2606 OID 49875)
-- Name: attendance_records attendance_records_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance_records
    ADD CONSTRAINT attendance_records_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subjects(id);


--
-- TOC entry 5195 (class 2606 OID 50049)
-- Name: career_profiles career_profiles_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.career_profiles
    ADD CONSTRAINT career_profiles_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5198 (class 2606 OID 50095)
-- Name: career_roadmaps career_roadmaps_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.career_roadmaps
    ADD CONSTRAINT career_roadmaps_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5171 (class 2606 OID 49739)
-- Name: cgpa_records cgpa_records_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cgpa_records
    ADD CONSTRAINT cgpa_records_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5208 (class 2606 OID 50238)
-- Name: community_posts community_posts_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_posts
    ADD CONSTRAINT community_posts_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- TOC entry 5209 (class 2606 OID 50243)
-- Name: community_posts community_posts_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_posts
    ADD CONSTRAINT community_posts_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- TOC entry 5156 (class 2606 OID 49563)
-- Name: courses courses_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- TOC entry 5188 (class 2606 OID 49936)
-- Name: department_health_index department_health_index_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_health_index
    ADD CONSTRAINT department_health_index_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- TOC entry 5161 (class 2606 OID 49611)
-- Name: department_rankings department_rankings_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department_rankings
    ADD CONSTRAINT department_rankings_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- TOC entry 5145 (class 2606 OID 49703)
-- Name: departments departments_hod_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_hod_id_fkey FOREIGN KEY (hod_id) REFERENCES public.users(id);


--
-- TOC entry 5146 (class 2606 OID 49698)
-- Name: departments departments_institute_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_institute_id_fkey FOREIGN KEY (institute_id) REFERENCES public.institutes(id);


--
-- TOC entry 5162 (class 2606 OID 49628)
-- Name: enrollments enrollments_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- TOC entry 5163 (class 2606 OID 49623)
-- Name: enrollments enrollments_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5189 (class 2606 OID 49952)
-- Name: faculty_impact_index faculty_impact_index_faculty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_impact_index
    ADD CONSTRAINT faculty_impact_index_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.users(id);


--
-- TOC entry 5152 (class 2606 OID 49527)
-- Name: faculty_profiles faculty_profiles_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_profiles
    ADD CONSTRAINT faculty_profiles_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- TOC entry 5153 (class 2606 OID 49522)
-- Name: faculty_profiles faculty_profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty_profiles
    ADD CONSTRAINT faculty_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 5178 (class 2606 OID 49833)
-- Name: gpa_records gpa_records_semester_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gpa_records
    ADD CONSTRAINT gpa_records_semester_id_fkey FOREIGN KEY (semester_id) REFERENCES public.semesters(id);


--
-- TOC entry 5179 (class 2606 OID 49828)
-- Name: gpa_records gpa_records_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gpa_records
    ADD CONSTRAINT gpa_records_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5194 (class 2606 OID 50035)
-- Name: institution_intelligence_score institution_intelligence_score_institute_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institution_intelligence_score
    ADD CONSTRAINT institution_intelligence_score_institute_id_fkey FOREIGN KEY (institute_id) REFERENCES public.institutes(id);


--
-- TOC entry 5180 (class 2606 OID 49846)
-- Name: internal_marks internal_marks_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_marks
    ADD CONSTRAINT internal_marks_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5181 (class 2606 OID 49851)
-- Name: internal_marks internal_marks_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_marks
    ADD CONSTRAINT internal_marks_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subjects(id);


--
-- TOC entry 5191 (class 2606 OID 49985)
-- Name: internship_gap_analysis internship_gap_analysis_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internship_gap_analysis
    ADD CONSTRAINT internship_gap_analysis_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- TOC entry 5207 (class 2606 OID 50221)
-- Name: learning_recommendations learning_recommendations_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.learning_recommendations
    ADD CONSTRAINT learning_recommendations_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5154 (class 2606 OID 49546)
-- Name: mentor_assignments mentor_assignments_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mentor_assignments
    ADD CONSTRAINT mentor_assignments_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- TOC entry 5155 (class 2606 OID 49541)
-- Name: mentor_assignments mentor_assignments_faculty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mentor_assignments
    ADD CONSTRAINT mentor_assignments_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.users(id);


--
-- TOC entry 5174 (class 2606 OID 49790)
-- Name: mentor_feedback mentor_feedback_mentor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mentor_feedback
    ADD CONSTRAINT mentor_feedback_mentor_id_fkey FOREIGN KEY (mentor_id) REFERENCES public.users(id);


--
-- TOC entry 5175 (class 2606 OID 49785)
-- Name: mentor_feedback mentor_feedback_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mentor_feedback
    ADD CONSTRAINT mentor_feedback_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5160 (class 2606 OID 49600)
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 5190 (class 2606 OID 49968)
-- Name: placement_readiness placement_readiness_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.placement_readiness
    ADD CONSTRAINT placement_readiness_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5199 (class 2606 OID 50112)
-- Name: portfolio_profiles portfolio_profiles_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.portfolio_profiles
    ADD CONSTRAINT portfolio_profiles_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5203 (class 2606 OID 50162)
-- Name: recruiter_profiles recruiter_profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruiter_profiles
    ADD CONSTRAINT recruiter_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 5204 (class 2606 OID 50176)
-- Name: recruiter_search_logs recruiter_search_logs_recruiter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruiter_search_logs
    ADD CONSTRAINT recruiter_search_logs_recruiter_id_fkey FOREIGN KEY (recruiter_id) REFERENCES public.users(id);


--
-- TOC entry 5200 (class 2606 OID 50126)
-- Name: resume_profiles resume_profiles_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resume_profiles
    ADD CONSTRAINT resume_profiles_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5172 (class 2606 OID 49755)
-- Name: risk_assessments risk_assessments_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.risk_assessments
    ADD CONSTRAINT risk_assessments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5184 (class 2606 OID 49893)
-- Name: semester_results semester_results_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.semester_results
    ADD CONSTRAINT semester_results_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5185 (class 2606 OID 49898)
-- Name: semester_results semester_results_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.semester_results
    ADD CONSTRAINT semester_results_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subjects(id);


--
-- TOC entry 5170 (class 2606 OID 49725)
-- Name: semesters semesters_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.semesters
    ADD CONSTRAINT semesters_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- TOC entry 5197 (class 2606 OID 50079)
-- Name: skill_gap_analysis skill_gap_analysis_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_gap_analysis
    ADD CONSTRAINT skill_gap_analysis_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5196 (class 2606 OID 50064)
-- Name: skill_profiles skill_profiles_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skill_profiles
    ADD CONSTRAINT skill_profiles_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5206 (class 2606 OID 50205)
-- Name: student_digital_twins student_digital_twins_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_digital_twins
    ADD CONSTRAINT student_digital_twins_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5149 (class 2606 OID 49501)
-- Name: student_profiles student_profiles_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_profiles
    ADD CONSTRAINT student_profiles_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- TOC entry 5150 (class 2606 OID 49506)
-- Name: student_profiles student_profiles_mentor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_profiles
    ADD CONSTRAINT student_profiles_mentor_id_fkey FOREIGN KEY (mentor_id) REFERENCES public.users(id);


--
-- TOC entry 5151 (class 2606 OID 49496)
-- Name: student_profiles student_profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_profiles
    ADD CONSTRAINT student_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 5205 (class 2606 OID 50190)
-- Name: student_success_index student_success_index_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_success_index
    ADD CONSTRAINT student_success_index_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5192 (class 2606 OID 50003)
-- Name: student_success_predictions student_success_predictions_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_success_predictions
    ADD CONSTRAINT student_success_predictions_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5176 (class 2606 OID 49813)
-- Name: subjects subjects_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- TOC entry 5177 (class 2606 OID 49808)
-- Name: subjects subjects_semester_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_semester_id_fkey FOREIGN KEY (semester_id) REFERENCES public.semesters(id);


--
-- TOC entry 5168 (class 2606 OID 49678)
-- Name: submissions submissions_assignment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_assignment_id_fkey FOREIGN KEY (assignment_id) REFERENCES public.assignments(id);


--
-- TOC entry 5169 (class 2606 OID 49683)
-- Name: submissions submissions_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id);


--
-- TOC entry 5147 (class 2606 OID 49688)
-- Name: users users_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- TOC entry 5148 (class 2606 OID 49693)
-- Name: users users_institute_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_institute_id_fkey FOREIGN KEY (institute_id) REFERENCES public.institutes(id);


--
-- TOC entry 5409 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2026-06-13 19:16:39

--
-- PostgreSQL database dump complete
--

\unrestrict 4HA9Ajre9DdklU0rgYE529jrjI5Vp58Qm0n7esrzWrxl6een1D2vEJtTSJSsbdd

