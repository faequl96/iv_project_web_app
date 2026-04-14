import 'package:iv_project_model/iv_project_model.dart';

class Dummys {
  const Dummys._();

  static late final InvitationDataResponse invitationData;

  static void initInvitationData() {
    final nowPlus30 = DateTime.now().add(const Duration(days: 30));
    invitationData = InvitationDataResponse(
      id: 1,
      general: const GeneralResponse(
        id: 1,
        lang: LangType.id,
        coverImageUrl: 'assets/dummys/cover_image.png',
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
        imageUrl: 'assets/dummys/bride_image.png',
        nickname: 'Milea',
        fullName: 'Milea Adnan Hussain',
        frontTitle: 'dr',
        backTitle: 'M.Biomed',
        fatherFrontTitle: 'Letkol',
        fatherName: 'Adnan',
        motherName: 'Marissa Kusumarini',
        motherBackTitle: 'S.H',
      ),
      groom: const BridegroomResponse(
        id: 2,
        imageUrl: 'assets/dummys/groom_image.png',
        nickname: 'Dilan',
        fullName: 'Dilan',
        backTitle: 'M.Sn',
        fatherFrontTitle: 'Letkol',
        fatherName: 'Faisal',
        motherName: 'Bunda Hara',
        motherBackTitle: 'S.Pd',
      ),
      contractEvent: EventResponse(
        id: 1,
        startTime: DateTime(nowPlus30.year, nowPlus30.month, nowPlus30.day, 8, 30),
        endTime: DateTime(nowPlus30.year, nowPlus30.month, nowPlus30.day, 9, 30),
        place: 'The Papandayan Hotel',
        address: 'Jalan Gatot Subroto, Malabar, Kota Bandung, Jawa Barat',
        latitude: '-6.9231456',
        longitude: '107.6237581',
        mapsUrl:
            'https://www.google.com/maps/place/The+Papandayan+Hotel,+Jalan+Gatot+Subroto,+Malabar,+Kota+Bandung,+Jawa+Barat/@-6.3012864,106.7778048,12z/data=!4m5!3m4!1s0x2e68e7d4924de9db:0x7fedfb7ec623192d!8m2!3d-6.9231456!4d107.6237581?entry=ttu&g_ep=EgoyMDI2MDIwNC4wIKXMDSoASAFQAw%3D%3D',
      ),
      receptionEvent: EventResponse(
        id: 1,
        startTime: DateTime(nowPlus30.year, nowPlus30.month, nowPlus30.day, 9, 30),
        place: 'The Papandayan Hotel',
        address: 'Jalan Gatot Subroto, Malabar, Kota Bandung, Jawa Barat',
        latitude: '-6.9231456',
        longitude: '107.6237581',
        mapsUrl:
            'https://www.google.com/maps/place/The+Papandayan+Hotel,+Jalan+Gatot+Subroto,+Malabar,+Kota+Bandung,+Jawa+Barat/@-6.3012864,106.7778048,12z/data=!4m5!3m4!1s0x2e68e7d4924de9db:0x7fedfb7ec623192d!8m2!3d-6.9231456!4d107.6237581?entry=ttu&g_ep=EgoyMDI2MDIwNC4wIKXMDSoASAFQAw%3D%3D',
      ),
      gallery: const GalleryResponse(
        id: 1,
        imageURL1: 'assets/dummys/gallery_image_1.jpg',
        imageURL2: 'assets/dummys/gallery_image_2.jpg',
        imageURL3: 'assets/dummys/gallery_image_3.jpg',
        imageURL4: 'assets/dummys/gallery_image_4.jpg',
        imageURL5: 'assets/dummys/gallery_image_5.jpg',
        imageURL6: 'assets/dummys/gallery_image_6.jpg',
        imageURL7: 'assets/dummys/gallery_image_7.jpg',
        imageURL8: 'assets/dummys/gallery_image_8.jpg',
        imageURL9: 'assets/dummys/gallery_image_9.jpg',
        imageURL10: 'assets/dummys/gallery_image_10.jpg',
        imageURL11: 'assets/dummys/gallery_image_11.jpg',
      ),
      bankAccounts: const [
        BankAccountResponse(id: 1, bankName: 'Bank Central Asia (BCA)', accountName: 'Milea Adnan Hussain', number: '485439574'),
        BankAccountResponse(
          id: 1,
          bankName: 'Bank Negara Indonesia (BNI)',
          accountName: 'Milea Adnan Hussain',
          number: '33854986435848',
        ),
        BankAccountResponse(id: 1, bankName: 'Bank Rakyat Indonesia (BRI)', accountName: 'Dilan', number: '33854439745427'),
      ],
    );
  }
}
