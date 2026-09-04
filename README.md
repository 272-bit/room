# 회의실 예약 앱 배포 가이드

## 1. Supabase 설정 (5분)
1. https://supabase.com 접속 → 무료 회원가입 → 새 프로젝트 생성
2. 왼쪽 메뉴 SQL Editor → 이 폴더의 `schema.sql` 내용 전체 복사해서 실행
3. 왼쪽 메뉴 Project Settings > API 에서 아래 두 값 복사
   - Project URL
   - anon public key

## 2. 코드에 값 채우기
`index.html` 상단 부근에서:
```js
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```
위 두 줄을 방금 복사한 값으로 교체합니다.

## 3. Vercel 배포 (5분)
1. https://vercel.com 무료 회원가입 (GitHub 계정으로 가능)
2. New Project → "Add New..." 대신 화면 하단의 폴더 드래그 업로드 기능 사용
   (또는 GitHub에 이 폴더를 올리고 Vercel에서 Import — 이후 코드 수정 시 자동 재배포되어 편함)
3. Framework Preset: "Other" 선택 (별도 빌드 설정 필요 없음, 정적 파일이라 그대로 배포됨)
4. 배포되면 나오는 `*.vercel.app` 링크를 6명에게 공유

## 사용 방법
- 링크 클릭 → 최초 1회 본인 이름(KJ/YG/JH/JR/HK/SY) 선택 → 그 기기에 저장됨
- 회의실 컬럼의 빈 공간을 누른 채로 아래로 끌면 원하는 시간대가 선택됨 (30분 단위)
- 손을 떼면 예약자 선택 패널이 뜸 → 이름 선택하면 바로 등록, 다른 사람 화면에도 즉시 반영
- 예약된 막대를 누르면 취소 가능 (본인 것 아니어도 취소 가능하도록 설정되어 있음)
- 상단 "일간 / 주간" 탭으로 전환, 주간 뷰에서는 회의실 탭으로 방을 고른 뒤 한 주 전체 확인
- 좌우 스와이프(모바일) 또는 ‹ › 버튼으로 하루씩 / 한 주씩 이동

## 참고
- 로그인이나 비밀번호가 없는 내부용 가벼운 도구입니다. 링크를 아는 사람만 접근한다는 전제로 설계되어 있어요.
- 겹치는 시간대 예약은 데이터베이스 단에서 자체적으로 차단됩니다(동시에 눌러도 안전).
- 운영시간을 8~20시가 아닌 다른 범위로 바꾸려면 `index.html`의 `START_HOUR`, `END_HOUR` 값만 수정하면 됩니다.
