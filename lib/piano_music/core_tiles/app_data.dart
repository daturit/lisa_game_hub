import 'package:flutter/material.dart';

import '../utils_game/music_color.dart';
import '../utils_game/music_model.dart';
import 'app_asset.dart';

class AppData {
  const AppData._();

  static const dummyText = '';

  static List<String> themeList = [
     "background1.jpg", "game1.jpg", "game2.jpg","background5.jpg","background6.jpg",
    "background7.jpg","background8.jpg", "background9.jpg","background6.jpg", "background111.jpg",
  ];
  static List<String> tilesList = [
    "tiles1.png", "tiles2.png", "tiles3.png", "tiles4.png", "tiles5.png", "tiles6.png", "tiles7.png",
    "tiles8.png","tiles9.png", "tiles10.png", "tiles11.png",
  ];

  static MusicModel mainMusic = MusicModel(
    quantity: 1,
    isFavorite: false,
    title: 'Stick Together',
    description: dummyText,
    price: 'stick_together.mov',
    score: 4.5,
    images: [
      AppAsset.comharStandingDesk7,
    ],
    colors: <MusicColor>[
      MusicColor(color: const Color(0xFF5d4037), isSelected: true),
      MusicColor(color: const Color(0xFF455a64)),
    ],
  );

  static List<MusicModel> furnitureList = [

    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Stick Together',
      description: dummyText,
      price: 'stick_together.mov',
      score: 4.5,
      images: [
        AppAsset.comharStandingDesk7,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),

    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Nothing on you',
      description: dummyText,
      price: 'nothing_on_you.mov',
      score: 4.8,
      images: [
        AppAsset.comharStandingDesk1,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      isFavorite: false,
      quantity: 1,
      title: 'Like A Cat',
      description: dummyText,
      price: 'like_a_cat.mov',
      score: 4.4,
      images: [
        AppAsset.comharStandingDesk5,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF424242)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Gee',
      description: dummyText,
      price: 'gee.mov',
      score: 4.8,
      images: [
        AppAsset.comharStandingDesk7,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF616161), isSelected: true),
        MusicColor(color: const Color(0xFF212121)),
      ],
    ),

    MusicModel(
      isFavorite: false,
      quantity: 1,
      title: 'Faded',
      description: dummyText,
      price: 'faded.mov',
      score: 5.0,
      images: [
        AppAsset.comharStandingDesk2,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF424242)),
      ],
    ),

    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Force',
      description: dummyText,
      price: 'force.mov',
      score: 5.0,
      images: [
        AppAsset.comharStandingDesk3,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF616161), isSelected: true),
        MusicColor(color: const Color(0xFF212121)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'All Falls Down',
      description: dummyText,
      price: 'all_falls_down.mov',
      score: 4.5,
      images: [
        AppAsset.comharStandingDesk7,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF455a64), isSelected: true),
        MusicColor(color: const Color(0xFF263238)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Ignite',
      description: dummyText,
      price: 'ignite.mov',
      score: 4.8,
      images: [
        AppAsset.comharStandingDesk6,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),

    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Sing me to sleep',
      description: dummyText,
      price: 'sing_me_to_sleep.mov',
      score: 4.8,
      images: [
        AppAsset.comharStandingDesk1,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),

    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Sky',
      description: dummyText,
      price: 'sky.mov',
      score: 3.8,
      images: [
        AppAsset.comharStandingDesk2,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Stronget',
      description: dummyText,
      price: 'stronget.mov',
      score: 3.6,
      images: [
        AppAsset.comharStandingDesk3,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'The Spectre',
      description: dummyText,
      price: 'the_spectre.mov',
      score: 4.8,
      images: [
        AppAsset.comharStandingDesk4,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Tired',
      description: dummyText,
      price: 'tired.mov',
      score: 4.9,
      images: [
        AppAsset.comharStandingDesk5,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'We wish you a merry christmas',
      description: dummyText,
      price: 'we_wish_you_a_merry_christmas.mov',
      score: 4.5,
      images: [
        AppAsset.comharStandingDesk6,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF455a64), isSelected: true),
        MusicColor(color: const Color(0xFF263238)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Bella Ciao',
      description: dummyText,
      price: 'bella_ciao.mov',
      score: 4.5,
      images: [
        AppAsset.comharStandingDesk4,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF455a64), isSelected: true),
        MusicColor(color: const Color(0xFF263238)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Lily',
      description: dummyText,
      price: 'lily.mov',
      score: 3.8,
      images: [
        AppAsset.comharStandingDesk5,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Happy Birthday',
      description: dummyText,
      price: 'happy_birthday.mov',
      score: 4.5,
      images: [
        AppAsset.comharStandingDesk1,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF616161), isSelected: true),
        MusicColor(color: const Color(0xFF424242)),
      ],
    ),
    MusicModel(
      isFavorite: false,
      quantity: 1,
      title: 'Happy New Year',
      description: dummyText,
      price: 'happy_new_year.mov',
      score: 4.5,
      images: [
        AppAsset.comharStandingDesk2,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF424242)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Jingle Bell Rock',
      description: dummyText,
      price: 'jngle_bell_rock.mov',
      score: 5.0,
      images: [
        AppAsset.comharStandingDesk3,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF616161), isSelected: true),
        MusicColor(color: const Color(0xFF212121)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'London Bridge',
      description: dummyText,
      price: 'london_brigde.mov',
      score: 4.6,
      images: [
        AppAsset.comharStandingDesk4,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF455a64), isSelected: true),
        MusicColor(color: const Color(0xFF263238)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Moonlight Sonata',
      description: dummyText,
      price: 'moonlight_sonata.mov',
      score: 4.8,
      images: [
        AppAsset.comharStandingDesk5,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF455a64), isSelected: true),
        MusicColor(color: const Color(0xFF263238)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Two Tigers',
      description: dummyText,
      price: 'two_tigers.mov',
      score: 4.5,
      images: [
        AppAsset.comharStandingDesk6,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF455a64), isSelected: true),
        MusicColor(color: const Color(0xFF263238)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Fur Elise',
      description: dummyText,
      price: 'fur_elise.mov',
      score: 4.7,
      images: [
        AppAsset.comharStandingDesk7,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF455a64), isSelected: true),
        MusicColor(color: const Color(0xFF263238)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Abcdefu',
      description: dummyText,
      price: 'abcdefu.mov',
      score: 4.5,
      images: [
        AppAsset.tiktok1,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF616161), isSelected: true),
        MusicColor(color: const Color(0xFF424242)),
      ],
    ),
    MusicModel(
      isFavorite: false,
      quantity: 1,
      title: 'Astronaut In The Ocean',
      description: dummyText,
      price: 'astronaut_in_the_ocean.mov',
      score: 4.5,
      images: [
        AppAsset.tiktok2,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF424242)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Inferno',
      description: dummyText,
      price: 'inferno.mov',
      score: 3.9,
      images: [
        AppAsset.tiktok3,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF616161), isSelected: true),
        MusicColor(color: const Color(0xFF212121)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Let me down slowly',
      description: dummyText,
      price: 'let_me_down_slowly.mov',
      score: 4.5,
      images: [
        AppAsset.tiktok4,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF455a64), isSelected: true),
        MusicColor(color: const Color(0xFF263238)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Save you again',
      description: dummyText,
      price: 'save_you_again.mov',
      score: 4.8,
      images: [
        AppAsset.tiktok5,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Leyla',
      description: dummyText,
      price: 'leyla.mov',
      score: 4.8,
      images: [
        AppAsset.tiktok6,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'We dont talk anymore',
      description: dummyText,
      price: 'we_dont_talk_anymore.mov',
      score: 4.8,
      images: [
        AppAsset.tiktok2,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Nothing on you',
      description: dummyText,
      price: 'nothing_on_you.mov',
      score: 4.8,
      images: [
        AppAsset.tiktok3,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'How to love',
      description: dummyText,
      price: 'how_to_love.mov',
      score: 4.8,
      images: [
        AppAsset.tiktok4,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Stick Together',
      description: dummyText,
      price: 'stick_together.mov',
      score: 4.5,
      images: [
        AppAsset.tiktok1,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'La La La',
      description: dummyText,
      price: 'la_la_la.mov',
      score: 4.6,
      images: [
        AppAsset.tiktok2,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
  ];

  static List<MusicModel> furnitureListTiktok = [
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Abcdefu',
      description: dummyText,
      price: 'abcdefu.mov',
      score: 4.5,
      images: [
        AppAsset.tiktok1,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF616161), isSelected: true),
        MusicColor(color: const Color(0xFF424242)),
      ],
    ),
    MusicModel(
      isFavorite: false,
      quantity: 1,
      title: 'Astronaut In The Ocean',
      description: dummyText,
      price: 'astronaut_in_the_ocean.mov',
      score: 4.5,
      images: [
        AppAsset.tiktok2,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF424242)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Inferno',
      description: dummyText,
      price: 'inferno.mov',
      score: 3.9,
      images: [
        AppAsset.tiktok3,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF616161), isSelected: true),
        MusicColor(color: const Color(0xFF212121)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Let me down slowly',
      description: dummyText,
      price: 'let_me_down_slowly.mov',
      score: 4.5,
      images: [
        AppAsset.tiktok4,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF455a64), isSelected: true),
        MusicColor(color: const Color(0xFF263238)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Save you again',
      description: dummyText,
      price: 'save_you_again.mov',
      score: 4.8,
      images: [
        AppAsset.tiktok5,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Leyla',
      description: dummyText,
      price: 'leyla.mov',
      score: 4.8,
      images: [
        AppAsset.tiktok6,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'We dont talk anymore',
      description: dummyText,
      price: 'we_dont_talk_anymore.mov',
      score: 4.8,
      images: [
        AppAsset.tiktok2,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Nothing on you',
      description: dummyText,
      price: 'nothing_on_you.mov',
      score: 4.8,
      images: [
        AppAsset.tiktok3,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'How to love',
      description: dummyText,
      price: 'how_to_love.mov',
      score: 4.8,
      images: [
        AppAsset.tiktok4,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Stick Together',
      description: dummyText,
      price: 'stick_together.mov',
      score: 4.5,
      images: [
        AppAsset.tiktok1,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'La La La',
      description: dummyText,
      price: 'la_la_la.mov',
      score: 4.6,
      images: [
        AppAsset.tiktok2,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
  ];

  static List<MusicModel> furnitureListNewMusic = [
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'We wish you a merry christmas',
      description: dummyText,
      price: 'we_wish_you_a_merry_christmas.mov',
      score: 4.5,
      images: [
        AppAsset.comharStandingDesk6,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF455a64), isSelected: true),
        MusicColor(color: const Color(0xFF263238)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Bella Ciao',
      description: dummyText,
      price: 'bella_ciao.mov',
      score: 4.5,
      images: [
        AppAsset.comharStandingDesk4,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF455a64), isSelected: true),
        MusicColor(color: const Color(0xFF263238)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Lily',
      description: dummyText,
      price: 'lily.mov',
      score: 3.8,
      images: [
        AppAsset.comharStandingDesk5,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF455a64)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Happy Birthday',
      description: dummyText,
      price: 'happy_birthday.mov',
      score: 4.5,
      images: [
        AppAsset.comharStandingDesk1,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF616161), isSelected: true),
        MusicColor(color: const Color(0xFF424242)),
      ],
    ),
    MusicModel(
      isFavorite: false,
      quantity: 1,
      title: 'Happy New Year',
      description: dummyText,
      price: 'happy_new_year.mov',
      score: 4.5,
      images: [
        AppAsset.comharStandingDesk2,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF5d4037), isSelected: true),
        MusicColor(color: const Color(0xFF424242)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Jingle Bell Rock',
      description: dummyText,
      price: 'jngle_bell_rock.mov',
      score: 5.0,
      images: [
        AppAsset.comharStandingDesk3,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF616161), isSelected: true),
        MusicColor(color: const Color(0xFF212121)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'London Bridge',
      description: dummyText,
      price: 'london_brigde.mov',
      score: 4.6,
      images: [
        AppAsset.comharStandingDesk4,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF455a64), isSelected: true),
        MusicColor(color: const Color(0xFF263238)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Moonlight Sonata',
      description: dummyText,
      price: 'moonlight_sonata.mov',
      score: 4.8,
      images: [
        AppAsset.comharStandingDesk5,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF455a64), isSelected: true),
        MusicColor(color: const Color(0xFF263238)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Two Tigers',
      description: dummyText,
      price: 'two_tigers.mov',
      score: 4.5,
      images: [
        AppAsset.comharStandingDesk6,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF455a64), isSelected: true),
        MusicColor(color: const Color(0xFF263238)),
      ],
    ),
    MusicModel(
      quantity: 1,
      isFavorite: false,
      title: 'Fur Elise',
      description: dummyText,
      price: 'fur_elise.mov',
      score: 4.7,
      images: [
        AppAsset.comharStandingDesk7,
      ],
      colors: <MusicColor>[
        MusicColor(color: const Color(0xFF455a64), isSelected: true),
        MusicColor(color: const Color(0xFF263238)),
      ],
    ),
  ];
}
