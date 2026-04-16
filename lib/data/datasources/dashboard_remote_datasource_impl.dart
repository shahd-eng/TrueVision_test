import '../models/recent_detection_model.dart';
import '../models/trending_item_model.dart';
import '../models/user_model.dart';
import 'dashboard_remote_datasource.dart';

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  @override
  Future<UserModel> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return const UserModel(name: 'Ahmed Magdy', avatarPath: null);
  }

  @override
  Future<TrendingItemModel?> getTrendingItem() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return const TrendingItemModel(
      id: '1',
      title: 'Viral Political Deepfake Detected',
      description:
          'Manipulated video showing false statements spreading across social platforms. Verified as 94% AI-generated.',
      imagePath: 'assets/images/img.png',
      isAiGenerated: true,
      views: '2.4M views',
      shares: '18K shares',
      aiConfidence: 0.94,
    );
  }

  @override
  Future<List<RecentDetectionModel>> getRecentDetections() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return const [
      RecentDetectionModel(
        id: '1',
        label: 'Face Swap',
        platform: 'Instagram',
        title: 'AI-Enhanced Selfie',
        subtitle: 'Digital beauty filter with AI enhancement detected.',
        imagePath: 'assets/images/user.png',
      ),
      RecentDetectionModel(
        id: '2',
        label: 'Deepfake',
        platform: 'TikTok',
        title: 'Fake News Anchor Video',
        subtitle: 'AI-generated news report spreading misinformation.',
        imagePath: 'assets/images/img (2).png',
      ),
      RecentDetectionModel(
        id: '3',
        label: 'Synthetic',
        platform: 'Facebook',
        title: 'AI Model in Advertisement',
        subtitle: 'Synthetic model used in product promotion.',
        imagePath: 'assets/images/img (3).png',
      ),
      RecentDetectionModel(
        id: '4',
        label: 'Deepfake',
        platform: 'Twitter',
        title: 'Political Figure Manipulation',
        subtitle: 'Fabricated speech video with high manipulation score.',
        imagePath: 'assets/images/img (4).png',
      ),
      RecentDetectionModel(
        id: '5',
        label: 'Enhanced',
        platform: 'Instagram',
        title: 'AI-Enhanced Selfie',
        subtitle: 'Digital beauty filter with AI enhancement detected.',
        imagePath: 'assets/images/img (5).png',
      ),
    ];
  }
}
