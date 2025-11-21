import 'package:iv_project_model/iv_project_model.dart';

class Dummys {
  const Dummys._();

  static final invitationData = InvitationDataResponse(
    id: 1,
    general: const GeneralResponse(
      id: 1,
      lang: LangType.en,
      coverImageUrl: 'assets/dummys/try_theme_cover_image.png',
      opening: 'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ',
      openingQuote:
          '"Dan di antara tanda-tanda (kebesaran)-Nya adalah Dia menciptakan pasangan-pasangan untukmu dari jenismu sendiri, agar kamu cenderung dan merasa tenteram kepadanya".',
      quoteFrom: '(Ar-Ruum Ayat 21)',
      regards: 'Assalamu\'alaikum Wr. Wb.',
      greeting:
          'Dengan memohon rahmat dan ridho Allah Subhanahu Wa Ta\'ala. Kami mengundang Bapak/Ibu/Saudara/I, untuk menghadiri resepsi pernikahan kami.',
      closing:
          'Merupakan suatu kehormatan dan kebahagiaan bagi kami apabila Bapak/Ibu/Saudara/i berkenan hadir dan memberikan doa restu untuk pernikahan kami. Atas kehadiran dan doa restunya, kami mengucapkan terima kasih.',
    ),
    bride: const BridegroomResponse(
      id: 1,
      imageUrl: '',
      nickname: 'Rahma',
      fullName: 'Rahma Nur Istiqomah',
      backTitle: 'M.Biomed',
      fatherName: 'Bagyo Trisno Ngulandoro',
      fatherBackTitle: 'S.T',
      motherName: 'Peni Lestari',
      motherBackTitle: 'S.E',
    ),
    groom: const BridegroomResponse(
      id: 2,
      imageUrl: '',
      nickname: 'Faiq',
      fullName: 'Faiq Ulul Fahmi',
      backTitle: 'S.Pd',
      fatherName: 'Syamsuddin',
      fatherBackTitle: 'S.Pd.I',
      motherName: 'Sa\'idah',
    ),
    contractEvent: EventResponse(
      id: 1,
      startTime: DateTime(2025, 10, 10, 9, 0),
      place: 'Masjid Raya Bani Umar',
      address: 'Jl. Graha Raya Bintaro Kv. GK 4 No. 2-4, Pondok Aren, Tangerang Selatan',
      mapsUrl:
          'https://www.google.com/maps/place/Masjid+Raya+Bani+Umar+-+Tangerang+Selatan/@-6.2705383,106.6944082,16.87z/data=!4m6!3m5!1s0x2e69faf062460ed5:0xc46eba6617b311d6!8m2!3d-6.2703756!4d106.6893305!16s%2Fg%2F1pztc44x6?entry=ttu&g_ep=EgoyMDI1MDgwNS4wIKXMDSoASAFQAw%3D%3D',
    ),
    receptionEvent: EventResponse(
      id: 1,
      startTime: DateTime(2025, 10, 10, 10, 0),
      place: 'Masjid Raya Bani Umar',
      address: 'Jl. Graha Raya Bintaro Kv. GK 4 No. 2-4, Pondok Aren, Tangerang Selatan',
      mapsUrl:
          'https://www.google.com/maps/place/Masjid+Raya+Bani+Umar+-+Tangerang+Selatan/@-6.2705383,106.6944082,16.87z/data=!4m6!3m5!1s0x2e69faf062460ed5:0xc46eba6617b311d6!8m2!3d-6.2703756!4d106.6893305!16s%2Fg%2F1pztc44x6?entry=ttu&g_ep=EgoyMDI1MDgwNS4wIKXMDSoASAFQAw%3D%3D',
    ),
    bankAccounts: const [
      BankAccountResponse(id: 1, bankName: 'Bank Central Asia (BCA)', accountName: 'Rahma Nur Istiqomah', number: '485439574'),
      BankAccountResponse(
        id: 1,
        bankName: 'Bank Negara Indonesia (BNI)',
        accountName: 'Rahma Nur Istiqomah',
        number: '33854986435848',
      ),
      BankAccountResponse(
        id: 1,
        bankName: 'Bank Rakyat Indonesia (BRI)',
        accountName: 'Faiq Ulul Fahmi',
        number: '33854439745427',
      ),
    ],
  );
}
