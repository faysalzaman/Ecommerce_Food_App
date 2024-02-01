import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce_app/Bloc/Review/review_bloc.dart';
import 'package:food_ecommerce_app/Model/Review/get_all_review_model.dart';
import 'package:food_ecommerce_app/Utils/constants.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({
    super.key,
    required this.foodId,
    required this.userId,
  });

  final String foodId;
  final String userId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  TextEditingController controller = TextEditingController();

  ReviewBloc fetchAllReview = ReviewBloc();

  @override
  void initState() {
    super.initState();
    fetchAllReview.add(
      FetchReviewEvent(
        foodId: widget.foodId,
        page: page.toString(),
        pageSize: "10",
      ),
    );
  }

  int page = 1;

  List<GetAllReviewModel> review = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: BlocConsumer<ReviewBloc, ReviewState>(
        bloc: fetchAllReview,
        listener: (context, state) {
          if (state is FetchReviewLoadedState) {
            review.addAll(state.review);
            page++;
          }
        },
        builder: (context, state) {
          if (state is FetchReviewErrorState) {
            return Center(
              child: CachedNetworkImage(
                imageUrl: "https://www.denmakers.in/img/no-review-found.png",
                fit: BoxFit.cover,
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: review.length + 1,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    if (index == review.length) {
                      return review.length % 10 != 0
                          ? Container()
                          : state is ReviewLoadingState
                              ? Container()
                              : Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                  child: ElevatedButton(
                                    child: const Text('Load More'),
                                    onPressed: () {
                                      fetchAllReview.add(
                                        FetchReviewEvent(
                                          foodId: widget.foodId,
                                          page: "$page",
                                          pageSize: "10",
                                        ),
                                      );
                                    },
                                  ),
                                );
                    }
                    return ListTile(
                      title: Text(review[index].userId!.fullname!),
                      subtitle: Text(review[index].text!),
                      leading: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          review[index].userId!.profileImage!,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.grey[300],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: controller,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Write your review here',
                    suffixIcon: IconButton(
                      onPressed: () {
                        fetchAllReview.add(
                          PostReviews(
                            userId: widget.userId,
                            foodId: widget.foodId,
                            text: controller.text.trim(),
                          ),
                        );
                        controller.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
