import 'package:social_share/social_share.dart';

class ShareList {
  final String title, image, link;
  final int id;

  final Future<dynamic> share;

  ShareList({
    required this.id,
    required this.title,
    required this.link,
    required this.image,
    required this.share,
  });
}

List<ShareList> shareList = [
  ShareList(
      id: 0,
      title: "WhatsApp",
      image: "assets/Ipng/Whatsapp.png",
      link: "",
      share: SocialShare.shareWhatsapp("content")),
  // ShareList(
  //   id: 1,
  //   title: "IG Feed",
  //   image: Foundation.alert,
  //   link: "",
  // ),
  // ShareList(
  //   id: 2,
  //   title: "IG Stories",
  //   image: Foundation.alert,
  //   link: "",
  // ),
  // ShareList(
  //   id: 3,
  //   title: "Facebook",
  //   image: Foundation.alert,
  //   link: "",
  // ),
  // ShareList(
  //   id: 4,
  //   title: "FB Messenger",
  //   image: Foundation.alert,
  //   link: "",
  // ),
  // ShareList(
  //   id: 5,
  //   title: "Twitter",
  //   image: Foundation.alert,
  //   link: "",
  // ),
  // ShareList(
  //     id: 6,
  //     title: "Line",
  //     image: "assets/Ipng/Line.png",
  //     link: "",
  //     share: SocialShare.share("content")),
  ShareList(
      id: 7,
      title: "Telegram",
      image: "assets/Ipng/Telegram.png",
      link: "",
      share: SocialShare.shareTelegram("content")),
  ShareList(
      id: 8,
      title: "Copy Link",
      image: "assets/Ipng/Copy Link.png",
      link: "",
      share: SocialShare.copyToClipboard(
        "content",
      )),
  // ShareList(
  //   id: 9,
  //   title: "More",
  //   image: "assets/Ipng/More.png",
  //   link: "",
  //   share: SocialShare.checkInstalledAppsForShare(),
  // ),
];
