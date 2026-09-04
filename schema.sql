-- 회의실 예약 스키마
-- Supabase 대시보드 > SQL Editor 에서 전체 붙여넣고 실행하세요.

create extension if not exists btree_gist;

create table if not exists reservations (
  id uuid primary key default gen_random_uuid(),
  room text not null check (room in ('대회의실','접견실','회의실1','회의실2')),
  user_name text not null check (user_name in ('KJ','YG','JH','JR','HK','SY')),
  start_ts timestamptz not null,
  end_ts timestamptz not null,
  created_at timestamptz not null default now(),
  constraint end_after_start check (end_ts > start_ts),
  exclude using gist (room with =, tstzrange(start_ts, end_ts, '[)') with &&)
);

alter table reservations enable row level security;

-- 로그인 없는 내부 도구라 전체 공개 정책으로 둡니다.
-- (링크를 아는 6명만 쓴다는 전제. 더 강한 보안이 필요하면 알려주세요.)
create policy "public read" on reservations for select using (true);
create policy "public insert" on reservations for insert with check (true);
create policy "public delete" on reservations for delete using (true);

-- 실시간 반영 활성화
alter publication supabase_realtime add table reservations;
