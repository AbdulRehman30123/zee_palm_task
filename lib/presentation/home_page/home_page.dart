// home_page.dart
import 'package:zee_palm_task/constants/constants.dart';
import 'package:zee_palm_task/controllers/home_controller.dart';
import 'package:zee_palm_task/models/video_model.dart';
import 'package:zee_palm_task/packages/packages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Zee Palm',
          style: GoogleFonts.poppins(
            fontSize: isWeb ? 24 : 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F2937),
          ),
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Color(0xFF1F2937)),
        actions: [
          IconButton(
            onPressed: controller.refreshVideos,
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: _buildDrawer(controller, isWeb),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildLoadingState();
        }

        if (controller.hasError.value) {
          return _buildErrorState(controller);
        }

        if (controller.videos.isEmpty) {
          return _buildEmptyState();
        }

        return _buildVideoList(controller, isWeb);
      }),
    );
  }

  Widget _buildDrawer(HomeController controller, bool isWeb) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Drawer Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isWeb ? 32 : 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF667eea),
                  Color(0xFF764ba2),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: isWeb ? 35 : 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: isWeb ? 35 : 30,
                      color: const Color(0xFF667eea),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Text(
                  //   controller.authController.getCurrentUserEmail() ?? 'User',
                  //   style: GoogleFonts.poppins(
                  //     fontSize: isWeb ? 16 : 14,
                  //     fontWeight: FontWeight.w600,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  const SizedBox(height: 4),
                  Text(
                    'Welcome back!',
                    style: GoogleFonts.poppins(
                      fontSize: isWeb ? 14 : 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Drawer Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: isWeb ? 16 : 12),
              children: [
                _buildDrawerItem(
                  icon: Icons.upload_rounded,
                  title: 'Upload Video',
                  onTap: controller.navigateToUpload,
                  isWeb: isWeb,
                ),
                _buildDrawerItem(
                  icon: Icons.account_circle_outlined,
                  title: 'Account Information',
                  onTap: controller.navigateToAccount,
                  isWeb: isWeb,
                ),
                const Divider(height: 32),
                _buildDrawerItem(
                  icon: Icons.logout,
                  title: 'Sign Out',
                  onTap: () {
                    authService.signOut();
                  },
                  isWeb: isWeb,
                  isDestructive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isWeb,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color:
            isDestructive ? const Color(0xFFEF4444) : const Color(0xFF6B7280),
        size: isWeb ? 24 : 22,
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: isWeb ? 16 : 14,
          fontWeight: FontWeight.w500,
          color:
              isDestructive ? const Color(0xFFEF4444) : const Color(0xFF1F2937),
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(
        horizontal: isWeb ? 24 : 20,
        vertical: 4,
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: SpinKitThreeBounce(
        color: Color(0xFF667eea),
        size: 40,
      ),
    );
  }

  Widget _buildErrorState(HomeController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Color(0xFFEF4444),
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Unable to load videos',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF6B7280),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.fetchVideos,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF667eea),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Try Again',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.video_library_outlined,
              size: 64,
              color: Color(0xFF9CA3AF),
            ),
            const SizedBox(height: 16),
            Text(
              'No videos yet',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Be the first to upload a video!',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoList(HomeController controller, bool isWeb) {
    return RefreshIndicator(
      onRefresh: controller.refreshVideos,
      color: const Color(0xFF667eea),
      child: ListView.builder(
        padding: EdgeInsets.all(isWeb ? 16 : 12),
        itemCount: controller.videos.length,
        itemBuilder: (context, index) {
          final video = controller.videos[index];
          return VideoCard(video: video, isWeb: isWeb);
        },
      ),
    );
  }
}

// video_card.dart
class VideoCard extends StatelessWidget {
  final VideoModel video;
  final bool isWeb;

  const VideoCard({
    super.key,
    required this.video,
    required this.isWeb,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isWeb ? 20 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Player Section
          Container(
            width: double.infinity,
            height: isWeb ? 300 : 200,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Stack(
                children: [
                  // Thumbnail
                  if (video.thumbnailUrl.isNotEmpty)
                    Image.network(
                      video.thumbnailUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildVideoPlaceholder();
                      },
                    )
                  else
                    _buildVideoPlaceholder(),

                  // Play Button Overlay
                  Center(
                    child: GestureDetector(
                      onTap: () => _playVideo(video.videoUrl),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Video Info
          Padding(
            padding: EdgeInsets.all(isWeb ? 20 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  style: GoogleFonts.poppins(
                    fontSize: isWeb ? 18 : 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2937),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  video.description,
                  style: GoogleFonts.poppins(
                    fontSize: isWeb ? 14 : 12,
                    color: const Color(0xFF6B7280),
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: const Color(0xFF667eea),
                      child: Text(
                        video.uploaderName.isNotEmpty
                            ? video.uploaderName[0].toUpperCase()
                            : 'U',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video.uploaderName,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                          Text(
                            _formatDate(video.uploadedAt),
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Stats
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 16,
                          color: const Color(0xFF9CA3AF),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${video.views}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.favorite,
                          size: 16,
                          color: const Color(0xFF9CA3AF),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${video.likes}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlaceholder() {
    return Container(
      color: const Color(0xFF1F2937),
      child: const Center(
        child: Icon(
          Icons.video_library,
          color: Colors.white54,
          size: 48,
        ),
      ),
    );
  }

  void _playVideo(String videoUrl) {
    if (videoUrl.isNotEmpty) {
      // Here you can integrate with video_player package or any other video player
      // For now, we'll show a snackbar
      Get.snackbar(
        'Video Player',
        'Playing: ${video.title}',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Example integration with video player:
      // Get.to(() => VideoPlayerScreen(videoUrl: videoUrl));
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
